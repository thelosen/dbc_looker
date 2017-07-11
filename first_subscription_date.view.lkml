# getting the earliest subscription date and order date for each user


view: first_subscription_date {
  derived_table: {
    distribution_style: even
    sortkeys: ["user_id"]
    sql_trigger_value: SELECT COUNT(*) FROM mysql_heroku_app_db.recurly_subscription;;
    sql:
      SELECT
        user_id,
        min(created_at) as first_created
        FROM (
          SELECT
          recurly_subscription.user_id as user_id,
          recurly_subscription.created_at as created_at
          FROM mysql_heroku_app_db.recurly_subscription
          UNION ALL
          SELECT
          v2_contact_subscription.user_id as user_id,
          v2_contact_subscription.created_at as created_at
          FROM public.v2_contact_subscription)
        GROUP BY user_id;;
  }

  ##### Dimensions ###############

  dimension_group: first_created {
    type: time
    timeframes: [
      raw,
      date,
      day_of_year,
      week_of_year,
      day_of_month,
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
    type: count_distinct
    sql:${user_id};;
    drill_fields: [detail*]
  }


# ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      user_id
        ]
  }
}
