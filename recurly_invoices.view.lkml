view: recurly_invoices {
  sql_table_name: mysql_heroku_app_db.recurly_invoices ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: _fivetran_deleted {
    type: yesno
    sql: ${TABLE}._fivetran_deleted ;;
  }

  dimension_group: _fivetran_synced {
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
    sql: ${TABLE}._fivetran_synced ;;
  }

  dimension: account_code {
    type: string
    sql: ${TABLE}.account_code ;;
  }

  dimension: amount_remaining_in_cents {
    type: number
    sql: ${TABLE}.amount_remaining_in_cents ;;
  }

  dimension_group: closed {
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
    sql: ${TABLE}.closed_at ;;
  }

  dimension: collection_method {
    type: string
    sql: ${TABLE}.collection_method ;;
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

  dimension: currency {
    type: string
    sql: ${TABLE}.currency ;;
  }

  dimension: customer_notes {
    type: string
    sql: ${TABLE}.customer_notes ;;
  }

  dimension_group: date {
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
    sql: ${TABLE}.date ;;
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

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: invoice_number {
    type: number
    sql: ${TABLE}.invoice_number ;;
  }

  dimension: invoice_number_prefix {
    type: string
    sql: ${TABLE}.invoice_number_prefix ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: line_items {
    type: string
    sql: ${TABLE}.line_items ;;
  }

  dimension: net_terms {
    type: string
    sql: ${TABLE}.net_terms ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: subscription_id {
    type: string
    sql: ${TABLE}.subscription_id ;;
  }

  dimension: subtotal_in_cents {
    type: number
    sql: ${TABLE}.subtotal_in_cents ;;
  }

  dimension: tax_in_cents {
    type: number
    sql: ${TABLE}.tax_in_cents ;;
  }

  dimension: total_in_cents {
    type: number
    sql: ${TABLE}.total_in_cents ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
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

  dimension: uuid {
    type: string
    sql: ${TABLE}.uuid ;;
  }

  measure: count {
    type: count
    drill_fields: [
      id,
      last_name,
      first_name,
      closed_date,
      date_date,
      state,
      total_in_cents,
      invoice_number,
      invoice_number_prefix,
      created_date,
      amount_remaining_in_cents,
      account_code,
      recurly_subscription.state]
  }
}
