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
    hidden: yes
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



  ################## Measures #################

  measure: user_count {
    type: count_distinct
    sql:  ${TABLE}.id ;;
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      user_id,
      first_name,
      last_name,
      contacts.id,
      contacts.first_name,
      contacts.last_name,
      _accounts_missing.count,
      activations.count,
      ambassadors.count,
      contact_subscriptions.count,
      contacts.count,
      persistences.count,
      product.count,
      product_cart.count,
      product_category.count,
      product_kits.count,
      recurly_accounts.count,
      recurly_logs.count,
      recurly_subscription.count,
      reminders.count,
      revisions.count,
      role_users.count,
      sessions.count,
      shop_orders.count,
      survey.count,
      user_temp_cart_products.count,
      v2_contact_subscription.count,
      v2_contacts.count,
      v2_shop_orders.count,
      v2_users.count
    ]
  }
}
