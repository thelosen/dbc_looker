# kit id associated with customers initial subscription. Grabbing kit from first contact subscription or if not available, from first shop order. Contact subscriptions goes back farther than shop orders.
view: kit_initial_id {
  derived_table: {
    distribution_style: even
    sortkeys: ["user_id"]
    sql_trigger_value: SELECT COUNT(*) FROM mysql_heroku_app_db.contact_subscriptions;;
    sql:SELECT distinct user_id, min(kit_id) as kit_id
        FROM(
          SELECT DISTINCT first_subscription.user_id as user_id, kit_id.kit_id as kit_id
           FROM ((
             SELECT user_id, min(id) as first_id
             FROM mysql_heroku_app_db.contact_subscriptions
             GROUP BY user_id) first_subscription
            JOIN mysql_heroku_app_db.contact_subscriptions as kit_id ON (first_subscription.first_id = kit_id.id))
        UNION
         SELECT DISTINCT first_order.user_id as user_id, max(kit_id.kit_id) as kit_id
         FROM ((
          SELECT user_id, min(id) as id
          FROM mysql_heroku_app_db.shop_orders
          GROUP BY user_id) first_order
          INNER JOIN mysql_heroku_app_db.shop_order_items as kit_id ON (first_order.id = kit_id.order_id))
         GROUP BY first_order.user_id)
        GROUP BY user_id;;

  }

  ##### Dimensions ###############

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
      user_id,
      initial_kit_id
        ]
  }
}
