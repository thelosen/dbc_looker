view: subscriber_status {
  derived_table: {
    distribution_style: even
    sortkeys: ["id"]
    sql_trigger_value: SELECT COUNT(*) FROM mysql_heroku_app_db.users;;
    sql: select
      DISTINCT users.id, 'active' as status
      FROM mysql_heroku_app_db.users as users
      LEFT JOIN mysql_heroku_app_db.recurly_subscription as recurly_subscription ON users.id = recurly_subscription.user_id
      WHERE recurly_subscription.state IN ('active','future')
      UNION
      Select
      DISTINCT users.id, 'inactive' as status
      FROM mysql_heroku_app_db.users as users
      LEFT JOIN mysql_heroku_app_db.recurly_subscription as recurly_subscription ON users.id = recurly_subscription.user_id;;
  }

  ##### Dimensions ###############

  dimension: user_id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.id ;;
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
