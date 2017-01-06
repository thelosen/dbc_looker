view: invoices {
  sql_table_name: mysql_heroku_app_db.invoices ;;

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
    timeframes: [time, date, week, month]
    sql: ${TABLE}._fivetran_synced ;;
  }

  dimension: account_id {
    type: number
    sql: ${TABLE}.account_id ;;
  }

  dimension: billing_info_id {
    type: number
    sql: ${TABLE}.billing_info_id ;;
  }

  dimension_group: created {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: deleted {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.deleted_at ;;
  }

  dimension: invoice_number {
    type: number
    sql: ${TABLE}.invoice_number ;;
  }

  dimension: is_mail_sent {
    type: number
    sql: ${TABLE}.is_mail_sent ;;
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension: shipping_charges_in_cents {
    type: number
    sql: ${TABLE}.shipping_charges_in_cents ;;
  }

  dimension: total_amount_in_cents {
    type: number
    sql: ${TABLE}.total_amount_in_cents ;;
  }

  dimension: transaction_id {
    type: number
    sql: ${TABLE}.transaction_id ;;
  }

  dimension_group: updated {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.updated_at ;;
  }

  measure: count {
    type: count
    drill_fields: [id, recurly_transactions.count]
  }
}
