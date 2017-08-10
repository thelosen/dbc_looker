view: plan {
  sql_table_name: recurly.plan ;;

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: accounting_code {
    type: string
    sql: ${TABLE}.accounting_code ;;
  }

  dimension: cancel_url {
    type: string
    sql: ${TABLE}.cancel_url ;;
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

  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
  }

  dimension: display_quantity {
    type: yesno
    sql: ${TABLE}.display_quantity ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: plan_interval_length {
    type: number
    sql: ${TABLE}.plan_interval_length ;;
  }

  dimension: plan_interval_unit {
    type: string
    sql: ${TABLE}.plan_interval_unit ;;
  }

  dimension: revenue_schedule_type {
    type: string
    sql: ${TABLE}.revenue_schedule_type ;;
  }

  dimension: setup_fee_accounting_code {
    type: string
    sql: ${TABLE}.setup_fee_accounting_code ;;
  }

  dimension: setup_fee_revenue_schedule_type {
    type: string
    sql: ${TABLE}.setup_fee_revenue_schedule_type ;;
  }

  dimension: success_url {
    type: string
    sql: ${TABLE}.success_url ;;
  }

  dimension: tax_code {
    type: string
    sql: ${TABLE}.tax_code ;;
  }

  dimension: tax_exempt {
    type: yesno
    sql: ${TABLE}.tax_exempt ;;
  }

  dimension: total_billing_cycles {
    type: string
    sql: ${TABLE}.total_billing_cycles ;;
  }

  dimension: trial_interval_length {
    type: number
    sql: ${TABLE}.trial_interval_length ;;
  }

  dimension: trial_interval_unit {
    type: string
    sql: ${TABLE}.trial_interval_unit ;;
  }

  dimension: unit_name {
    type: string
    sql: ${TABLE}.unit_name ;;
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
      unit_name,
      name,
      plan_setup_fee.count,
      plan_unit_amount.count,
      subscription.count
    ]
  }
}
