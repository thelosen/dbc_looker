view: shop_order_items {
  sql_table_name: mysql_heroku_app_db.shop_order_items ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    hidden: yes
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}.order_id ;;
    hidden: yes
  }

  dimension_group: created {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: deleted {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.deleted_at ;;
  }

  dimension: is_recurring {
    type: number
    sql: ${TABLE}.is_recurring ;;
  }

  dimension: kit_id {
    type: number
    sql: ${TABLE}.kit_id ;;
    hidden: yes
  }

  dimension: product_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.product_id ;;
    hidden: yes
  }

  dimension: product_sku {
    type: string
    sql: ${TABLE}.product_sku ;;
    hidden: yes
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }

  dimension_group: updated {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.updated_at ;;
  }

################## Measures #######################
  measure: price {
    type: sum
    sql: ${TABLE}.price ;;
  }

  measure: quantity {
    type: sum
    sql: ${TABLE}.quantity ;;
  }

  measure: count_of_orders {
    type: count_distinct
    sql: ${TABLE}.order_id ;;
  }
}
