# cleaning up duplicates from recurly accounts table


view: first_subscription_date {
  derived_table: {
    distribution_style: even
    sortkeys: ["user_id"]
    sql_trigger_value: SELECT COUNT(*) FROM mysql_heroku_app_db.recurly_subscription;;
    sql:
      SELECT
        user_id
      , min(created_at) as first_created
      FROM mysql_heroku_app_db.recurly_subscription
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

  dimension: user_id {
    type: number
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
      users.email
        ]
  }
}
