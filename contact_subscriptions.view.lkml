view: contact_subscriptions {
  sql_table_name: mysql_heroku_app_db.contact_subscriptions ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    hidden: yes
  }

  dimension: account_code {
    type: string
    sql: ${TABLE}.account_code ;;
  }

  dimension: amount_in_cents {
    type: number
    sql: ${TABLE}.amount_in_cents ;;
    hidden: yes
  }

  dimension_group: product_subscription_canceled {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.cancelled_at ;;
  }

  dimension: contact_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.contact_id ;;
  }

  dimension_group: product_subscription_created {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.created_at ;;
  }

  dimension: currency {
    type: string
    sql: ${TABLE}.currency ;;
  }

  dimension: cycles_completed {
    type: number
    sql: ${TABLE}.cycles_completed ;;
  }

  dimension_group: product_subscription_deleted {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.deleted_at ;;
    hidden: yes
  }

  dimension: frequency {
    type: string
    sql: coalesce(${TABLE}.frequency, 'Unknown') ;;
  }

  dimension: is_product_free {
    type: number
    sql: ${TABLE}.is_product_free ;;
  }

  dimension: is_recurring {
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
    type: number
    sql: ${TABLE}.original_order_id ;;
  }

  dimension: product_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.product_id ;;
  }

  dimension: product_sku {
    type: string
    sql: ${TABLE}.product_sku ;;
  }

  dimension: quantity {
    type: number
    sql: ${TABLE}.quantity ;;
  }

  dimension: recent_order_id {
    type: number
    sql: ${TABLE}.recent_order_id ;;
  }

  dimension_group: started {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.started_at ;;
  }

  dimension: product_subscription_status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: subscription_id {
    type: number
    sql: case when ${TABLE}.subscription_id = 0 then null else ${TABLE}.subscription_id end ;;
  }

  dimension: total_cycles {
    type: number
    sql: ${TABLE}.total_cycles ;;
  }

  dimension: type {
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
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }


########### Measures ###############

  measure:  subscription_count {
    type: count_distinct
    sql: ${subscription_id} ;;
    drill_fields: [user_detail*]
  }


  measure: subscription_amount {
    type: sum
    sql: ${TABLE}.amount_in_cents/100.0 ;;
    value_format_name: usd_0
    drill_fields: [user_detail*]
  }

  measure: subscriber_count {
    type: count_distinct
    sql: ${user_id} ;;
    drill_fields: [user_detail*]
  }

  measure: active_subscriber_count {
    type: count_distinct
    sql: ${user_id} ;;
    drill_fields: [user_detail*]
    filters: {
      field: recurly_subscription.recurly_active_or_future_state
      value: "yes"
    }
    description: "Where recurly subscription state is active or future"
  }

  measure: 7_day_new_subscriber_count {
    type: count_distinct
    sql: ${user_id} ;;
    drill_fields: [user_detail*]
    filters: {
      field: recurly_subscription.created_date
      value: "7 days"
    }
    filters: {
      field: recurly_subscription.recurly_active_or_future_state
      value: "yes"
    }
    description: "Where recurly subscription state is active or future and recurly subscription created date is in the past seven days"
  }

  measure: 7_day_cancelled_subscriber_count {
    type: count_distinct
    sql: ${user_id} ;;
    drill_fields: [user_detail*]
    filters: {
      field: recurly_subscription.canceled_date
      value: "7 days"
    }
    filters: {
      field: recurly_subscription.state
      value: "canceled"
    }
    description: "Where recurly subscription state is canceled and recurly subscription canceled date is in the past seven days"
  }

  measure: 7_day_net_subscriber_count {
    type: number
    sql: ${7_day_new_subscriber_count} - ${7_day_cancelled_subscriber_count} ;;
    description: "New subscribers minus canceled subscribers"
    drill_fields: [user_detail*]
  }

  measure: 7_day_subscriber_churn {
    type: number
    sql: (1.0 * ${7_day_cancelled_subscriber_count}) / nullif(${active_subscriber_count},0) ;;
    drill_fields: [user_detail*]
    value_format: "0.00%"
    description: "Canceled subscribers divided by Total Active Subscribers"
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
