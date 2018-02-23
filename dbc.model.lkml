connection: "redshift"

label: "Version 3.0"
persist_for: "30 minutes"
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
#     fields: [-order_total]
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

  join:  pdt_user_fact {
    sql_on:  ${shop_orders.user_id} = ${pdt_user_fact.id} ;;
    view_label: "Users"
    relationship: many_to_one
  }

  join: recurly_subscription {
    view_label:"Recurly Subscription"
    sql_on: ${users.id} = ${recurly_subscription.user_id} ;;
    relationship: one_to_many
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

  join: subscriber_status {
    sql_on: ${users.id} = ${subscriber_status.user_id} ;;
    relationship: one_to_one
  }

  join: recurly_subscription {
    sql_on: ${users.id} = ${recurly_subscription.user_id} ;;
    relationship: one_to_many
  }

  join:  recurly_accounts {
    sql_on:  ${users.id} = ${recurly_accounts.user_id} ;;
    relationship: one_to_many
  }

  join: contact_subscriptions {
    view_label: "Product Subscriptions"
    sql_on: ${recurly_subscription.id} = ${contact_subscriptions.subscription_id} ;;
    relationship: one_to_many
  }

  join:  recurly_accounts_derived {
    sql_on:  ${users.id} = ${recurly_accounts_derived.user_id} ;;
    relationship: one_to_one
  }

  join: first_order {
    sql_on: ${users.id} = ${first_order.user_id} ;;
    view_label: "First Order"
    relationship: one_to_one
  }

  join: shop_orders {
    sql_on: ${users.id} = ${shop_orders.user_id} ;;
    view_label: "Orders"
    relationship: one_to_many
  }

  join: shop_order_items {
    sql_on: ${shop_orders.id} = ${shop_order_items.order_id} ;;
    view_label: "Orders"
    relationship: one_to_many
  }

  join: order_product {
    from: product
    view_label: "Orders"
    sql_on: ${shop_order_items.product_id} = ${order_product.id} ;;
    fields: [sku]
    relationship: many_to_one
  }

  join: shipping_address {
    from: contact_addresses
    sql_on: ${shop_orders.shipping_address_id} = ${shipping_address.id} ;;
    fields: [state_iso, country_iso, zip]
    view_label: "Order Shipping Address"
    relationship: many_to_one
  }

  join: recurly_transactions {
    sql_on: ${recurly_subscription.uuid} = ${recurly_transactions.subscription_id};;
    view_label: "Recurly Transactions"
    relationship: one_to_many
  }

  join: item_count_per_order {
    sql_on: ${item_count_per_order.order_id} = ${shop_orders.id} ;;
    view_label: "Orders"
    relationship: one_to_one
  }

  join: kit_initial_id {
    sql_on: ${users.id}= ${kit_initial_id.user_id} ;;
    view_label: "Users"
    relationship: one_to_one
  }

  join: combination {
    sql_on: ${combination.Order_id} = ${shop_orders.id};;
    view_label: "2-Product Combinations"
    relationship: many_to_one
  }

  join: combination_2 {
    sql_on: ${combination_2.Order_id} = ${shop_orders.id};;
    view_label: "3-Product Combinations"
    relationship: many_to_one
  }

  join: combination_3 {
    sql_on: ${combination_3.Order_id} = ${shop_orders.id};;
    view_label: "4-Product Combinations"
    relationship: many_to_one
  }

  join: combination_4 {
    sql_on: ${combination_4.Order_id} = ${shop_orders.id};;
    view_label: "5-Product Combinations"
    relationship: many_to_one
  }

  join: combination_5 {
    sql_on: ${combination_5.Order_id} = ${shop_orders.id};;
    view_label: "6-Product Combinations"
    relationship: many_to_one
  }

  join: combination_aggregate {
    sql_on: ${combination_aggregate.Order_id} = ${shop_orders.id};;
    view_label: "Order Combinations"
    relationship: many_to_one
  }

  join:  pdt_user_fact {
    sql_on:  ${users.id} = ${pdt_user_fact.id} ;;
    view_label: "Users"
    relationship: one_to_one
  }

  join: contacts {
    sql_on: ${users.id} = ${contacts.user_id} ;;
    view_label: "Contacts"
    relationship: one_to_one
  }

  join: order_sequence {
    sql_on: ${order_sequence.id} = ${shop_orders.id} ;;
    view_label: "Orders"
    relationship: one_to_one
  }

  join: subscription_product {
      from: product
      view_label: "Product Subscriptions"
      sql_on: ${contact_subscriptions.product_id} = ${subscription_product.id} ;;
      relationship: many_to_one
    fields: [sku]
    }

  join:  pdt_user_product_fact {
    sql_on:  ${users.id} = ${pdt_user_product_fact.user_id} ;;
    view_label: "User Product Fact"
    relationship: one_to_many
  }

  join: product_fact_product {
    from: product
    view_label: "User Product Fact"
    sql_on: ${pdt_user_product_fact.product_id} = ${product_fact_product.id} ;;
    fields: [sku]
    relationship: many_to_one
  }

  join: recurly_billing_info {
    sql_on: ${recurly_billing_info.account_code} = ${recurly_accounts.account_code} ;;
    relationship: many_to_one
  }

  join: recurly_invoices {
    sql_on: ${recurly_invoices.account_code} = ${recurly_accounts.account_code} ;;
    relationship: many_to_one
  }

  join: product_purchases_a {
    sql_on: ${product_purchases_a.user_id}=${users.id} ;;
    type: left_outer
    relationship: one_to_one
  }

  join: product_purchases_b {
    sql_on: ${product_purchases_b.user_id}=${users.id} ;;
    type: left_outer
    relationship: one_to_one
  }

  join: reactivations {
    sql_on: ${reactivations.user_id} = ${users.id} ;;
    type: left_outer
    relationship: many_to_one
  }

  join: order_kit_id {
    sql_on: ${order_kit_id.id} = ${shop_orders.id} ;;
    relationship: one_to_one
  }


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

  join: shop_order_items {
    sql_on: ${most_recent_order.id} = ${shop_order_items.order_id} ;;
    relationship: one_to_many
  }

  join: recurly_subscription {
    sql_on: ${contact_subscriptions.subscription_id} = ${recurly_subscription.id} ;;
    relationship: many_to_one
    view_label: "Recurly"
  }

  join:  pdt_user_fact {
    sql_on:  ${contact_subscriptions.user_id} = ${pdt_user_fact.id} ;;
    view_label: "Users"
    relationship: many_to_one
  }
}

