view: contacts {
  sql_table_name: mysql_heroku_app_db.contacts ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    hidden: yes
  }

  dimension: address1 {
    type: string
    sql: ${TABLE}.address1 ;;
  }

  dimension: address2 {
    type: string
    sql: ${TABLE}.address2 ;;
  }

  dimension: belong_user_id {
    type: number
    sql: ${TABLE}.belong_user_id ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: company {
    type: string
    sql: ${TABLE}.company ;;
  }

  dimension: country {
    type: string
    sql: ${TABLE}.country ;;
  }

  dimension_group: created {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.created_at ;;
  }

  dimension: created_by {
    type: number
    sql: ${TABLE}.created_by ;;
  }

  dimension_group: date_identified {
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

  dimension: email {
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
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: foursquare {
    type: string
    sql: ${TABLE}.foursquare ;;
  }

  dimension: googleplus {
    type: string
    sql: ${TABLE}.googleplus ;;
  }

  dimension: instagram {
    type: string
    sql: ${TABLE}.instagram ;;
  }

  dimension: internal {
    type: string
    sql: ${TABLE}.internal ;;
  }

  dimension: is_published {
    type: yesno
    sql: ${TABLE}.is_published ;;
  }

  dimension_group: last_active {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.last_active ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: mobile {
    type: string
    sql: ${TABLE}.mobile ;;
  }

  dimension: password {
    type: string
    sql: ${TABLE}.password ;;
    hidden: yes
  }

  dimension: phone {
    type: string
    sql: ${TABLE}.phone ;;
  }

  dimension: points {
    type: number
    sql: ${TABLE}.points ;;
  }

  dimension: position {
    type: string
    sql: ${TABLE}.position ;;
  }

  dimension: preferred_profile_image {
    type: string
    sql: ${TABLE}.preferred_profile_image ;;
  }

  dimension: skype {
    type: string
    sql: ${TABLE}.skype ;;
  }

  dimension: social_cache {
    type: string
    sql: ${TABLE}.social_cache ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: stripe_id {
    type: string
    sql: ${TABLE}.stripe_id ;;
  }

  dimension: testimonial {
    type: string
    sql: ${TABLE}.testimonial ;;
  }

  dimension: title {
    type: string
    sql: ${TABLE}.title ;;
  }

  dimension: twitter {
    type: string
    sql: ${TABLE}.twitter ;;
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
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  dimension: website {
    type: string
    sql: ${TABLE}.website ;;
  }

  dimension: zipcode {
    type: string
    sql: ${TABLE}.zipcode ;;
  }


  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      first_name,
      last_name,
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
