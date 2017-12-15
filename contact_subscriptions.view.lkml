view: contact_subscriptions {
  sql_table_name: mysql_heroku_app_db.contact_subscriptions ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    hidden: yes
  }

  dimension: account_code {
    hidden: yes
    type: string
    sql: ${TABLE}.account_code ;;
  }

  dimension: amount_in_cents {
    type: number
    sql: ${TABLE}.amount_in_cents ;;
    hidden: yes
  }

  dimension_group: product_subscription_canceled {
    hidden: yes
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.cancelled_at ;;
  }

  dimension: contact_id {
    type: number
    hidden: yes
    sql: ${TABLE}.contact_id ;;
  }

  dimension_group: product_subscription_created {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.created_at ;;
  }

  dimension: currency {
    hidden: yes
    type: string
    sql: ${TABLE}.currency ;;
  }

  dimension: cycles_completed {
    hidden: yes
    type: number
    sql: ${TABLE}.cycles_completed ;;
  }

  dimension_group: product_subscription_deleted {
    hidden: yes
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.deleted_at ;;

  }

  dimension: frequency {
    hidden: yes
    type: string
    sql: ${TABLE}.frequency ;;
  }

  dimension: is_product_free {
    hidden: yes
    type: number
    sql: ${TABLE}.is_product_free ;;
  }

  dimension: is_recurring {
    hidden: yes
    type: number
    sql: ${TABLE}.is_recurring ;;
  }

  dimension: kit_id {
    type: number
    sql: ${TABLE}.kit_id ;;
  }

  dimension_group: next_renewal {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.next_renewal_date ;;
  }

  dimension: original_order_id {
    hidden: yes
    type: number
    sql: ${TABLE}.original_order_id ;;
  }

  dimension: product_id {
    type: number
    sql: ${TABLE}.product_id ;;
  }

  dimension: product_sku {
    description: "Many null values - do not use"
    type: string
    sql: ${TABLE}.product_sku ;;
    hidden: yes
  }

  dimension: quantity {
    type: number
    sql: ${TABLE}.quantity ;;
  }

  dimension: recent_order_id {
    hidden: yes
    type: number
    sql: ${TABLE}.recent_order_id ;;
  }

  dimension_group: product_subscription_started {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.started_at ;;
    hidden: yes
  }

  dimension: product_subscription_status {
    type: string
    sql: ${TABLE}.status ;;
    hidden: yes
  }

  dimension: recurly_subscription_state {
    hidden: yes
    type: string
    sql: recurly_subscription.state ;;
  }

  dimension: recurly_active_subscription {
    type: yesno
    hidden: yes
    sql: ${recurly_subscription_state} IN ('active','future','past_due') ;;
  }

  dimension: active_product_subscription {
    type: yesno
    sql: ${recurly_active_subscription} = "yes" AND ${TABLE}.deleted_at  IS NULL AND ${TABLE}.cancelled_at IS NULL AND ${TABLE}.next_renewal_date > DATE_SUB(NOW(), INTERVAL 1 DAY)   ;;
  }

  dimension: subscription_id {
    type: number
    sql: case when ${TABLE}.subscription_id = 0 then null else ${TABLE}.subscription_id end ;;
  }

  dimension: total_cycles {
    hidden: yes
    type: number
    sql: ${TABLE}.total_cycles ;;
  }

  dimension: type {
    hidden: yes
    type: string
    sql: ${TABLE}.type ;;
  }

  dimension_group: updated {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.updated_at ;;
    hidden: yes
  }

  dimension: user_id {
    hidden: yes
    type: number
    sql: ${TABLE}.user_id ;;
  }


########### Measures ###############
  measure: count {
    type: count
  }

  measure:  subscription_count {
    type: count_distinct
    sql: ${subscription_id} ;;
    drill_fields: [user_detail*]
  }

  measure: subscriber_count {
    type: count_distinct
    sql: ${user_id} ;;
    drill_fields: [user_detail*]
  }

  measure: active_product_subscriber_count {
    type: count_distinct
    sql: ${user_id} ;;
    drill_fields: [user_detail*]
    filters: {
      field: active_product_subscription
      value: "yes"
    }
  }

  measure: product_quantity {
    type: sum
    sql: ${TABLE}.quantity ;;
    drill_fields: [user_detail*]
  }

  measure: total_product_price {
    type: sum
    sql: (${TABLE}.quantity * ${TABLE}.amount_in_cents/100.0) ;;
    value_format_name: usd_0
    drill_fields: [user_detail*]
    description: "Unit Price * Unit Quantity"
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      users.first_name,
      users.last_name,
      users.user_id,
      contacts.id,
      contacts.first_name,
      contacts.last_name,
      product.product_id,
      product.name
    ]
  }

  set: user_detail {
    fields: [
      contacts.email,
      contacts.first_name,
      contacts.last_name,
    ]
  }
}
