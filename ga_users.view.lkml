view: ga_users {
  sql_table_name: ga.users ;;

  dimension: campaign {
    type: string
    sql: ${TABLE}.campaign ;;
  }

  dimension_group: date {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date ;;
  }

  dimension: device_category {
    type: string
    sql: ${TABLE}.device_category ;;
  }

  dimension: goal_1_completions {
    type: number
    sql: ${TABLE}.goal_1_completions ;;
  }

  dimension: goal_4_completions {
    type: number
    sql: ${TABLE}.goal_4_completions ;;
  }

  dimension: goal_5_completions {
    type: number
    sql: ${TABLE}.goal_5_completions ;;
  }

  dimension: goal_6_completions {
    type: number
    sql: ${TABLE}.goal_6_completions ;;
  }

  dimension: landing_page_path {
    type: string
    sql: ${TABLE}.landing_page_path ;;
  }

  dimension: medium {
    type: string
    sql: ${TABLE}.medium ;;
  }

  dimension: operating_system {
    type: string
    sql: ${TABLE}.operating_system ;;
  }

  dimension: profile {
    type: string
    sql: ${TABLE}.profile ;;
  }

  dimension: source {
    type: string
    sql: ${TABLE}.source ;;
  }

  dimension: transaction_revenue {
    type: number
    sql: ${TABLE}.transaction_revenue ;;
  }

  dimension: transactions {
    type: number
    sql: ${TABLE}.transactions ;;
  }

  dimension: unique_id {
    type: number
    sql: ${TABLE}.unique_id ;;
  }

  dimension: users {
    type: number
    sql: ${TABLE}.users ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
