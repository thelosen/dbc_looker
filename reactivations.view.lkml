
view: reactivations {
  derived_table: {
    distribution_style: even
    sortkeys: ["id"]
    sql_trigger_value: SELECT COUNT(*) FROM mysql_heroku_app_db.recurly_subscription;;
    sql:
      SELECT rs.id as id_, rs.user_id as user_id_, rs.created_at as created_at_, Max(os.created_at) as previous_order_date, Max(os.order_sequence) as total_orders_before
        FROM mysql_heroku_app_db.recurly_subscription rs
        LEFT JOIN looker.lr$4xyrp2wpds3uodq00tzfc_order_sequence os on (rs.user_id = os.user_id AND dateadd(day,-2,rs.created_at) > os.created_at)
        GROUP BY rs.id, rs.user_id, rs.created_at;;
  }

  ################## Dimensions #######################

  dimension: subscription_id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.id_;;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id_ ;;
  }

  dimension_group: subscription_created_at {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.created_at_ ;;
  }

 dimension_group: previous_order_date {
  type: time
  timeframes: [time, date, week, month]
  sql: ${TABLE}.previous_order_date ;;
  }

  dimension: total_orders_before {
    type: number
    sql: ${TABLE}.total_orders_before;;
  }

  dimension: days_since_last_order {
    sql: datediff(day,${subscription_created_at_date}-${previous_order_date_date} ;;
  }

############ measures ###########

  measure: user_count {
    drill_fields: [detail*]
    type: count_distinct
    sql:  ${user_id} ;;
  }

  measure: average_days_since_last_order {
    type: average
    sql: ${days_since_last_order} ;;
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      users.id,
      users.email,
      days_since_last_order,
      previous_order_date_date,
      total_orders_before
    ]
  }
}
