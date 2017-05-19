view: contact_addresses {
#   sql_table_name: mysql_heroku_app_db.contact_addresses ;;
  derived_table: {
    distribution_style: even
    sortkeys: ["id"]
    sql_trigger_value:  SELECT COUNT(*) FROM mysql_heroku_app_db.contact_addresses;;
    sql:
      SELECT id,
          _fivetran_deleted,
          _fivetran_synced,
          addressee,
          city,
          contact_id,
          country_iso,
          country_name,
          created_at,
          created_by,
          deleted_at,
          is_billing,
          is_default_billing,
          is_default_shipping,
          is_primary,
          is_shipping,
          latitude,
          longitude,
          name,
          organization,
          phone,
          sibling_id,
          state_iso,
          state_name,
          street,
          street_extra,
          updated_at,
          zip
      FROM mysql_heroku_app_db.contact_addresses
    UNION ALL
      SELECT id,
          _fivetran_deleted,
          _fivetran_synced,
          addressee,
          city,
          contact_id,
          country_iso,
          null as country_name,
          null as created_at,
          created_by,
          null as deleted_at,
          is_billing,
          null as is_default_billing,
          null as is_default_shipping,
          is_primary,
          is_shipping,
          null  as latitude,
          null as longitude,
          null as name,
          null as organization,
          null  as phone,
          null as sibling_id,
          state_iso,
          state_name,
          street,
          street_extra,
          null as updated_at,
          zip
      FROM public.v2_contact_addresses;;
  }

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: _fivetran_deleted {
    type: yesno
    sql: ${TABLE}._fivetran_deleted ;;
  }

  dimension_group: _fivetran_synced {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}._fivetran_synced ;;
  }

  dimension: addressee {
    type: string
    sql: ${TABLE}.addressee ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: contact_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.contact_id ;;
  }

  dimension: country_iso {
    type: string
    sql: ${TABLE}.country_iso ;;
  }

  dimension: country_name {
    type: string
    sql: ${TABLE}.country_name ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: created_by {
    type: number
    sql: ${TABLE}.created_by ;;
  }

  dimension_group: deleted {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.deleted_at ;;
  }

  dimension: is_billing {
    type: yesno
    sql: ${TABLE}.is_billing ;;
  }

  dimension: is_default_billing {
    type: string
    sql: ${TABLE}.is_default_billing ;;
  }

  dimension: is_default_shipping {
    type: string
    sql: ${TABLE}.is_default_shipping ;;
  }

  dimension: is_primary {
    type: yesno
    sql: ${TABLE}.is_primary ;;
  }

  dimension: is_shipping {
    type: yesno
    sql: ${TABLE}.is_shipping ;;
  }

  dimension: latitude {
    type: number
    sql: ${TABLE}.latitude ;;
  }

  dimension: longitude {
    type: number
    sql: ${TABLE}.longitude ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: organization {
    type: string
    sql: ${TABLE}.organization ;;
  }

  dimension: phone {
    type: string
    sql: ${TABLE}.phone ;;
  }

  dimension: sibling_id {
    type: number
    sql: ${TABLE}.sibling_id ;;
  }

  dimension: state_iso {
    type: string
    sql: ${TABLE}.state_iso ;;
  }

  dimension: state_name {
    type: string
    sql: ${TABLE}.state_name ;;
  }

  dimension: street {
    type: string
    sql: ${TABLE}.street ;;
  }

  dimension: street_extra {
    type: string
    sql: ${TABLE}.street_extra ;;
  }

  dimension_group: updated {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.updated_at ;;
  }

  dimension: zip {
    type: string
    sql: ${TABLE}.zip ;;
  }
  }
