view: users {
  sql_table_name: mysql_heroku_app_db.users ;;

  dimension: user_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.user_id ;;
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

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: id {
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: is_set_password {
    type: string
    sql: ${TABLE}.is_set_password ;;
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

  dimension: password {
    type: string
    sql: ${TABLE}.password ;;
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
  }

  dimension_group: updated {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.updated_at ;;
  }

  dimension: user_avatar {
    type: string
    sql: ${TABLE}.user_avatar ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
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
