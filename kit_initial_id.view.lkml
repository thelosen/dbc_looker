# kit id associated with customers initial subscription

view: kit_initial_id {
  derived_table: {
    distribution_style: even
    sortkeys: ["user_id"]
    sql_trigger_value: SELECT COUNT(*) FROM mysql_heroku_app_db.contact_subscriptions;;
    sql:SELECT DISTINCT first_subscription.user_id as user_id,
            min(first_subscription.first_created) as first_created,
            max(kit_id.kit_id) as kit_id
        FROM ((
          SELECT user_id,
            min(created_at) as first_created
          FROM mysql_heroku_app_db.contact_subscriptions
          GROUP BY user_id) first_subscription
          INNER JOIN mysql_heroku_app_db.contact_subscriptions as kit_id ON (first_subscription.user_id = kit_id.user_id AND first_subscription.first_created = kit_id.created_at))
        GROUP BY first_subscription.user_id;;
  }

  ##### Dimensions ###############

  dimension_group: first_created {
    hidden: yes
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.first_created ;;
  }

  dimension: user_id {
    hidden: yes
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension: initial_kit_id {
    type: number
    sql: ${TABLE}.kit_id ;;
  }


# ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      user_id
        ]
  }
}
