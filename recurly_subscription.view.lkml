view: recurly_subscription {
  sql_table_name: mysql_heroku_app_db.recurly_subscription ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }


####### Dimensions ########
### Dates #################
  dimension_group: activated {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.activated_at ;;
  }

  dimension_group: canceled {
    description: "Caution: Canceled date seems sparsely populated for canceled subscriptions."
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.canceled_at ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }


  dimension_group: current_period_ends {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.current_period_ends_at ;;
  }

  dimension_group: current_period_started {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.current_period_started_at ;;
  }

  dimension_group: deleted {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.deleted_at ;;
  }

  dimension_group: expires {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.expires_at ;;
  }

  dimension_group: first_renewal {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.first_renewal_date ;;
  }

  dimension_group: updated {
    description: "Using updated to check for when users canceled a subscription due to sparse data fill on canceled at"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.updated_at ;;
  }

  dimension_group: trial_ends {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.trial_ends_at ;;
  }

  dimension_group: trial_started {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.trial_started_at ;;
  }

 ####################################

  dimension: bank_account_authorized_at {
    type: string
    sql: ${TABLE}.bank_account_authorized_at ;;
  }

  dimension: collection_method {
    type: string
    sql: ${TABLE}.collection_method ;;
  }

  dimension: contact_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.contact_id ;;
  }

  dimension: currency {
    type: string
    sql: ${TABLE}.currency ;;
  }

  dimension: paused_subscription {
    type: yesno
    sql: DATEDIFF(day,${current_period_started_date},${current_period_ends_date}) between 55 and 65 ;;
  }

  dimension: customer_notes {
    type: string
    sql: ${TABLE}.customer_notes ;;
  }

  dimension: cycles_completed {
    type: number
    sql: ${TABLE}.cycles_completed ;;
  }

  dimension: net_terms {
    type: number
    sql: ${TABLE}.net_terms ;;
  }

  dimension: original_order_id {
    type: number
    sql: ${TABLE}.original_order_id ;;
  }

  dimension: pending_subscription {
    type: string
    sql: ${TABLE}.pending_subscription ;;
  }

  dimension: plan {
    type: string
    sql: ${TABLE}.plan ;;
  }

  dimension: po_number {
    type: number
    sql: ${TABLE}.po_number ;;
  }

  dimension: quantity {
    type: number
    sql: ${TABLE}.quantity ;;
  }

  dimension: recent_order_id {
    type: number
    sql: ${TABLE}.recent_order_id ;;
  }

  dimension: shipping_charges_in_cents {
    type: number
    sql: ${TABLE}.shipping_charges_in_cents ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: recurly_active_or_future_state {
    type: yesno
    sql: ${state} IN('active','future') ;;
  }

  dimension: subscription_add_ons {
    type: string
    sql: ${TABLE}.subscription_add_ons ;;
  }

  dimension: tax_in_cents {
    type: string
    sql: ${TABLE}.tax_in_cents ;;
  }

  dimension: tax_rate {
    type: string
    sql: ${TABLE}.tax_rate ;;
  }

  dimension: tax_type {
    type: string
    sql: ${TABLE}.tax_type ;;
  }

  dimension: terms_and_conditions {
    type: string
    sql: ${TABLE}.terms_and_conditions ;;
  }

  dimension: total_cycles {
    type: number
    sql: ${TABLE}.total_cycles ;;
  }

  dimension: unit_amount_in_cents {
    type: number
    sql: ${TABLE}.unit_amount_in_cents ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  dimension: uuid {
    type: string
    sql: ${TABLE}.uuid ;;
  }

########### Measures ###############

  measure: recurly_subscription_amount {
    type: sum
    sql: ${TABLE}.unit_amount_in_cents/100.0 ;;
    value_format_name: usd_0
  }

  measure:  recurly_subscription_count {
    type: count_distinct
    sql: ${id} ;;
    drill_fields: [detail*]
  }

    measure: recurly_subscriber_count {
    type: count_distinct
    sql: ${user_id} ;;
      drill_fields: [detail*]
  }

  measure: recurly_active_subscriber_count {
    type: count_distinct
    sql: ${user_id} ;;
    filters: {
      field: recurly_subscription.recurly_active_or_future_state
      value: "yes"
    }
    drill_fields: [detail*]
    description: "Where recurly subscription state is active or future"
  }

  measure: recurly_7_day_new_subscriber_count {
    type: count_distinct
    sql: ${user_id} ;;
    filters: {
      field: recurly_subscription.created_date
      value: "7 days"
    }
    filters: {
      field: recurly_subscription.recurly_active_or_future_state
      value: "yes"
    }
    drill_fields: [detail*]
    description: "Where recurly subscription state is active or future and recurly subscription created date is in the past seven days"
  }

  measure: recurly_7_day_cancelled_subscriber_count {
    type: count_distinct
    sql: ${user_id} ;;
    filters: {
      field: recurly_subscription.canceled_date
      value: "7 days"
    }
    filters: {
      field: recurly_subscription.state
      value: "canceled"
    }
    drill_fields: [detail*]
    description: "Where recurly subscription state is canceled and recurly subscription canceled date is in the past seven days"
  }

  measure: recurly_7_day_net_subscriber_count {
    type: number
    sql: ${recurly_7_day_new_subscriber_count} - ${recurly_7_day_cancelled_subscriber_count} ;;
    drill_fields: [detail*]
    description: "New subscribers minus canceled subscribers"
  }

  measure: recurly_7_day_subscriber_churn {
    type: number
    sql: (1.0 * ${recurly_7_day_cancelled_subscriber_count}) / nullif(${recurly_active_subscriber_count},0) ;;
    value_format: "0.00%"
    drill_fields: [detail*]
    description: "Canceled subscribers divided by Total Active Subscribers"
  }


  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      contacts.id,
      users.id,
      users.email,
      recurly_accounts.account_code
      ]
  }
}
