# user fact table
# basic min, max, first, last, lifetime metrics
# doing some cleaning/exclusions to account for oddities

view: pdt_user_fact {
  derived_table: {
    distribution_style: even
    sortkeys: ["id"]
    sql_trigger_value: SELECT COUNT(*) FROM ${shop_orders.SQL_TABLE_NAME};;
    sql: select
      users.id
      , sum(shop_orders.total_price) as lifetime_order_amount
      , min(shop_orders.created_at) as first_order_timestamp
      , max(shop_orders.created_at) as most_recent_order_timestamp
      , count(distinct shop_orders.id) as lifetime_order_count
      , avg(shop_orders.total_price) as average_order_amount
      , min(shop_orders.id) as first_order_id
      FROM mysql_heroku_app_db.users
        LEFT JOIN ${shop_orders.SQL_TABLE_NAME} as shop_orders ON users.id = shop_orders.user_id
      WHERE 1=1
        --exclude orders where the carrier charge = the total price, these were often post shipment shipping charges
        and (case
              when carrier_charge is null and total_price is not null then true
              when carrier_charge <> total_price then true
             else false end)
      GROUP BY users.id
       ;;
  }

  ##### Dimensions ###############

  dimension: id {
    type: number
    sql: ${TABLE}.id ;;
    hidden: yes
    primary_key: yes
  }

  dimension: lifetime_order_amount_dim {
    type: number
    value_format_name: usd_0
    sql: ${TABLE}.lifetime_order_amount ;;
  }

  dimension_group: first_order {
    type: time
    timeframes: [date, week, month, raw]
    sql: ${TABLE}.first_order_timestamp ;;
  }

  dimension_group: first_order_no_conversion {
    type: time
    convert_tz: no
    hidden: yes
    timeframes: [date, week, month, raw]
    sql: ${TABLE}.first_order_timestamp ;;
  }

  dimension_group: most_recent_order {
    type: time
    timeframes: [date, week, month, raw]
    sql: ${TABLE}.most_recent_order_timestamp ;;
  }

  dimension: lifetime_order_count_dim {
    type: number
    sql: ${TABLE}.lifetime_order_count ;;
   }

  dimension: average_order_amount {
    type: number
    sql: ${TABLE}.average_order_amount ;;
    value_format_name: usd
  }

  dimension: first_order_id {
    type: number
    sql: ${TABLE}.first_order_id;;
  }

  dimension: lifetime_revenue_grouping {
    type: string
    sql: CASE WHEN ${TABLE}.lifetime_order_amount is NULL THEN '8. Not available'
      WHEN ${TABLE}.lifetime_order_amount < 25 THEN '1. Under $25'
      WHEN ${TABLE}.lifetime_order_amount < 50 THEN '2. $25 - $49.99'
      WHEN ${TABLE}.lifetime_order_amount < 75 THEN '3. $50 - $74.99'
      WHEN ${TABLE}.lifetime_order_amount < 100 THEN '4. $75 - $99.99'
      WHEN ${TABLE}.lifetime_order_amount < 150 THEN '5. $100 - $149.99'
      WHEN ${TABLE}.lifetime_order_amount < 250 THEN '6. $150 - $249.99'
      ELSE '7. Over $250' END ;;
  }

  dimension: average_order_amount_grouping {
    type: string
    sql:  CASE WHEN ${TABLE}.average_order_amount is NULL THEN '8. Not available'
      WHEN ${TABLE}.average_order_amount < 5 THEN '1. Under $5'
      WHEN ${TABLE}.average_order_amount < 10 THEN '2. $5 - $9.99'
      WHEN ${TABLE}.average_order_amount < 15 THEN '3. $10 - $14.99'
      WHEN ${TABLE}.average_order_amount < 20 THEN '4. $15 - $19.99'
      WHEN ${TABLE}.average_order_amount < 25 THEN '5. $20 - $24.99'
      WHEN ${TABLE}.average_order_amount < 30 THEN '6. $25 - $29.99'
      ELSE '7. Over $30' END;;
  }



  dimension: lifetime_revenue {
    type: number
    sql: ${TABLE}.lifetime_revenue ;;
    drill_fields: [detail*]
    value_format_name: usd
    description: "do not use - this doesnt appear to be a legit field"
  }

    #### Measures #################

  measure: lifetime_order_count {
    type: sum
    sql: ${TABLE}.lifetime_order_count ;;
  }

  measure: average_order_count {
    type: average
    sql: ${lifetime_order_count_dim} ;;
    value_format: "0.00"
  }

  measure: average_lifetime_order_amount {
    type: average
    sql: ${lifetime_order_amount_dim};;
    value_format: "0.00"
  }

  measure: user_count {
    hidden: yes
    drill_fields: [detail*]
    type: count_distinct
    sql:  ${TABLE}.id ;;
  }

# ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      users.id,
      users.email,
      users.first_name,
      users.last_name,
      users.phone_number,
      contacts.address1,
      contacts.address2,
      contacts.city,
      contacts.state,
      contacts.zipcode,
      contacts.country,
      pdt_user_fact.lifetime_order_amount_dim,
      pdt_user_fact.lifetime_order_count_dim,
      pdt_user_fact.average_order_amount

    ]
  }
}
