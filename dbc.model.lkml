connection: "redshift"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"


explore: shop_order_items {
  view_label: "Order Items"
  hidden:  yes
  label: "Orders"

  conditionally_filter: {
    filters: {
      field: shop_order_items.created_date
      value: "last 30 days"
    }
    unless: [shop_order_items.created_date]
  }

  join: shop_orders {
    sql_on: ${shop_order_items.order_id} = ${shop_orders.id} ;;
    view_label: "Orders"
    relationship: many_to_one
  }

  join: product {
    sql_on: ${shop_order_items.product_id} = ${product.id} ;;
    view_label: "Products"
    relationship: many_to_one
  }

  join: product_kits {
    sql_on: ${shop_order_items.kit_id} = ${product_kits.id} ;;
    view_label: "Kits"
    relationship: many_to_one
  }

  join: users {
    sql_on: ${shop_orders.user_id} = ${users.id} ;;
    view_label: "Users"
    relationship: many_to_one
  }

  join: product_category {
    sql_on:  ${product.category_id} = ${product_category.id} ;;
    relationship: many_to_one
  }

}
