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
    hidden: yes
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
    hidden: yes
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

  dimension: subscription_period_days {
    hidden: yes
    type: number
    description: "Number of days between current period start and current period end"
    sql: DATEDIFF(day,${current_period_started_date},${current_period_ends_date});;
  }

  dimension: subscription_period_days_grouping {
    hidden: yes
    type: string
    sql: CASE WHEN ${subscription_period_days} is NULL THEN '6. NULL'
      WHEN ${subscription_period_days} < 46  THEN '1. 0 to 45 days'
      WHEN ${subscription_period_days} < 91 THEN '2. 46 to 90 days'
      WHEN ${subscription_period_days} < 121 THEN '3. 91 to 120 days'
      WHEN ${subscription_period_days} < 181 THEN '4. 121 to 180 days'
      ELSE '5. 181 days+' END ;;
  }

  dimension: bank_account_authorized_at {
    hidden: yes
    type: string
    sql: ${TABLE}.bank_account_authorized_at ;;
  }

  dimension: collection_method {
    hidden: yes
    type: string
    sql: ${TABLE}.collection_method ;;
  }

  dimension: contact_id {
    hidden: yes
    type: number
    # hidden: yes
    sql: ${TABLE}.contact_id ;;
  }

  dimension: currency {
    hidden: yes
    type: string
    sql: ${TABLE}.currency ;;
  }

  dimension: paused_subscription {
    type: yesno
    hidden: yes
    description: "methodology no longer supported"
    sql: DATEDIFF(day,${current_period_started_date},${current_period_ends_date}) between 55 and 65 ;;
  }

  dimension: customer_notes {
    hidden: yes
    type: string
    sql: ${TABLE}.customer_notes ;;
  }

  dimension: cycles_completed {
    hidden: yes
    type: number
    sql: ${TABLE}.cycles_completed ;;
  }

  dimension: net_terms {
    hidden: yes
    type: number
    sql: ${TABLE}.net_terms ;;
  }

  dimension: original_order_id {
    hidden: yes
    type: number
    sql: ${TABLE}.original_order_id ;;
  }

  dimension: pending_subscription {
    hidden: yes
    type: string
    sql: ${TABLE}.pending_subscription ;;
  }

  dimension: plan {
    hidden: yes
    type: string
    sql: ${TABLE}.plan ;;
  }

  dimension: po_number {
    hidden: yes
    type: number
    sql: ${TABLE}.po_number ;;
  }

  dimension: quantity {
    hidden: yes
    type: number
    sql: ${TABLE}.quantity ;;
  }

  dimension: recent_order_id {
    hidden: yes
    type: number
    sql: ${TABLE}.recent_order_id ;;
  }

  dimension: shipping_charges_in_cents {
    hidden: yes
    type: number
    sql: ${TABLE}.shipping_charges_in_cents ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: recurly_active_or_future_state {
    hidden: yes
    type: yesno
    sql: ${state} IN('active','future','past_due') ;;
  }

  dimension: active_subscription {
    type: yesno
    sql: ${state} IN('active','future','past_due') ;;
  }

  dimension: subscription_add_ons {
    hidden: yes
    type: string
    sql: ${TABLE}.subscription_add_ons ;;
  }

  dimension: tax_in_cents {
    hidden: yes
    type: string
    sql: ${TABLE}.tax_in_cents ;;
  }

  dimension: tax_rate {
    hidden: yes
    type: string
    sql: ${TABLE}.tax_rate ;;
  }

  dimension: tax_type {
    hidden: yes
    type: string
    sql: ${TABLE}.tax_type ;;
  }

  dimension: terms_and_conditions {
    hidden: yes
    type: string
    sql: ${TABLE}.terms_and_conditions ;;
  }

  dimension: total_cycles {
    hidden: yes
    type: number
    sql: ${TABLE}.total_cycles ;;
  }

  dimension: unit_amount_in_cents {
    hidden: yes
    type: number
    sql: ${TABLE}.unit_amount_in_cents ;;
    }

  dimension: subscription_amount{
    type: number
    sql: ${unit_amount_in_cents}/100 ;;
    value_format_name: usd_0
  }

  dimension: user_id {
    type: number
    hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  dimension: uuid {
    type: string
    sql: ${TABLE}.uuid ;;
  }

  dimension: subscription_length_in_days {
    type: number
    sql: ${canceled_date}-${created_date} ;;
    description: "Number of days between Cancellation Date and Created Date"
  }


########### Measures ###############

  measure: avg_subscription_length_in_days {
    type: average
    sql: ${subscription_length_in_days} ;;
  }

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
      field: recurly_subscription.active_subscription
      value: "yes"
    }
    drill_fields: [detail*]
   }

  measure: recurly_7_day_new_subscriber_count {
    type: count_distinct
    sql: ${user_id} ;;
    filters: {
      field: recurly_subscription.created_date
      value: "7 days"
    }
    filters: {
      field: recurly_subscription.active_subscription
      value: "yes"
    }
    drill_fields: [detail*]

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
      user_id,
      users.email,
      uuid
            ]
  }
}
