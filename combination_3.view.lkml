# to get order counts for 4-item sku combinations
view: combination_3 {
  derived_table: {
    distribution_style: even
    sortkeys: ["order_id"]
    sql_trigger_value:  SELECT COUNT(*) FROM mysql_heroku_app_db.shop_order_items;;
    sql:
    SELECT product.sku, product_1.sku as combo_sku, product_2.sku as combo_sku_2, product_3.sku as combo_sku_3, shop_order_items.order_id
    FROM ((((((mysql_heroku_app_db.shop_order_items INNER JOIN mysql_heroku_app_db.shop_order_items AS shop_order_items_1 ON (shop_order_items.order_id = shop_order_items_1.order_id AND shop_order_items.product_id < shop_order_items_1.product_id)) INNER JOIN mysql_heroku_app_db.shop_order_items AS shop_order_items_2 ON (shop_order_items_1.order_id = shop_order_items_2.order_id AND shop_order_items_1.product_id < shop_order_items_2.product_id AND shop_order_items.product_id < shop_order_items_2.product_id)) INNER JOIN mysql_heroku_app_db.shop_order_items AS shop_order_items_3 ON (shop_order_items_1.order_id = shop_order_items_3.order_id AND shop_order_items_2.product_id < shop_order_items_3.product_id AND shop_order_items
.product_id < shop_order_items_3.product_id AND shop_order_items.product_id < shop_order_items_3.product_id)) INNER JOIN mysql_heroku_app_db.product AS product_3 ON shop_order_items_3.product_id = product_3.id) INNER JOIN mysql_heroku_app_db.product AS product_2 ON shop_order_items_2.product_id = product_2.id) INNER JOIN mysql_heroku_app_db.product AS product_1 ON shop_order_items_1.product_id = product_1.id) INNER JOIN mysql_heroku_app_db.product ON shop_order_items.product_id = product.id
    WHERE (((shop_order_items_1.product_id)<>[shop_order_items].[product_id]) AND ((shop_order_items_2.product_id)<>[shop_order_items].[product_id] And (shop_order_items_2.product_id)<>[shop_order_items_1].[product_id]));;

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

    dimension: combo_sku_2 {
      hidden: yes
      type: string
      sql: ${TABLE}.combo_sku_2 ;;
    }

  dimension: combo_sku_3 {
    hidden: yes
    type: string
    sql: ${TABLE}.combo_sku_3 ;;
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