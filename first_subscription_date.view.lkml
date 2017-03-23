# getting the earliest subscription date and order date for each user


view: first_subscription_date {
  derived_table: {
    distribution_style: even
    sortkeys: ["user_id"]
    sql_trigger_value: SELECT COUNT(*) FROM mysql_heroku_app_db.recurly_subscription;;
    sql:
      SELECT
        recurly_subscription.user_id,
        min(recurly_subscription.created_at) as first_created,
        min(shop_orders.created_at) as first_order_created
        FROM mysql_heroku_app_db.recurly_subscription
        LEFT JOIN mysql_heroku_app_db.shop_orders ON recurly_subscription.user_id = shop_orders.user_id
        GROUP BY user_id;;
  }

  ##### Dimensions ###############

  dimension_group: first__created {
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

  dimension_group: first_order_created {
    type: time
    timeframes: [
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.first_order_created ;;
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