explore: recurly_transactions {
  hidden:  yes
  view_label: "Recurly Transactions"
  label: "Recurly Transactions"

  join: shop_orders {
    sql_on: ${shop_orders.id} = ${recurly_transactions.order_id} ;;
    view_label: "Orders"
    relationship: one_to_many
  }

  join: shop_order_items {
    sql_on: ${shop_orders.id} = ${shop_order_items.order_id} ;;
    view_label: "Orders"
    relationship: one_to_many
  }


  join: shipping_address {
    sql_on: ${shop_orders.shipping_address_id} = ${shipping_address.shipping_address_id} ;;
    view_label: "Shipping Address"
    relationship: many_to_one
  }

  join:  pdt_user_fact {
    sql_on:  ${shop_orders.user_id} = ${pdt_user_fact.id} ;;
    view_label: "Users"
    relationship: many_to_one
  }

}

### Cohort Explore
# using shop_orders here. Some orders did not receive line itmes in the historic data
explore: cohort_analysis {
  from:  shop_orders
  hidden: yes
  view_label: "Orders"
  sql_always_where: (case
              when carrier_charge is null and total_price is not null then true
              when carrier_charge <> total_price then true
             else false end) ;;

  join: users {
    sql_on: ${cohort_analysis.user_id} = ${users.id} ;;
    view_label: "Users"
    relationship: many_to_one
  }

  join:  pdt_user_fact {
    sql_on:  ${cohort_analysis.user_id} = ${pdt_user_fact.id} ;;
    view_label: "Users"
    relationship: many_to_one
  }

  join: contacts {
    sql_on: ${cohort_analysis.user_id} = ${contacts.user_id} ;;
    view_label: "Contacts"
    relationship: many_to_one
  }

  join: kit_initial_id {
    sql_on: ${cohort_analysis.user_id}= ${kit_initial_id.user_id} ;;
    view_label: "Users"
    relationship: many_to_one
  }

  join: shop_order_items {
    sql_on: ${shop_order_items.order_id} = ${cohort_analysis.id} ;;
    view_label: "Products"
    relationship: many_to_one
  }

  join: product {
    sql_on: ${shop_order_items.product_id} = ${product.id} ;;
    view_label: "Products"
    relationship: many_to_one
  }

  join: recurly_subscription {
    sql_on: ${users.id} = ${recurly_subscription.user_id} ;;
    relationship: one_to_many
  }

  join:  pdt_user_product_fact {
    sql_on:  ${cohort_analysis.user_id} = ${pdt_user_product_fact.user_id} ;;
    view_label: "User Product Fact"
    relationship: many_to_many
  }

  join: product_fact_product {
    from: product
    view_label: "User Product Fact"
    sql_on: ${pdt_user_product_fact.product_id} = ${product_fact_product.id} ;;
    fields: [sku]
    relationship: many_to_one
  }

  join: order_sequence {
    sql_on: ${order_sequence.id} = ${cohort_analysis.id} ;;
    view_label: "Orders"
    relationship: one_to_one
  }

  join: first_order {
    sql_on: ${users.id} = ${first_order.user_id} ;;
    view_label: "First Order"
    relationship: one_to_one
  }


}


explore:  pdt_user_fact {
  hidden: yes
}

explore: rec_account {
  hidden: no
  view_label: "Recurly Accounts"
  label: "Recurly Accounts"

  join: rec_subscription {
    view_label: "Recurly Account Subscriptions"
    sql_on: ${rec_account.id} = ${rec_subscription.account_id} ;;
    relationship: one_to_many
  }

  join:  rec_transaction {
    view_label: "Recurly Account Transactions"
    sql_on:  ${rec_account.id} = ${rec_transaction.account_id} ;;
    relationship: one_to_many
  }

  join: rec_invoice {
    view_label: "Recurly Account Invoices"
    sql_on: ${rec_account.id} = ${rec_invoice.account_id} ;;
    relationship: one_to_many
  }

  join: rec_adjustment {
    view_label: "Recurly Account Adjustments"
    sql_on: ${rec_account.id} = ${rec_adjustment.account_id} ;;
    relationship: one_to_many
  }

  join: recurly_accounts {
    view_label: "User ID"
    sql_on: ${rec_account.id}=${recurly_accounts.account_code} ;;
    fields: [recurly_accounts.user_id]
    relationship: one_to_one
  }

  join: pdt_user_fact {
    view_label: "User Key Facts"
    sql_on: ${pdt_user_fact.id}=${recurly_accounts.user_id};;
    relationship: one_to_many
  }
  }


  explore:  product {
  }


  explore: product_kit_items{

    join: product_kits {
      sql_on: ${product_kit_items.kit_id} = ${product_kits.id} ;;
      relationship: many_to_one
    }

    join: product {
      sql_on: ${product_kit_items.product_id} = ${product.id} ;;
      relationship: many_to_one
    }


  }
