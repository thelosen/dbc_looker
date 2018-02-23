  view: shipping_address {
    derived_table: {
      distribution_style: even
      sortkeys: ["shipping_address_id"]
      sql_trigger_value: SELECT COUNT(*) FROM ${shop_orders.SQL_TABLE_NAME};;
      sql: select
              shop_orders.shipping_address_id
              , contact_addresses.country_iso
              , contact_addresses.state_iso
              , contact_addresses.zip
              FROM ${shop_orders.SQL_TABLE_NAME} as shop_orders
                LEFT JOIN mysql_heroku_app_db.contact_addresses ON shop_orders.shipping_address_id = contact_addresses.id;;
    }

    ##### Dimensions ###############

    dimension: shipping_address_id {
      type: number
      sql: ${TABLE}.shipping_address_id ;;
      hidden: yes
      primary_key: yes
    }

    dimension: ship_to_state {
      type: string
      sql: ${TABLE}.state_iso ;;
    }

    dimension: ship_to_country {
      type: string
      sql: ${TABLE}.country_iso ;;
    }

    dimension: ship_to_zip {
      type: zipcode
      sql: ${TABLE}.zip;;
    }
  }
