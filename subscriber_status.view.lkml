view: subscriber_status {
  derived_table: {
    distribution_style: even
    sortkeys: ["id"]
    sql_trigger_value: SELECT COUNT(*) FROM mysql_heroku_app_db.users;;
    sql:
      SELECT users.id,
          CASE WHEN active_users.user_id IS NOT NULL THEN 'active subscription'
              ELSE 'no active subscription'
              END as subscription_status

      FROM mysql_heroku_app_db.users users
      LEFT JOIN

      (SELECT DISTINCT user_id
      FROM mysql_heroku_app_db.recurly_subscription
      WHERE state IN ('active','future','past_due')) active_users

      ON users.id = active_users.user_id;;

  }

  ##### Dimensions ###############

  dimension: user_id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.id ;;
    }

  dimension: subscription_status {
    type: string
    sql: ${TABLE}.subscription_status ;;
  }

  dimension: has_active_subscription {
    type: yesno
    sql: ${subscription_status} = 'active subscription' ;;
  }

  }
