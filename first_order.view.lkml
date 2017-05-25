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
      order_sequence.total_price as first_purchase_price
      FROM ${order_sequence.SQL_TABLE_NAME} as order_sequence
      WHERE order_sequence.order_sequence = 1;;

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

  dimension: first_purchase_price_dim {
    type: number
    sql: ${TABLE}.total_price ;;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }

    dimension: first_purchase_price_grouping {
      type: string
      sql: CASE WHEN ${TABLE}.first_purchase_price < 10 THEN '01. Under $10'
              WHEN ${TABLE}.first_purchase_price < 20 THEN '02. $10 - $19.99'
              WHEN ${TABLE}.first_purchase_price < 30 THEN '03. $20 - $29.99'
              WHEN ${TABLE}.first_purchase_price < 40 THEN '04. $30 - $39.99'
              WHEN ${TABLE}.first_purchase_price < 50 THEN '05. $40 - $49.99'
              WHEN ${TABLE}.first_purchase_price < 60 THEN '06. $50 - $59.99'
              WHEN ${TABLE}.first_purchase_price < 70 THEN '07. $60 - $69.99'
              WHEN ${TABLE}.first_purchase_price < 80 THEN '08. $70 - $79.99'
              WHEN ${TABLE}.first_purchase_price < 90 THEN '09. $80 - $89.99'
              WHEN ${TABLE}.first_purchase_price < 100 THEN '10. $90 - $99.99'
              WHEN ${TABLE}.first_purchase_price >= 100 THEN '11. $100 +'
              ELSE '12. Null' END ;;
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
