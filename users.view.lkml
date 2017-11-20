view: users {
  sql_table_name: mysql_heroku_app_db.users ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: ambassador {
    type: number
    sql: ${TABLE}.ambassador ;;
  }

  dimension: cart_bail_token {
    type: string
    sql: ${TABLE}.cart_bail_token ;;
  }

  dimension: contact_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.contact_id ;;
    hidden: yes
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
    hidden: yes
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
    hidden: yes
  }

  dimension: is_set_password {
    type: string
    sql: ${TABLE}.is_set_password ;;
    hidden: yes
  }

  dimension_group: last_login {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.last_login ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: permissions {
    type: string
    sql: ${TABLE}.permissions ;;
  }

  dimension: phone_number {
    type: string
    sql: ${TABLE}.phone_number ;;
  }

  dimension: remember_token {
    type: string
    sql: ${TABLE}.remember_token ;;
    hidden: yes
  }

  dimension_group: updated {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.updated_at ;;
    hidden: yes
  }

  dimension: user_avatar {
    type: string
    sql: ${TABLE}.user_avatar ;;
  }

  dimension: months_a_customer {
  type: number
  sql: datediff(month, ${pdt_user_fact.first_order_raw}, ${pdt_user_fact.most_recent_order_raw}) +1;;
  }


  ################## Measures #################

  measure: user_count {
    drill_fields: [detail*]
    type: count_distinct
    sql:  ${TABLE}.id ;;
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      users.id,
      users.email,
      users.created_date,
      contacts.state,
      contacts.country,
      pdt_user_fact.lifetime_order_amount_dim,
      pdt_user_fact.lifetime_order_count_dim,
      pdt_user_fact.average_order_amount,
      pdt_user_fact.most_recent_order_date
    ]
  }
}
