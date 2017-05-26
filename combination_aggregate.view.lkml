#combining the combination tables to get most common order look
view: combination_aggregate {
  derived_table: {
    distribution_style: even
    sortkeys: ["id"]
    sql_trigger_value: SELECT COUNT(*) FROM ${item_count_per_order.SQL_TABLE_NAME};;
    sql:
    SELECT sku, combo_sku, combo_sku_2, combo_sku_3, combo_sku_4, combo_sku_5, order_id, item_count
    FROM(
      SELECT product.sku as sku,
          null as combo_sku,
          null as combo_sku_2,
          null as combo_sku_3,
          null as combo_sku_4,
          null as combo_sku_5,
          '1' as item_count,
          shop_order_items.order_id as order_id
      FROM (mysql_heroku_app_db.shop_order_items INNER JOIN ${item_count_per_order.SQL_TABLE_NAME} AS item_count_1 ON (shop_order_items.order_id = item_count_1.order_id AND item_count_1.item_count = 1))
      INNER JOIN mysql_heroku_app_db.product ON shop_order_items.product_id = product.id
    UNION ALL
      SELECT sku
          combo_sku,
          null as combo_sku_2,
          null as combo_sku_3,
          null as combo_sku_4,
          null as combo_sku_5,
          '2' as item_count,
          t2.order_id as order_id
      FROM ${combination.SQL_TABLE_NAME} as t2
      INNER JOIN ${item_count_per_order.SQL_TABLE_NAME} AS item_count_2 ON (t2.order_id = item_count_2.order_id AND item_count_2.item_count = 2)
    UNION ALL
      SELECT sku
          combo_sku,
          combo_sku_2,
          null as combo_sku_3,
          null as combo_sku_4,
          null as combo_sku_5,
          '3' as item_count,
          t3.order_id as order_id
      FROM ${combination_2.SQL_TABLE_NAME} as t3
      INNER JOIN ${item_count_per_order.SQL_TABLE_NAME} AS item_count_3 ON (t3.order_id = item_count_3.order_id AND item_count_3.item_count = 3)
    UNION ALL
      SELECT sku
          combo_sku,
          combo_sku_2,
          combo_sku_3,
          null as combo_sku_4,
          null as combo_sku_5,
          '4' as item_count,
          t4.order_id as order_id
      FROM ${combination_3.SQL_TABLE_NAME} as t4
      INNER JOIN ${item_count_per_order.SQL_TABLE_NAME} AS item_count_4 ON (t4.order_id = item_count_4.order_id AND item_count_4.item_count = 4)
    UNION ALL
      SELECT sku
          combo_sku,
          combo_sku_2,
          combo_sku_3,
          combo_sku_4,
          null as combo_sku_5,
          '5' as item_count,
          t5.order_id as order_id
      FROM ${combination_4.SQL_TABLE_NAME} as t5
      INNER JOIN ${item_count_per_order.SQL_TABLE_NAME} AS item_count_5 ON (t5.order_id = item_count_5.order_id AND item_count_5.item_count = 5)
    UNION ALL
      SELECT sku
          combo_sku,
          combo_sku_2,
          combo_sku_3,
          combo_sku_4,
          combo_sku_5,
          '6' as item_count,
          t6.order_id as order_id
      FROM ${combination_5.SQL_TABLE_NAME} as t6
      INNER JOIN ${item_count_per_order.SQL_TABLE_NAME} AS item_count_6 ON (t6.order_id = item_count_6.order_id AND item_count_6.item_count = 6));;

  }

  dimension: SKU {
    type: string
    sql: ${TABLE}.sku ;;
  }

  dimension: combo_sku {
    type: string
    sql: ${TABLE}.combo_sku ;;
  }

  dimension: combo_sku_2 {
    type: string
    sql: ${TABLE}.combo_sku_2 ;;
  }

  dimension: combo_sku_3 {
    type: string
    sql: ${TABLE}.combo_sku_3 ;;
  }

  dimension: combo_sku_4 {
    type: string
    sql: ${TABLE}.combo_sku_4 ;;
  }

  dimension: combo_sku_5 {
    type: string
    sql: ${TABLE}.combo_sku_5 ;;
  }

  dimension: Order_id {
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension: item_count{
    type: number
    sql: ${TABLE}.item_count ;;
  }

################## Measures #######################

  measure: count_of_orders {
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
