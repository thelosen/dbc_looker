# getting the earliest order for each user

  view: first_order {
    derived_table: {
      distribution_style: even
      sortkeys: ["id"]
      sql_trigger_value: SELECT COUNT(*) FROM ${pdt_user_fact.SQL_TABLE_NAME};;
      sql:
      Select pdt_user_fact.id as pdt_user_id, pdt_user_fact.first_order_timestamp as pdt_first_order_created_at, shop_orders.id as id, shop_orders.total_price as total_price, shop_orders.subtotal as subtotal,
      FROM ${pdt_user_fact.SQL_TABLE_NAME} as pdt_user_fact
      INNER JOIN ${shop_orders.SQL_TABLE_NAME} as shop_orders ON (pdt_user_fact.id = shop_orders.user_id AND pdt_user_fact.first_order_timestamp = shop_orders.created_at);;

  }

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: created {
    type: time
    timeframes: [time, date, week, month, raw]
    sql: ${TABLE}.pdt_first_order_created_at ;;
  }

  dimension: subtotal {
     type: number
    sql: ${TABLE}.subtotal ;;
  }

  dimension: total_price {
    type: number
    sql: ${TABLE}.total_price ;;
    hidden: yes
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.pdt_user_id ;;
  }


################# Measures #######################
  measure: order_total {
    type: sum
    sql: cast(${TABLE}.total_price as float) ;;
    value_format_name: usd
    hidden: no
  }

  measure: order_subtotal {
    type: sum
    sql: cast(${TABLE}.subtotal as float) ;;
    value_format_name: usd
  }
}
