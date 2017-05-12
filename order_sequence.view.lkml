
view: order_sequence {
  derived_table: {
    distribution_style: even
    sortkeys: ["id"]
    sql_trigger_value: SELECT COUNT(*) FROM ${shop_orders.SQL_TABLE_NAME};;
    sql:  SELECT id
          , order_sequence
          FROM
          (SELECT id
          , created_at
          , user_id
          , ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY created_at)
          as order_sequence
          FROM ${shop_orders.SQL_TABLE_NAME});;
 }

  ################## Dimensions #######################

  dimension: id {
    type: number
    primary_key: yes
    hidden: yes
  }

  dimension: order_sequence {
    type:  number
  }

  dimension: is_first_order {
    type: yesno
    sql: ${order_sequence} = 1;;
  }

  dimension: is_renew_order {
    type: yesno
    sql: ${order_sequence} >= 2;;
  }


    ################## Measures #######################

  measure: renewal_order_count {
    type: count_distinct
    sql:  ${TABLE}.id;;
    filters: {field:is_first_order value:"no"}
  }

  measure: first_order_count {
    type: count_distinct
    sql:  ${TABLE}.id;;
    filters: {field:is_first_order value:"yes"}
  }


  }
