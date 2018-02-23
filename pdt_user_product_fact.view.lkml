view: pdt_user_product_fact {
  derived_table: {
    distribution_style: even
    sortkeys: ["user_id"]
    sql_trigger_value: SELECT COUNT(*) FROM ${shop_orders.SQL_TABLE_NAME};;
    sql: Select DISTINCT
      shop_orders.user_id
      , shop_order_items.product_id
      , min(shop_order_items.created_at) as first_product_order_timestamp
      , max(shop_order_items.created_at) as most_recent_product_order_timestamp
      , count(distinct shop_order_items.order_id) as lifetime_product_order_count
      , min(shop_order_items.order_id) as first_product_order_id
      FROM ${shop_order_items.SQL_TABLE_NAME} as shop_order_items
      LEFT JOIN ${shop_orders.SQL_TABLE_NAME} as shop_orders ON shop_order_items.order_id = shop_orders.id
      GROUP BY user_id, product_id
      HAVING product_id >0
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
  }

  dimension: compound_primary_key {
    type: string
    primary_key: yes
    hidden: yes
    sql: CONCAT(${TABLE}.user_id || '-' ||  ${TABLE}.product_id) ;;
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
    sql: ${TABLE}.first_product_order_id;;
  }


  #### Measures #################
   measure: lifetime_product_order_count {
    type: sum
    sql: ${TABLE}.lifetime_product_order_count ;;
  }

  measure: average_lifetime_product_order_count {
    type: average
    sql: ${TABLE}.lifetime_product_order_count ;;
  }


  }
