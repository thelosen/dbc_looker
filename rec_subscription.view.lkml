view: rec_subscription {
  sql_table_name: recurly.subscription ;;

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: account_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.account_id ;;
  }

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

  dimension: add_on_amount {
    type: number
    sql: ${TABLE}.add_on_amount ;;
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

  dimension: collection_method {
    type: string
    sql: ${TABLE}.collection_method ;;
  }

  dimension: currency {
    type: string
    sql: ${TABLE}.currency ;;
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

  dimension: net_terms {
    type: number
    sql: ${TABLE}.net_terms ;;
  }

  dimension: plan_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.plan_id ;;
  }

  dimension: po_number {
    type: number
    sql: ${TABLE}.po_number ;;
  }

  dimension: quantity {
    type: number
    sql: ${TABLE}.quantity ;;
  }

  dimension: remaining_billing_cycles {
    type: number
    sql: ${TABLE}.remaining_billing_cycles ;;
  }

  dimension: revenue_schedule_type {
    type: string
    sql: ${TABLE}.revenue_schedule_type ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: tax {
    type: number
    sql: ${TABLE}.tax ;;
  }

  dimension: tax_rate {
    type: number
    sql: ${TABLE}.tax_rate ;;
  }

  dimension: tax_region {
    type: string
    sql: ${TABLE}.tax_region ;;
  }

  dimension: tax_type {
    type: string
    sql: ${TABLE}.tax_type ;;
  }

  dimension: total_billing_cycles {
    type: number
    sql: ${TABLE}.total_billing_cycles ;;
  }

  dimension: total_recurring_amount {
    type: number
    sql: ${TABLE}.total_recurring_amount ;;
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

  dimension: unit_amount {
    type: number
    sql: ${TABLE}.unit_amount ;;
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

  dimension: cancellation_timing_days{
    type: number
    sql:  CASE WHEN ${canceled_date} = NULL THEN NULL
          ELSE ${canceled_date}-${rec_account.created_date}
          END ;;
    description: "# Days between recurly account creation date & subscription cancellation date"
  }


  dimension: cancellation_timing_grouping {
    type: string
    sql: CASE WHEN ${cancellation_timing_days} is NULL THEN '14. Not canceled'
      WHEN ${cancellation_timing_days} < 8 THEN '01. Week 1'
      WHEN ${cancellation_timing_days} < 15 THEN '02. Week 2'
      WHEN ${cancellation_timing_days} < 22 THEN '03. Week 3'
      WHEN ${cancellation_timing_days} < 29 THEN '04. Week 4'
      WHEN ${cancellation_timing_days} < 36 THEN '05. Week 5'
      WHEN ${cancellation_timing_days} < 43 THEN '06. Week 6'
      WHEN ${cancellation_timing_days} < 50 THEN '07. Week 7'
      WHEN ${cancellation_timing_days} < 57 THEN '08. Week 8'
      WHEN ${cancellation_timing_days} < 64 THEN '09. Week 9'
      WHEN ${cancellation_timing_days} < 71 THEN '10. Week 10'
      WHEN ${cancellation_timing_days} < 78 THEN '11. Week 11'
      WHEN ${cancellation_timing_days} < 85 THEN '12. Week 12'
      ELSE '13. After Week 12' END ;;
  }

  dimension: subscription_canceled_within_14_days_of_recurly_account_creation {
    type: yesno
    sql:  CASE WHEN ${cancellation_timing_days} = NULL THEN NULL
          CASE WHEN ${cancellation_timing_days} <15 THEN TRUE
           ELSE FALSE
          END ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: average_account_length_in_days {
    type: average
    sql: ${cancellation_timing_days} ;;
  }

  measure: average_billing_cycles_completed {
    type: average
    sql: (${total_billing_cycles}+1);;
    description: "1st Payment = Billing Cycle #1"
    ##first payment is on account not on subscription - thus the +1 to acccount for the intital payment
  }


  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      account.id,
      account.company_name,
      account.last_name,
      account.first_name,
      account.username,
      plan.id,
      plan.unit_name,
      plan.name,
      adjustment.count,
      invoice.count,
      transaction.count
    ]
  }
}
