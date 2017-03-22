# working around duplicates from recurly accounts table


view: recurly_accounts_derived {
  derived_table: {
    distribution_style: even
    sortkeys: ["user_id"]
    sql_trigger_value: SELECT COUNT(*) FROM mysql_heroku_app_db.recurly_accounts;;
    sql:
      SELECT
        user_id
      , min(created_at) as first_created
      , min(email) as email
      FROM mysql_heroku_app_db.recurly_accounts
      GROUP BY user_id
       ;;
  }


  ##### Dimensions ###############

dimension_group: first_created {
  type: time
  timeframes: [
    date,
    week,
    month,
    quarter,
    year
  ]
  sql: ${TABLE}.first_created ;;
}


dimension: email {
  type: string
  sql: ${TABLE}.email ;;
}

dimension: user_id {
  type: number
  # hidden: yes
  sql: ${TABLE}.user_id ;;
}

measure: count {
  type: count
  drill_fields: [detail*]
}


# ----- Sets of fields for drilling ------
set: detail {
  fields: [
    user_id,
    email
  ]
}
}
