view: active_recurly_user_ids {
  derived_table: {
    distribution_style: even
    sortkeys: ["id"]
    sql_trigger_value: SELECT COUNT(*) FROM ${recurly_subscription.SQL_TABLE_NAME};;
    sql:
      SELECT DISTINCT user_id
      FROM mysql_heroku_app_db.recurly_subscription
      WHERE state IN ('active','future','past_due')
      GROUP BY user_id
       ;;
  }

  ##### Dimensions ###############

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
    hidden: yes
    primary_key: yes
  }

  }
