view: product_kits {
  sql_table_name: mysql_heroku_app_db.product_kits ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
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

  dimension: is_disabled {
    type: number
    sql: ${TABLE}.is_disabled ;;
  }

  dimension: is_shipping_free {
    type: number
    sql: ${TABLE}.is_shipping_free ;;
  }

  dimension: kit_actual_price {
    type: string
    sql: ${TABLE}.kit_actual_price ;;
  }

  dimension: kit_description {
    type: string
    sql: ${TABLE}.kit_description ;;
  }

  dimension: kit_id {
    type: string
    sql: ${TABLE}.kit_id ;;
    hidden: yes
  }

  dimension: kit_image {
    type: string
    sql: ${TABLE}.kit_image ;;
    hidden: yes
  }

  dimension: kit_name {
    type: string
    sql: ${TABLE}.kit_name ;;
  }

  dimension: kit_price {
    type: number
    sql: ${TABLE}.kit_price ;;
  }

  dimension: link_name {
    type: string
    sql: ${TABLE}.link_name ;;
  }

  dimension: recurring {
    type: number
    sql: ${TABLE}.recurring ;;
  }

  dimension: renewal_discount {
    type: number
    sql: ${TABLE}.renewal_discount ;;
  }

  dimension_group: updated {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.updated_at ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
    hidden: yes
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      kit_name,
      link_name,
      users.first_name,
      users.last_name,
      users.user_id
    ]
  }
}
