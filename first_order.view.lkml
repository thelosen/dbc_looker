# getting the earliest order for each user

  view: first_order {
    derived_table: {
      distribution_style: even
      sortkeys: ["id"]
      sql_trigger_value: SELECT COUNT(*) FROM mysql_heroku_app_db.shop_orders;;
      sql:
      SELECT *
      FROM mysql_heroku_app_db.shop_orders
      INNER JOIN
        (SELECT
        recurly_subscription.user_id as user_id2,
        min(recurly_subscription.created_at) as first_created,
        min(shop_orders.created_at) as first_order_created
        FROM mysql_heroku_app_db.recurly_subscription
        LEFT JOIN mysql_heroku_app_db.shop_orders ON recurly_subscription.user_id = shop_orders.user_id
        GROUP BY recurly_subscription.user_id) FOD ON
      shop_orders.user_id = FOD.user_id2 AND shop_orders.created_at = FOD.First_order_created;;
  }

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    label: "Order ID"
  }

  dimension: billing_address_id {
    type: number
    sql: ${TABLE}.billing_address_id ;;
    hidden: yes
  }

  dimension: carrier {
    type: string
    sql: ${TABLE}.carrier ;;
  }

  dimension_group: created {
    type: time
    timeframes: [time, date, week, month, raw]
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: deleted {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.deleted_at ;;
    hidden:  yes
  }

  dimension_group: processafterdate {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.processafterdate ;;
  }

  dimension: shipping_address_id {
    type: number
    sql: ${TABLE}.shipping_address_id ;;
    hidden: yes
  }

  dimension_group: shipwire_delivereddate {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.shipwire_delivereddate ;;
  }

  dimension: shipwire_externalid {
    type: string
    sql: ${TABLE}.shipwire_externalid ;;
  }

  dimension: shipwire_id {
    type: number
    sql: ${TABLE}.shipwire_id ;;
  }

  dimension: shipwire_last_topic {
    type: string
    sql: ${TABLE}.shipwire_last_topic ;;
  }

  dimension: shipwire_orderno {
    type: number
    sql: ${TABLE}.shipwire_orderno ;;
  }

  dimension: shipwire_status {
    type: string
    sql: ${TABLE}.shipwire_status ;;
  }

  dimension: shipwire_summary {
    type: string
    sql: ${TABLE}.shipwire_summary ;;
  }

  dimension_group: shipwire_summarydate {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.shipwire_summarydate ;;
  }

  dimension_group: shipwire_trackeddate {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.shipwire_trackeddate ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: stripe_order_id {
    type: string
    sql: ${TABLE}.stripe_order_id ;;
  }

  dimension: subscription_id {
    type: number
    sql: ${TABLE}.subscription_id ;;
    hidden: yes
  }

  dimension: subtotal {
    type: number
    sql: ${TABLE}.subtotal ;;
    hidden: yes
  }

  dimension: total_price {
    type: number
    sql: ${TABLE}.total_price ;;
    hidden: yes
  }

  dimension: trackings {
    type: string
    sql: ${TABLE}.trackings ;;
  }

  dimension_group: updated {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.updated_at ;;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension: user_orders_count {
    type: number
    sql: ${TABLE}.user_orders_count ;;
  }


################# Measures #######################
  measure: tax {
    type: sum
    sql: cast((${TABLE}.tax_in_cents / 100.0)  as float);;
    value_format_name: usd
  }

  measure: carrier_charge {
    type: sum
    sql: cast(${TABLE}.carrier_charge as float) ;;
    value_format_name: usd
  }

  measure: order_total {
    type: sum
    sql: cast(${TABLE}.total_price as float) ;;
    value_format_name: usd
    hidden: no
  }

  measure: order_subtotal {
    type: sum
    sql: cast(${TABLE}.subtotal as float) ;;
    value_format_name: usd
  }
}
