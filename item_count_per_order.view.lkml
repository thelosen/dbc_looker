# getting the number of items per orde

view: item_count_per_order {
  derived_table: {
    distribution_style: even
    sortkeys: ["order_id"]
    sql_trigger_value: SELECT COUNT(*) FROM mysql_heroku_app_db.shop_order_items;;
    sql:
      SELECT order_id, count(distinct product_id) as item_count
      FROM mysql_heroku_app_db.shop_orders
        LEFT JOIN mysql_heroku_app_db.shop_order_items ON shop_orders.id = shop_order_items.order_id
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
