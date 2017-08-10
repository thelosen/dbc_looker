view: invoice {
  sql_table_name: recurly.invoice ;;

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

  dimension: invoice_address_1 {
    type: string
    sql: ${TABLE}.invoice_address_1 ;;
  }

  dimension: invoice_address_2 {
    type: string
    sql: ${TABLE}.invoice_address_2 ;;
  }

  dimension: invoice_city {
    type: string
    sql: ${TABLE}.invoice_city ;;
  }

  dimension: invoice_country {
    type: string
    sql: ${TABLE}.invoice_country ;;
  }

  dimension: invoice_number {
    type: number
    sql: ${TABLE}.invoice_number ;;
  }

  dimension: invoice_phone {
    type: string
    sql: ${TABLE}.invoice_phone ;;
  }

  dimension: invoice_state {
    type: string
    sql: ${TABLE}.invoice_state ;;
  }

  dimension: invoice_zip {
    type: string
    sql: ${TABLE}.invoice_zip ;;
  }

  dimension: net_terms {
    type: number
    sql: ${TABLE}.net_terms ;;
  }

  dimension: po_number {
    type: number
    sql: ${TABLE}.po_number ;;
  }

  dimension: shipping_address_address_1 {
    type: string
    sql: ${TABLE}.shipping_address_address_1 ;;
  }

  dimension: shipping_address_address_2 {
    type: string
    sql: ${TABLE}.shipping_address_address_2 ;;
  }

  dimension: shipping_address_city {
    type: string
    sql: ${TABLE}.shipping_address_city ;;
  }

  dimension: shipping_address_country {
    type: string
    sql: ${TABLE}.shipping_address_country ;;
  }

  dimension: shipping_address_name {
    type: string
    sql: ${TABLE}.shipping_address_name ;;
  }

  dimension: shipping_address_phone {
    type: string
    sql: ${TABLE}.shipping_address_phone ;;
  }

  dimension: shipping_address_state {
    type: string
    sql: ${TABLE}.shipping_address_state ;;
  }

  dimension: shipping_address_zip {
    type: string
    sql: ${TABLE}.shipping_address_zip ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: subscription_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.subscription_id ;;
  }

  dimension: subtotal {
    type: number
    sql: ${TABLE}.subtotal ;;
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

  dimension: total {
    type: number
    sql: ${TABLE}.total ;;
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

  dimension: vat_number {
    type: number
    sql: ${TABLE}.vat_number ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      shipping_address_name,
      subscription.id,
      account.id,
      account.company_name,
      account.last_name,
      account.first_name,
      account.username,
      adjustment.count,
      transaction.count
    ]
  }
}
