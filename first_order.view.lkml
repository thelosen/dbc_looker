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
    hidden:  yes
    timeframes: [time, date, week, month, raw, year, quarter]
    sql: ${TABLE}.created_at ;;
  }

    dimension_group: first_order_created {
      type: time
      timeframes: [time, date, week, month, raw, year, quarter]
      sql: ${TABLE}.created_at ;;
    }

  dimension: first_purchase_price_dim {
    type: number
    hidden: yes
    sql: ${TABLE}.total_price ;;
  }

    dimension: first_order_price_dim {
      type: number
      sql: ${TABLE}.total_price ;;
    }

  dimension: user_id {
    hidden: yes
    type: number
    sql: ${TABLE}.user_id ;;
  }

    dimension: first_purchase_price_grouping {
      hidden: yes
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

    dimension: first_order_price_grouping {
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

    dimension: first_order_price_grouping_non_kit_check {
      type: string
      sql: CASE WHEN ${TABLE}.first_purchase_price < 30.50 THEN 'A. Under $30.50'
              WHEN ${TABLE}.first_purchase_price < 35.5 THEN 'B. $30.50 - $35.49'
              WHEN ${TABLE}.first_purchase_price < 40.5 THEN 'C. $35.50 - $40.49'
              WHEN ${TABLE}.first_purchase_price < 45.5 THEN 'D. $40.50 - $45.49'
              WHEN ${TABLE}.first_purchase_price < 50.5 THEN 'E. $45.50 - $50.49'
              WHEN ${TABLE}.first_purchase_price < 55.5 THEN 'F. $50.50 - $55.49'
              WHEN ${TABLE}.first_purchase_price < 60.5 THEN 'G. $55.50 - $60.49'
              WHEN ${TABLE}.first_purchase_price >= 60.5 THEN 'H. $60.50 +'
              ELSE 'I. Null' END ;;
    }


################# Measures #######################
  measure: first_order_total {
    type: sum
    sql: cast(${TABLE}.total_price as float) ;;
    value_format_name: usd
  }

 measure: order_count {
    type: count_distinct
    sql: ${TABLE}.id ;;
    hidden:  yes
  }

}
