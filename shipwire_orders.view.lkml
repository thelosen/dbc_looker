view: shipwire_orders {
  sql_table_name: mysql_heroku_app_db.shipwire_orders ;;

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

  dimension: audit_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.audit_id ;;
  }

  dimension: data {
    type: string
    sql: ${TABLE}.data ;;
  }

  dimension: externalid {
    type: string
    sql: ${TABLE}.externalid ;;
  }

  dimension_group: lastupdateddate {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.lastupdateddate ;;
  }

  dimension: legacyorderno {
    type: string
    sql: ${TABLE}.legacyorderno ;;
  }

  dimension: orderno {
    type: number
    sql: ${TABLE}.orderno ;;
  }

  dimension_group: processafterdate {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.processafterdate ;;
  }

  dimension: ship_to {
    type: string
    sql: ${TABLE}.ship_to ;;
  }

  dimension: ship_to_email {
    type: string
    sql: ${TABLE}.ship_to_email ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: transactionid {
    type: string
    sql: ${TABLE}.transactionid ;;
  }

  measure: count {
    type: count
    drill_fields: [id, audit.id]
  }
}
