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

  measure: count {
    type: count
    drill_fields: [detail*]
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
