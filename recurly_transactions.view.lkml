view: recurly_transactions {
  sql_table_name: mysql_heroku_app_db.recurly_transactions ;;

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

  dimension: action {
    type: string
    sql: ${TABLE}.action ;;
  }

  dimension: amount_in_cents {
    type: number
    sql: ${TABLE}.amount_in_cents ;;
  }

  dimension: audit_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.audit_id ;;
  }

  dimension: avs_result {
    type: string
    sql: ${TABLE}.avs_result ;;
  }

  dimension: avs_result_postal {
    type: string
    sql: ${TABLE}.avs_result_postal ;;
  }

  dimension: avs_result_street {
    type: string
    sql: ${TABLE}.avs_result_street ;;
  }

  dimension: chargedback {
    type: number
    sql: ${TABLE}.chargedback ;;
  }

  dimension_group: collected {
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
    sql: ${TABLE}.collected_at ;;
  }

  dimension: contact_card_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.contact_card_id ;;
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

  dimension: customer_message {
    type: string
    sql: ${TABLE}.customer_message ;;
  }

  dimension: cvv_result {
    type: string
    sql: ${TABLE}.cvv_result ;;
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

  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
  }

  dimension: details {
    type: string
    sql: ${TABLE}.details ;;
  }

  dimension: error_category {
    type: string
    sql: ${TABLE}.error_category ;;
  }

  dimension: error_code {
    type: string
    sql: ${TABLE}.error_code ;;
  }

  dimension: gateway {
    type: string
    sql: ${TABLE}.gateway ;;
  }

  dimension: gateway_error_code {
    type: string
    sql: ${TABLE}.gateway_error_code ;;
  }

  dimension: gateway_error_codes {
    type: string
    sql: ${TABLE}.gateway_error_codes ;;
  }

  dimension: gateway_type {
    type: string
    sql: ${TABLE}.gateway_type ;;
  }

  dimension: invoice_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.invoice_id ;;
  }

  dimension: invoice_number {
    type: number
    sql: ${TABLE}.invoice_number ;;
  }

  dimension: invoice_number_prefix {
    type: string
    sql: ${TABLE}.invoice_number_prefix ;;
  }

  dimension: ip_address {
    type: string
    sql: ${TABLE}.ip_address ;;
  }

  dimension: merchant_message {
    type: string
    sql: ${TABLE}.merchant_message ;;
  }

  dimension: message {
    type: string
    sql: ${TABLE}.message ;;
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension: origin {
    type: string
    sql: ${TABLE}.origin ;;
  }

  dimension: original_invoice {
    type: number
    sql: ${TABLE}.original_invoice ;;
  }

  dimension: original_transaction {
    type: string
    sql: ${TABLE}.original_transaction ;;
  }

  dimension: original_transaction_id {
    type: string
    sql: ${TABLE}.original_transaction_id ;;
  }

  dimension: payment_method {
    type: string
    sql: ${TABLE}.payment_method ;;
  }

  dimension: recurly_billing_info_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.recurly_billing_info_id ;;
  }

  dimension: recurring {
    type: yesno
    sql: ${TABLE}.recurring ;;
  }

  dimension: reference {
    type: string
    sql: ${TABLE}.reference ;;
  }

  dimension: refundable {
    type: string
    sql: ${TABLE}.refundable ;;
  }

  dimension: refunded {
    type: number
    sql: ${TABLE}.refunded ;;
  }

  dimension: source {
    type: string
    sql: ${TABLE}.source ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: subscription_id {
    type: string
    sql: ${TABLE}.subscription_id ;;
  }

  dimension: tax_in_cents {
    type: number
    sql: ${TABLE}.tax_in_cents ;;
  }

  dimension: test {
    type: yesno
    sql: ${TABLE}.test ;;
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

  dimension: voidable {
    type: yesno
    sql: ${TABLE}.voidable ;;
  }

########### Measures ###############

  measure: Total_Amount {
    type: sum
    sql: ${TABLE}.amount_in_cents/100.0 ;;
    value_format_name: usd_0
  }

  measure: Tax {
    type: sum
    sql: ${TABLE}.tax_in_cents/100.0 ;;
    value_format_name: usd_0
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      recurly_billing_info.id,
      recurly_billing_info.first_name,
      recurly_billing_info.last_name,
      contact_cards.id,
      contact_cards.name,
      contact_cards.card_name,
      invoices.id,
      audit.id
    ]
  }
}
