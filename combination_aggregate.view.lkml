#combining the combination tables to get most common order look
view: combination_aggregate {
  derived_table: {
    distribution_style: even
    sortkeys: ["order_id"]
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
          t1.order_id as order_id
      FROM (${shop_order_items.SQL_TABLE_NAME} as t1
      INNER JOIN ${item_count_per_order.SQL_TABLE_NAME} AS item_count_1 ON (t1.order_id = item_count_1.order_id AND item_count_1.item_count = 1))
      INNER JOIN mysql_heroku_app_db.product ON t1.product_id = product.id
    UNION ALL
      SELECT sku,
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
      SELECT sku,
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
      SELECT sku,
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
      SELECT sku,
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
      SELECT sku,
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

  dimension: combo_sku_4 {
    hidden: yes
    type: string
    sql: ${TABLE}.combo_sku_4 ;;
  }

  dimension: combo_sku_5 {
    hidden: yes
    type: string
    sql: ${TABLE}.combo_sku_5 ;;
  }

  dimension: Order_id {
    hidden: yes
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension: item_count{
    hidden: yes
    type: number
    sql: ${TABLE}.item_count ;;
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
