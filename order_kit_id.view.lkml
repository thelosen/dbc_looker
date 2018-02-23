# kit id associated with order
view: order_kit_id {
  derived_table: {
    distribution_style: even
    sortkeys: ["id"]
    sql_trigger_value: SELECT COUNT(*) FROM ${shop_orders.SQL_TABLE_NAME};;
    sql:
        SELECT o.id, max(kit_id) as order_kit_id
        FROM ${shop_orders.SQL_TABLE_NAME} as o
        LEFT JOIN ${shop_order_items.SQL_TABLE_NAME} as oi on o.id = oi.order_id
        GROUP BY o.id;;

    }

    ##### Dimensions ###############

    dimension: id {
      primary_key: yes
      hidden: yes
      type: number
      sql: ${TABLE}.id ;;
    }

    dimension: order_kit_id {
      type: number
      sql: ${TABLE}.order_kit_id;;
    }


  }
