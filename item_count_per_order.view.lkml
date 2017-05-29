# getting the number of items per orde

view: item_count_per_order {
  derived_table: {
    distribution_style: even
    sortkeys: ["order_id"]
    sql_trigger_value: SELECT COUNT(*) FROM ${shop_order_items.SQL_TABLE_NAME};;
    sql:
      SELECT order_id, count(distinct product_id) as item_count
      FROM ${shop_orders.SQL_TABLE_NAME} as t1
        LEFT JOIN  ${shop_order_items.SQL_TABLE_NAME} as t2 ON t1.id = t2.order_id
        GROUP BY order_id;;
  }

  ################## Dimensions #######################

  dimension: order_id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension: item_count {
    type: number
    sql: ${TABLE}.item_count ;;
  }

}
