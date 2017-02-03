connection: "redshift"

label: "Version 3.0"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"


explore: shop_order_items {
  view_label: "Orders"
  label: "Orders"

  conditionally_filter: {
    filters: {
      field: shop_orders.created_date
      value: "last 30 days"
    }
    unless: [shop_order_items.created_date, shop_orders.created_date]
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
    view_label: "Products"
    relationship: many_to_one
  }

#   join: contact_subscriptions {
#     sql_on:  ${shop_orders.subscription_id} = ${contact_subscriptions.subscription_id} AND ${shop_order_items.product_id} = ${contact_subscriptions.product_id};;
#     view_label: "Subscriptions"
#     relationship: many_to_many
#
#   }

}

explore: users {
  view_label: "Users"
  label: "Users"
}

explore: contact_subscriptions {
  label: "Subscriptions"
  view_label: "Subscriptions"

  join: contacts {
    sql_on:  ${contact_subscriptions.contact_id} = ${contacts.id};;
    view_label: "Contacts"
    relationship: many_to_one
  }

  join:  original_order {
    from: shop_orders
    sql_on: ${contact_subscriptions.original_order_id} = ${original_order.id} ;;
    relationship: one_to_one
  }

  join: most_recent_order {
    from: shop_orders
    sql_on: ${contact_subscriptions.recent_order_id} = ${most_recent_order.id} ;;
    relationship: one_to_one
  }

  join: recurly_subscription {
    sql_on: ${contact_subscriptions.subscription_id} = ${recurly_subscription.id} ;;
    relationship: many_to_one
    view_label: "Recurly"
  }
}
