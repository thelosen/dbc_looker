
view: order_sequence {
  derived_table: {
    distribution_style: even
    sortkeys: ["id"]
    sql_trigger_value: SELECT COUNT(*) FROM ${shop_orders.SQL_TABLE_NAME};;
    sql:  SELECT id
          , order_sequence
          , user_id
          FROM
          (SELECT id
          , created_at
          , user_id
          , ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY created_at)
          as order_sequence
          , total_price
          FROM ${shop_orders.SQL_TABLE_NAME});;
 }

  ################## Dimensions #######################

  dimension: id {
    type: number
    primary_key: yes
    hidden: yes
  }

  dimension: order_sequence {
    type:  number
  }

  dimension: user_id {
    type:  number
    hidden: yes
  }

  dimension: total_price {
    type: number
    sql: ${TABLE}.total_price ;;
    hidden: yes
  }

  dimension_group: created {
    type: time
    hidden: yes
    timeframes: [time, date, week, month, raw, year, quarter]
    sql: ${TABLE}.created_at ;;
  }

  dimension: is_first_order {
    type: yesno
    sql: ${order_sequence} = 1;;
  }

  dimension: is_renew_order {
    type: yesno
    sql: ${order_sequence} >= 2;;
  }

  dimension: first_order_amount_grouping {
      view_label: "pdt_user_fact"
      type: string
      sql:  CASE WHEN ${TABLE}.order_sequence = 1 AND ${TABLE}.total_price < 5 THEN '1. Under $5'
              WHEN  ${TABLE}.order_sequence = 1 AND ${TABLE}.total_price < 10 THEN '2. $5 - $9.99'
              WHEN  ${TABLE}.order_sequence = 1 AND ${TABLE}.total_price < 15 THEN '3. $10 - $14.99'
              WHEN  ${TABLE}.order_sequence = 1 AND ${TABLE}.total_price < 20 THEN '4. $15 - $19.99'
              WHEN  ${TABLE}.order_sequence = 1 AND ${TABLE}.total_price < 25 THEN '5. $20 - $24.99'
              WHEN  ${TABLE}.order_sequence = 1 AND ${TABLE}.total_price < 30 THEN '6. $25 - $29.99'
              WHEN  ${TABLE}.order_sequence = 1 AND ${TABLE}.total_price < 40 THEN '7. $30 - $39.99'
              WHEN  ${TABLE}.order_sequence = 1 AND ${TABLE}.total_price < 50 THEN '8. $40 - $49.99'
              WHEN  ${TABLE}.order_sequence = 1 AND ${TABLE}.total_price < 60 THEN '9. $50 - $59.99'
              WHEN  ${TABLE}.order_sequence = 1 AND ${TABLE}.total_price < 70 THEN '10. $60 - $69.99'
              WHEN  ${TABLE}.order_sequence = 1 AND ${TABLE}.total_price < 80 THEN '11. $70 - $79.99'
              WHEN  ${TABLE}.order_sequence = 1 AND ${TABLE}.total_price < 90 THEN '12. $80 - $89.99'
              WHEN  ${TABLE}.order_sequence = 1 AND ${TABLE}.total_price >= 90 THEN '13. $90 +'
              ELSE '14. Null' END;;
  }

    ################## Measures #######################

  measure: renewal_order_count {
    type: count_distinct
    sql:  ${TABLE}.id;;
    filters: {field:is_first_order value:"no"}
  }

  measure: first_order_count {
    type: count_distinct
    sql:  ${TABLE}.id;;
    filters: {field:is_first_order value:"yes"}
  }


  }
