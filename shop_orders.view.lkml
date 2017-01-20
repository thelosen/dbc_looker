view: shop_orders {
  sql_table_name: mysql_heroku_app_db.shop_orders ;;

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
    timeframes: [time, date, week, month]
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
    view_label: "Shipwire"
  }

  dimension: shipwire_externalid {
    type: string
    sql: ${TABLE}.shipwire_externalid ;;
    view_label: "Shipwire"
    hidden: yes
  }

  dimension: shipwire_id {
    type: number
    sql: ${TABLE}.shipwire_id ;;
    view_label: "Shipwire"
  }

  dimension: shipwire_last_topic {
    type: string
    sql: ${TABLE}.shipwire_last_topic ;;
    view_label: "Shipwire"
  }

  dimension: shipwire_orderno {
    type: number
    sql: ${TABLE}.shipwire_orderno ;;
    view_label: "Shipwire"
  }

  dimension: shipwire_status {
    type: string
    sql: ${TABLE}.shipwire_status ;;
    view_label: "Shipwire"
  }

  dimension: shipwire_summary {
    type: string
    sql: ${TABLE}.shipwire_summary ;;
    view_label: "Shipwire"
  }

  dimension_group: shipwire_summarydate {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.shipwire_summarydate ;;
    view_label: "Shipwire"
  }

  dimension_group: shipwire_trackeddate {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.shipwire_trackeddate ;;
    view_label: "Shipwire"
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
    hidden: yes
  }

  dimension: user_orders_count {
    type: number
    sql: ${TABLE}.user_orders_count ;;
  }


################# Measures #######################
  measure: tax_in_cents {
    type: sum
    sql: ${TABLE}.tax_in_cents / 100.0 ;;
  }

  measure: carrier_charge {
    type: sum
    sql: ${TABLE}.carrier_charge ;;
  }
}
