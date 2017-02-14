view: pdt_customer_fact {
  derived_table: {
    distribution: "EVEN"
    sortkeys: ["user_id"]
    sql_trigger_value: SELECT COUNT(*) FROM ${shop_orders.SQL_TABLE_NAME}
    sql: select
      users.user_id
      , sum(shop_orders.subtotal) as lifetime_revenue
      , min(shop_orders.created_at) as first_order_timestamp
      , max(shop_orders.created_at) as most_recent_order_timestamp
      , count(distinct shop_orders.id) as lifetime_order_count
      , avg(shop_orders.subtotal) as average_order_amount
      FROM mysql_heroku_app_db.users
        LEFT JOIN ${shop_orders.SQL_TABLE_NAME} ON users.id = shop_orders.user_id
      GROUP BY users.user_id
       ;;
  }

  ##### Dimensions ###############

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
    hidden: yes
  }

  dimension: lifetime_revenue_dim {
    type: number
    sql: ${TABLE}.lifetime_revenue ;;
    hidden: yes
  }

  dimension_group: first_order {
    type: time
    timeframes: [date, week, month]
    sql: ${TABLE}.first_order_timestamp ;;
  }

  dimension_group: most_recent_order {
    type: time
    timeframes: [date, week, month]
    sql: ${TABLE}.most_recent_order_timestamp ;;
  }

  dimension: lifetime_order_count_dim {
    type: number
    sql: ${TABLE}.lifetime_order_count ;;
    hidden: yes
  }

  dimension: average_order_amount {
    type: number
    sql: ${TABLE}.average_order_amount ;;
    value_format_name: usd_2
  }

  dimension: lifetime_revenue_grouping {
    type: string
    sql: CASE WHEN ${TABLE}.lifetime_revenue is NULL THEN '8. Not available'
      WHEN ${TABLE}.lifetime_revenue < 25 THEN '1. Under $25'
      WHEN ${TABLE}.lifetime_revenue < 50 THEN '2. $25 - $49.99'
      WHEN ${TABLE}.lifetime_revenue < 75 THEN '3. $50 - $74.99'
      WHEN ${TABLE}.lifetime_revenue < 100 THEN '4. $75 - $99.99'
      WHEN ${TABLE}.lifetime_revenue < 150 THEN '5. $100 - $149.99'
      WHEN ${TABLE}.lifetime_revenue < 250 THEN '6. $150 - $249.99'
      ELSE '7. Over $250' END ;;
  }

  dimension: average_order_amount_grouping {
    type: string
    sql:  CASE WHEN ${TABLE}.average_purchase is NULL THEN '8. Not available'
      WHEN ${TABLE}.average_purchase < 5 THEN '1. Under $5'
      WHEN ${TABLE}.average_purchase < 10 THEN '2. $5 - $9.99'
      WHEN ${TABLE}.average_purchase < 15 THEN '3. $10 - $14.99'
      WHEN ${TABLE}.average_purchase < 20 THEN '4. $15 - $19.99'
      WHEN ${TABLE}.average_purchase < 25 THEN '5. $20 - $24.99'
      WHEN ${TABLE}.average_purchase < 30 THEN '6. $25 - $29.99'
      ELSE '7. Over $30' END;;
  }


  #### Measures #################
  dimension: lifetime_revenue {
    type: number
    sql: ${TABLE}.lifetime_revenue ;;
    value_format_name: usd_2
  }

  measure: lifetime_order_count {
    type: sum
    sql: ${TABLE}.lifetime_order_count ;;
  }
}
