view: rec_account {
  sql_table_name: recurly.account ;;

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: account_address_1 {
    type: string
    sql: ${TABLE}.account_address_1 ;;
  }

  dimension: account_address_2 {
    type: string
    sql: ${TABLE}.account_address_2 ;;
  }

  dimension: account_city {
    type: string
    sql: ${TABLE}.account_city ;;
  }

  dimension: account_country {
    type: string
    sql: ${TABLE}.account_country ;;
  }

  dimension: account_phone {
    type: string
    sql: ${TABLE}.account_phone ;;
  }

  dimension: account_state {
    type: string
    sql: ${TABLE}.account_state ;;
  }

  dimension: account_zip {
    type: string
    sql: ${TABLE}.account_zip ;;
  }

  dimension: cc_emails {
    type: string
    sql: ${TABLE}.cc_emails ;;
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

  dimension: company_name {
    type: string
    sql: ${TABLE}.company_name ;;
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

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: has_active_subscription {
    type: yesno
    sql: ${TABLE}.has_active_subscription ;;
  }

  dimension: has_canceled_subscription {
    type: yesno
    sql: ${TABLE}.has_canceled_subscription ;;
  }

  dimension: has_future_subscription {
    type: yesno
    sql: ${TABLE}.has_future_subscription ;;
  }

  dimension: has_live_subscription {
    type: yesno
    sql: ${TABLE}.has_live_subscription ;;
  }

  dimension: has_past_due_invoice {
    type: yesno
    sql: ${TABLE}.has_past_due_invoice ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
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

  dimension: username {
    type: string
    sql: ${TABLE}.username ;;
  }

  dimension: vat_number {
    type: string
    sql: ${TABLE}.vat_number ;;
  }

  dimension: has_active_or_future_subscription {
    type: yesno
    sql: CASE WHEN ${has_active_subscription} = TRUE THEN TRUE
              WHEN ${has_future_subscription} = TRUE THEN TRUE
              ELSE FALSE
         END ;;
  }


  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: Number_of_Successful_Purchase_Transactions_Past_3_Weeks {
    type: count_distinct
      sql:${rec_transaction.id};;
      filters: {
        field: rec_transaction.action
        value: "Purchase"
        }
      filters: {
        field: rec_transaction.status
        value: "Success"
        }
      filters: {
        field: rec_transaction.created_date
        value: "21 Days"
      }

  }

  measure: Number_of_Refund_Transactions_Past_3_Weeks {
    type: count_distinct
    sql:${rec_transaction.id};;
    filters: {
      field: rec_transaction.action
      value: "Refund"
    }
    filters: {
      field: rec_transaction.status
      value: "Success"
    }
    filters: {
      field: rec_transaction.created_date
      value: "21 Days"
    }

  }


  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      company_name,
      last_name,
      first_name,
      username,
      email,
      adjustment.count,
      invoice.count,
      subscription.count,
      transaction.count

    ]
  }
}
