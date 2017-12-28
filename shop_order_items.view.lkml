view: shop_order_items {
#   sql_table_name: mysql_heroku_app_db.shop_order_items ;;
  derived_table: {
    distribution_style: even
    sortkeys: ["order_id"]
    sql_trigger_value:  SELECT COUNT(*) FROM mysql_heroku_app_db.shop_order_items;;
    sql:
      SELECT
             id
             , order_id
             , TYPE
             , kit_id
             , product_id
             , product_sku
             , is_recurring
             , price
             , quantity
             , created_at
             , updated_at
             , deleted_at
             , _fivetran_deleted
             , _fivetran_synced
      FROM mysql_heroku_app_db.shop_order_items
      UNION ALL
      SELECT
             id
             , order_id
             , TYPE
             , null as kit_id
             , CASE WHEN product_sku = 'DBC-WAX-105' THEN  8
                    WHEN product_sku = 'DBC-VIT-160' THEN  13
                    WHEN product_sku = 'DBC-SS-PIC-FREE' THEN  27
                    WHEN product_sku = 'DBC-SS-PIC' THEN  18
                    WHEN product_sku = 'DBC-SN-OIL-120' THEN  4
                    WHEN product_sku = 'DBC-SN-OIL-105' THEN  3
                    WHEN product_sku = 'DBC-SN-MUS-201-FREE' THEN  26
                    WHEN product_sku = 'DBC-SN-MUS-201' THEN  25
                    WHEN product_sku = 'DBC-SN-BLM-110' THEN  7
                    WHEN product_sku = 'DBC-SMP-260' THEN  11
                    WHEN product_sku = 'DBC-SMP-180' THEN  10
                    WHEN product_sku = 'DBC-SH-101-XL' THEN  21
                    WHEN product_sku = 'DBC-SH-101-M' THEN  19
                    WHEN product_sku = 'DBC-SH-101-L' THEN  20
                    WHEN product_sku = 'DBC-SH-101-2XL' THEN  22
                    WHEN product_sku = 'DBC-OIL-120' THEN  2
                    WHEN product_sku = 'DBC-OIL-105' THEN  1
                    WHEN product_sku = 'DBC-MNY-FREE' THEN  17
                    WHEN product_sku = 'DBC-MNY-201' THEN  16
                    WHEN product_sku = 'DBC-HAT-101' THEN  23
                    WHEN product_sku = 'DBC-GR-SPR-110' THEN  24
                    WHEN product_sku = 'DBC-GR-OIL-110' THEN  12
                    WHEN product_sku = 'DBC-CRM-120' THEN  6
                    WHEN product_sku = 'DBC-CMB-201' THEN  14
                    WHEN product_sku = 'DBC-BRS-201' THEN  15
                    WHEN product_sku = 'DBC-BDY-180' THEN  9
                    WHEN product_sku = 'DBC-BALM-110' THEN  5
                ELSE NULL
                END as product_id
             , product_sku
             , is_recurring
             , price/100.0 as price
             , quantity
             , created_at
             , updated_at
             , null as deleted_at
             , _fivetran_deleted
             , _fivetran_synced
      FROM public.v2_shop_order_items
      ;;
  }

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    hidden: yes
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}.order_id ;;
    hidden: yes
  }

  dimension_group: created {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.created_at ;;
    hidden: yes
  }

  dimension_group: deleted {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.deleted_at ;;
    hidden: yes
  }

  dimension: is_recurring {
    type: yesno
    sql: ${TABLE}.is_recurring ;;
    hidden: yes
  }

  dimension: kit_id {
    type: number
    sql: ${TABLE}.kit_id ;;
    hidden: yes
  }

  dimension: product_id {
    type: number
    sql: ${TABLE}.product_id ;;
    hidden: no
  }

  dimension: product_sku {
    type: string
    sql: ${TABLE}.product_sku ;;
    description: "V3 missing data"
    hidden: yes
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
    hidden: yes
  }

  dimension_group: updated {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.updated_at ;;
  }

  dimension: price_of_sku_when_sold {
    type:  number
    sql: ${TABLE}.price;;
    value_format_name: usd_0
    hidden: yes
  }

################## Measures #######################

  # used to calculate revenue for a given item sold
  dimension: revenue_dim {
    type:  number
    sql: ${TABLE}.price * ${TABLE}.quantity ;;
    hidden: yes
  }

  measure: revenue {
    type: sum
    sql: ${revenue_dim} ;;
    value_format_name: usd_0
    description: "Price times Quantity"
  }

  measure: item_quantity {
    type: sum
    sql: ${TABLE}.quantity ;;
  }

  measure: count_of_orders {
    type: count_distinct
    drill_fields: [detail*]
    sql: ${TABLE}.order_id ;;
    description: "Distinct count of order IDs"
  }

  measure: count_of_items {
    type: count
    description: "Count of items"
  }


  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      order_id
    ]
  }

}
