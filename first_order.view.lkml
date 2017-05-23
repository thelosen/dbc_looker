# getting the earliest order for each user

  view: first_order {
    derived_table: {
      distribution_style: even
      sortkeys: ["id"]
      sql_trigger_value: SELECT COUNT(*) FROM ${order_sequence.SQL_TABLE_NAME};;
      sql:
      Select
      order_sequence.id as id,
      order_sequence.user_id as user_id,
      order_sequence.created_at as created_at,
      order_sequence.total_price as total_price
      FROM ${order_sequence.SQL_TABLE_NAME} as order_sequence
      WHERE order_sequence.sequence = 1;;

  }

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: created {
    type: time
    timeframes: [time, date, week, month, raw, year, quarter]
    sql: ${TABLE}.created_at ;;
  }

  dimension: total_price {
    type: number
    sql: ${TABLE}.total_price ;;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }

    dimension: first_purchase_price {
      type: string
      sql: CASE WHEN ${TABLE}.total_price < 5 THEN '1. Under $5'
              WHEN ${TABLE}.total_price < 10 THEN '2. $5 - $9.99'
              WHEN ${TABLE}.total_price < 15 THEN '3. $10 - $14.99'
              WHEN ${TABLE}.total_price < 20 THEN '4. $15 - $20'
              WHEN ${TABLE}.total_price < 30 THEN '5. $20 - $29.99'
              WHEN ${TABLE}.total_price < 40 THEN '6. $30 - $39.99'
              WHEN ${TABLE}.total_price < 50 THEN '7. $40 - $49.99'
              WHEN ${TABLE}.total_price < 60 THEN '8. $50 - $59.99'
              WHEN ${TABLE}.total_price < 70 THEN '9. $60 - $69.99'
              WHEN ${TABLE}.total_price < 80 THEN '10. $70 - $79.99'
              WHEN ${TABLE}.total_price < 90 THEN '11. $80 - $89.99'
              WHEN ${TABLE}.total_price >= 90 THEN '12. $90 +'
              ELSE '13. Null' END ;;
    }


################# Measures #######################
  measure: order_total {
    type: sum
    sql: cast(${TABLE}.total_price as float) ;;
    value_format_name: usd
    hidden: yes
  }

 measure: order_count {
    type: count_distinct
    sql: ${TABLE}.id ;;
    hidden:  yes
  }

}
