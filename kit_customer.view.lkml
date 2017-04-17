# does customer have kit associated

  view: kit_customer {
    derived_table: {
      distribution_style: even
      sortkeys: ["user_id"]
      sql_trigger_value: SELECT COUNT(*) FROM mysql_heroku_app_db.contact.subscriptions;;
      sql:
      SELECT user_id, count(distinct kit_id) as number_of_kits
      FROM mysql_heroku_app_db.contact.subscriptions
        GROUP BY user_id;;
    }

    ################## Dimensions #######################

    dimension: user_id {
      primary_key: yes
      hidden: yes
      type: number
      sql: ${TABLE}.user_id ;;
    }

    dimension: number_of_kits {
      type: number
      sql: ${TABLE}.number_of_kits -1 ;;
      description: "Number of kit groups customer belongs to"
    }

  }
