view: subscriber_status {
  derived_table: {
    distribution_style: even
    sortkeys: ["id"]
    sql_trigger_value: SELECT COUNT(*) FROM mysql_heroku_app_db.users;;
    sql:
      SELECT all.id as user_id,
            CASE WHEN status1 NOT NULL THEN status1
              ELSE status2
              END as status
      FROM
       (SELECT
        DISTINCT users.id, 'active' as status1
        FROM mysql_heroku_app_db.users as users
        LEFT JOIN mysql_heroku_app_db.recurly_subscription as recurly_subscription ON users.id = recurly_subscription.user_id
        WHERE recurly_subscription.state IN ('active','future')) active
      FULL OUTER JOIN
        (SELECT
        DISTINCT users.id, 'inactive' as status2
        FROM mysql_heroku_app_db.users as users
        LEFT JOIN mysql_heroku_app_db.recurly_subscription as recurly_subscription ON users.id = recurly_subscription.user_id) all
        ON active.id = all.id;;
  }

  ##### Dimensions ###############

  dimension: user_id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.user_id ;;
    }

  dimension: subscriber_recurly_status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: active_recurly_subscriber {
    type: yesno
    sql: ${subscriber_recurly_status} IN('active') ;;
  }

  }
