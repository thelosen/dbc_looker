# kit id associated with first order. kits were introduced in 11/2016. Using kit info from contact subscriptions and shop order to determine initial kit id.
view: kit_initial_id {
  derived_table: {
    distribution_style: even
    sortkeys: ["user_id"]
    sql_trigger_value: SELECT COUNT(*) FROM ${shop_orders.SQL_TABLE_NAME};;
    sql:
        SELECT CASE
          WHEN cs.user_id IS NOT NULL THEN cs.user_id
          WHEN so.user_id IS NOT NULL THEN so.user_id
          ELSE NULL
          END as user_id
        , CASE
          WHEN first_created IS NOT NULL AND <'2016-11-01 00:00:00' THEN 0
          WHEN first_order_date IS NOT NULL AND <'2016-11-01 00:00:00' THEN 0
          WHEN cs_initial_kit_id IS NOT NULL THEN cs_initial_kit_id
          WHEN so_initial_kit_id IS NOT NULL THEN so_initial_kit_id
          ELSE 0
          END as initial_kit_id
        FROM(
        --define rules for initial_kit_id from contact_subscriptions based on date
            SELECT DISTINCT user_id
                , kit_id as cs_initial_kit_id
                , first_created
            FROM(
          --define first subscription created and kit id for that subscription in contact_subscriptions there are no null values
              SELECT DISTINCT first_subscription.user_id as user_id
              , max(kit_id.kit_id) as kit_id
              , min(created_at) as first_created
              FROM ((
                SELECT user_id, min(id) as id, min(created_at) as first_created
                FROM mysql_heroku_app_db.contact_subscriptions
                GROUP BY contact_subscriptions.user_id) first_subscription
                INNER JOIN mysql_heroku_app_db.contact_subscriptions as kit_id ON first_subscription.id = kit_id.id)
                GROUP BY first_subscription.user_id)) cs
        FULL OUTER JOIN
        --define rules for initial_kit_id from shop orders based on date
            (SELECT DISTINCT user_id
                , kit_id as so_initial_kit_id
                , first_order_date
            FROM(
            --define first order created and kit id for that order from shop_order items
              SELECT DISTINCT user_id
              , max(kit_id) as kit_id
              , min(first_order_date) as first_order_date
              FROM ((
                SELECT user_id, min(id) as id, min(created_at) as first_order_date
                FROM  ${shop_orders.SQL_TABLE_NAME}
                GROUP BY user_id) first_order
                LEFT JOIN ${shop_order_items.SQL_TABLE_NAME} as kit_id ON first_order.id = kit_id.order_id)
                GROUP BY first_order.user_id)) so
          ON cs.user_id = so.user_id;;


  }

  ##### Dimensions ###############

  dimension: user_id {
    hidden: yes
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension: initial_kit_id {
    type: number
    sql: ${TABLE}.initial_kit_id ;;
  }


# ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      user_id,
      initial_kit_id
        ]
  }
}
