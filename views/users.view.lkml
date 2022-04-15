view: users {
  sql_table_name: `looker-private-demo.thelook.users` ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: age {
    label: "年齢"
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: age_tier {
    label: "年齢層"
    type: tier
    sql: ${age} ;;
    tiers: [18, 25, 35, 45, 55, 65, 75, 90]
    style: integer
  }

  dimension: city {
    label: "都市"
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    label: "国"
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension_group: created {
    label: "登録"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      day_of_month,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: email {
    label: "Eメール"
    type: string
    sql: ${TABLE}.email ;;
    required_access_grants: [is_pii_viewer]
  }

  dimension: first_name {
    label: "名"
    type: string
    sql: ${TABLE}.first_name ;;
    required_access_grants: [is_pii_viewer]
  }

  dimension: gender {
    label: "性別"
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
    required_access_grants: [is_pii_viewer]
  }

  dimension: latitude {
    label: "姓"
    type: number
    sql: ${TABLE}.latitude ;;
  }

  dimension: longitude {
    label: "緯度"
    type: number
    sql: ${TABLE}.longitude ;;
  }

  dimension: state {
    label: "州"
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: traffic_source {
    label: "トラフィック・ソース"
    type: string
    sql: ${TABLE}.traffic_source ;;
  }

  dimension: is_email {
    type: yesno
    sql:
      CASE ${traffic_source}
      WHEN 'Email'THEN TRUE
      ELSE FALSE
      END
    ;;

  }

  dimension: zip {
    label: "郵便番号"
    type: zipcode
    sql: ${TABLE}.zip ;;
  }

  dimension: city_state {
    type: string
    sql: concat(${city}, '/', ${state});;
  }

  measure: count {
    type: count
    drill_fields: [id, first_name, last_name, events.count, order_items.count]
  }
}
