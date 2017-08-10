view: plan_setup_fee {
  sql_table_name: recurly.plan_setup_fee ;;

  dimension: currency {
    type: string
    sql: ${TABLE}.currency ;;
  }

  dimension: plan_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.plan_id ;;
  }

  dimension: value {
    type: number
    sql: ${TABLE}.value ;;
  }

  measure: count {
    type: count
    drill_fields: [plan.id, plan.unit_name, plan.name]
  }
}
