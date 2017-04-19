view: combination {
  derived_table: {
    distribution_style: even
    sortkeys: ["order_id"]
    sql_trigger_value:  SELECT COUNT(*) FROM mysql_heroku_app_db.shop_order_items;;
    sql:
    SELECT product.sku, product_1.sku as combo_sku, Count(shop_order_items.order_id) AS CountOforder_id
    FROM ((shop_order_items INNER JOIN shop_order_items AS shop_order_items_1 ON shop_order_items.order_id = shop_order_items_1.order_id) INNER JOIN product AS product_1 ON shop_order_items_1.product_id = product_1.id) INNER JOIN product ON shop_order_items.product_id = product.id
    GROUP BY product.sku, product_1.sku;;
  }

  dimension: SKU {
    type: number
    sql: ${TABLE}.sku ;;
    }

  dimension: combo_sku {
    type: number
    sql: ${TABLE}.combo_sku ;;
  }

  dimension: CountOfOrders {
    type: number
    sql: ${TABLE}.CountOforder_id ;;
    }

}
