view: shop_order_items_fact {
  derived_table: {
    distribution_style: even
    sortkeys: ["product_id"]
    sql_trigger_value: SELECT COUNT(*) FROM ${shop_order_items.SQL_TABLE_NAME};;
    sql: select
      shop_orders.user_id
      , shop_order_items.product_id
      , min(shop_order_items.created_at) as first_product_order_timestamp
      , max(shop_order_items.created_at) as most_recent_product_order_timestamp
      , min(shop_order_items.order_id) as first_product_order_id
      , count(distinct shop_order_items.id) as lifetime_product_order_count
      FROM ${shop_order_items.SQL_TABLE_NAME}
        LEFT JOIN ${shop_orders.SQL_TABLE_NAME} as shop_orders ON shop_order_items.order_id = shop_orders.user_id
      GROUP BY users.id, product_id
       ;;
  }

  ##### Dimensions ###############
  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
    hidden: yes
  }

  dimension: product_id {
    type: number
    sql: ${TABLE}.product_id ;;
    hidden: yes
  }

  dimension_group: first_product_order {
    type: time
    timeframes: [date, week, month, raw]
    sql: ${TABLE}.first_product_order_timestamp ;;
  }

  dimension_group: most_recent_product_order {
    type: time
    timeframes: [date, week, month]
    sql: ${TABLE}.most_recent_product_order_timestamp ;;
  }

  dimension: lifetime_product_order_count_dim {
    type: number
    sql: ${TABLE}.lifetime_product_order_count ;;
  }

  dimension: first_product_order_id {
    type: number
    sql: ${TABLE}.first_product_order_id ;;
  }


  #### Measures #################
  measure: lifetime_product_order_count {
    type: sum
    sql: ${TABLE}.lifetime_product_order_count ;;
  }

  measure: user_count {
    hidden: yes
    type: count_distinct
    sql:  ${TABLE}.user_id ;;
  }

}
