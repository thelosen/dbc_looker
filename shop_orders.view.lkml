view: shop_orders {
  sql_table_name: mysql_heroku_app_db.shop_orders ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: _fivetran_deleted {
    type: yesno
    sql: ${TABLE}._fivetran_deleted ;;
  }

  dimension_group: _fivetran_synced {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}._fivetran_synced ;;
  }

  dimension: billing_address_id {
    type: number
    sql: ${TABLE}.billing_address_id ;;
  }

  dimension: carrier {
    type: string
    sql: ${TABLE}.carrier ;;
  }

  dimension: carrier_charge {
    type: number
    sql: ${TABLE}.carrier_charge ;;
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
  }

  dimension_group: processafterdate {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.processafterdate ;;
  }

  dimension: shipping_address_id {
    type: number
    sql: ${TABLE}.shipping_address_id ;;
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
  }

  dimension: subtotal {
    type: number
    sql: ${TABLE}.subtotal ;;
  }

  dimension: tax_in_cents {
    type: number
    sql: ${TABLE}.tax_in_cents ;;
  }

  dimension: total_price {
    type: number
    sql: ${TABLE}.total_price ;;
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
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  dimension: user_orders_count {
    type: number
    sql: ${TABLE}.user_orders_count ;;
  }

  measure: count {
    type: count
    drill_fields: [id, users.first_name, users.last_name, users.user_id]
  }
}
