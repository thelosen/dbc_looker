view: contacts {
  sql_table_name: mysql_heroku_app_db.contacts ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: contact_address1 {
    type: string
    sql: ${TABLE}.address1 ;;
  }

  dimension: contact_address2 {
    type: string
    sql: ${TABLE}.address2 ;;
  }

  dimension: belong_user_id {
    hidden: yes
    type: number
    sql: ${TABLE}.belong_user_id ;;
  }

  dimension: city {
    hidden: yes
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: contact_city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: company {
    hidden: yes
    type: string
    sql: ${TABLE}.company ;;
  }

  dimension: country {
    hidden: yes
    type: string
    sql: ${TABLE}.country ;;
  }

  dimension: contact_country {
    type: string
    sql: ${TABLE}.country ;;
  }

  dimension_group: contact_created {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.created_at ;;
  }

  dimension: created_by {
    hidden: yes
    type: number
    sql: ${TABLE}.created_by ;;
  }

  dimension_group: date_identified {
    hidden: yes
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.date_identified ;;
  }

  dimension_group: deleted {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.deleted_at ;;
    hidden: yes
  }

  dimension: deleted_by {
    type: number
    sql: ${TABLE}.deleted_by ;;
    hidden: yes
  }

  dimension: contact_email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: facebook {
    type: string
    sql: ${TABLE}.facebook ;;
  }

  dimension: fax {
    type: string
    sql: ${TABLE}.fax ;;
    hidden: yes
  }

  dimension: contact_first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: foursquare {
    type: string
    sql: ${TABLE}.foursquare ;;
    hidden: yes
  }

  dimension: googleplus {
    type: string
    sql: ${TABLE}.googleplus ;;
    hidden: yes
  }

  dimension: instagram {
    type: string
    sql: ${TABLE}.instagram ;;
    hidden: yes
  }

  dimension: internal {
    type: string
    sql: ${TABLE}.internal ;;
    hidden: yes
  }

  dimension: is_published {
    type: yesno
    sql: ${TABLE}.is_published ;;
    hidden: yes
  }

  dimension_group: contact_last_active {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.last_active ;;
  }

  dimension: contact_last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: mobile {
    type: string
    sql: ${TABLE}.mobile ;;
    hidden: yes
  }

  dimension: password {
    type: string
    sql: ${TABLE}.password ;;
    hidden: yes
  }

  dimension: phone {
    type: string
    sql: ${TABLE}.phone ;;
    hidden: yes
  }

  dimension: points {
    type: number
    sql: ${TABLE}.points ;;
    hidden: yes
  }

  dimension: position {
    type: string
    sql: ${TABLE}.position ;;
    hidden: yes
  }

  dimension: preferred_profile_image {
    type: string
    sql: ${TABLE}.preferred_profile_image ;;
    hidden: yes
  }

  dimension: skype {
    type: string
    sql: ${TABLE}.skype ;;
    hidden: yes
  }

  dimension: social_cache {
    type: string
    sql: ${TABLE}.social_cache ;;
    hidden: yes
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
    hidden: yes
  }

  dimension: contact_state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: stripe_id {
    type: string
    sql: ${TABLE}.stripe_id ;;
    hidden: yes
  }

  dimension: testimonial {
    type: string
    sql: ${TABLE}.testimonial ;;
  }

  dimension: title {
    type: string
    sql: ${TABLE}.title ;;
    hidden: yes
  }

  dimension: twitter {
    type: string
    sql: ${TABLE}.twitter ;;
    hidden: yes
  }

  dimension_group: updated {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.updated_at ;;
    hidden: yes
  }

  dimension: updated_by {
    type: number
    sql: ${TABLE}.updated_by ;;
    hidden: yes
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
    hidden: yes
  }

  dimension: website {
    type: string
    sql: ${TABLE}.website ;;
    hidden: yes
  }

  dimension: zipcode {
    type: string
    hidden: yes
    sql: ${TABLE}.zipcode ;;
  }

  dimension: contact_zipcode {
    type: string
    sql: ${TABLE}.zipcode ;;
  }


  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      users.first_name,
      users.last_name,
      users.user_id,
      _accounts_missing.count,
      contact_addresses.count,
      contact_cards.count,
      contact_ips_xref.count,
      contact_notes.count,
      contact_subscriptions.count,
      recurly_accounts.count,
      recurly_subscription.count,
      survey.count,
      users.count,
      v2_contact_addresses.count,
      v2_contact_subscription.count,
      v2_users.count
    ]
  }

}
