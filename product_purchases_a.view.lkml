
view: product_purchases_a {
    derived_table: {
      distribution_style: even
      sortkeys: ["id"]
      sql_trigger_value: SELECT COUNT(*) FROM ${shop_orders.SQL_TABLE_NAME};;
      sql:SELECT users.id as user_id, COUNT(product.id) as product_count
          FROM users
          LEFT JOIN shop_orders
           ON shop_orders.user_id = users.id
          LEFT JOIN shop_order_items
           ON shop_order_items.order_id = orders.id
          LEFT JOIN product
           ON product.id = shop_order_items.product_id
          WHERE {% condition select_product %}product.name{% endcondition %}
          GROUP BY 1;;
  }
  dimension: user_id {
    hidden: yes
    type:  number
    sql: ${TABLE}.user_id ;;
  }
  dimension: purchase_count {
    sql: COALESCE(${TABLE}.product_count,0) ;;
    type:  number
  }
  filter: select_product {
    suggest_explore: product
    suggest_dimension: product.name
  }
}
