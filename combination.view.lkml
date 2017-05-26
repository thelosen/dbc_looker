# to get order counts for 2-item sku combinations
view: combination {
  derived_table: {
    distribution_style: even
    sortkeys: ["order_id"]
    sql_trigger_value:  SELECT COUNT(*) FROM mysql_heroku_app_db.shop_order_items;;
    sql:
    SELECT product.sku, product_1.sku as combo_sku, shop_order_items.order_id
    FROM ((mysql_heroku_app_db.shop_order_items INNER JOIN mysql_heroku_app_db.shop_order_items AS shop_order_items_1 ON (shop_order_items.order_id = shop_order_items_1.order_id AND shop_order_items.product_id > shop_order_items_1.product_id)) INNER JOIN mysql_heroku_app_db.product AS product_1 ON shop_order_items_1.product_id = product_1.id) INNER JOIN mysql_heroku_app_db.product ON shop_order_items.product_id = product.id
    WHERE product.sku <> product_1.sku;;
  }

  dimension: SKU {
    hidden: yes
    type: string
    sql: ${TABLE}.sku ;;
    }

  dimension: combo_sku {
    hidden: yes
    type: string
    sql: ${TABLE}.combo_sku ;;
  }

  dimension: Order_id {
    hidden: yes
    type: number
    sql: ${TABLE}.order_id ;;
    }


################## Measures #######################

  measure: count_of_orders {
    hidden: yes
    type: count_distinct
    drill_fields: [detail*]
    sql: ${TABLE}.order_id ;;
    description: "Distinct count of order IDs"
  }


  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      Order_id
    ]
  }

}
