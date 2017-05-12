view: product {
  sql_table_name: mysql_heroku_app_db.product ;;

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
    hidden: yes
  }

  dimension: benefits {
    hidden: yes
    type: string
    sql: ${TABLE}.benefits ;;
  }

  dimension: category_id {
    type: number
    sql: ${TABLE}.category_id ;;
    hidden: yes
  }

  dimension: comment {
    hidden: yes
    type: string
    sql: ${TABLE}.comment ;;
  }

  dimension_group: created {
    hidden: yes
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.created_at ;;
  }

  dimension: currency {
    hidden: yes
    type: string
    sql: ${TABLE}.currency ;;
  }

  dimension: default_billing_plan_id {
    type: number
    sql: ${TABLE}.default_billing_plan_id ;;
    hidden: yes
  }

  dimension_group: deleted {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.deleted_at ;;
    hidden: yes
  }

  dimension: product_description {
    type: string
    sql: ${TABLE}.description ;;
  }

  dimension: product_id {
    hidden: yes
    type: number
    sql: ${TABLE}.product_id ;;
  }

  dimension: product_ingredients {
    type: string
    sql: ${TABLE}.ingredients ;;
  }

  dimension: is_disabled {
    type: yesno
    hidden: yes
    sql: ${TABLE}.is_disabled ;;
  }

  dimension: is_tangible {
    type: yesno
    hidden: yes
    sql: ${TABLE}.is_tangible ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: no_tax {
    type: number
    sql: ${TABLE}.no_tax ;;
  }

  dimension: paysys_id {
    type: string
    sql: ${TABLE}.paysys_id ;;
    hidden: yes
  }

  dimension: prevent_if_other {
    type: string
    hidden: yes
    sql: ${TABLE}.prevent_if_other ;;
  }

  dimension: product_image {
    type: string
    sql: ${TABLE}.product_image ;;
    hidden: yes
  }

  dimension: product_type {
    type: string
    sql: ${TABLE}.product_type ;;
  }

  dimension: quantity_available {
    type: number
    sql: ${TABLE}.quantity_available ;;
  }

  dimension: quantity_on_hand {
    type: number
    sql: ${TABLE}.quantity_on_hand ;;
  }

  dimension: require_other {
    type: string
    sql: ${TABLE}.require_other ;;
  }

  dimension: sku {
    type: string
    sql: ${TABLE}.sku ;;
  }

  dimension: sort_order {
    type: string
    sql: ${TABLE}.sort_order ;;
    hidden: yes
  }

  dimension: start_date {
    type: string
    sql: ${TABLE}.start_date ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: stripe_id {
    type: string
    sql: ${TABLE}.stripe_id ;;
  }

  dimension_group: updated {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.updated_at ;;
    hidden: yes
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
    hidden: yes
  }

  dimension: v2_product_image {
    type: string
    sql: ${TABLE}.v2_product_image ;;
    hidden: yes
  }

  dimension: weight {
    type: number
    sql: ${TABLE}.weight ;;
  }

  dimension: weight_unit {
    type: string
    sql: ${TABLE}.weight_unit ;;
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      product_id,
      name,
      users.first_name,
      users.last_name,
      users.user_id,
      billing_plan.count,
      contact_subscriptions.count,
      product_active_billings.count,
      product_cart.count,
      product_kit_items.count,
      shop_order_items.count,
      user_temp_cart_products.count
    ]
  }
}
