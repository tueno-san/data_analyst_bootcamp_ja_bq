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

  dimension: age_range {
    label: "年代"
    type: tier
    tiers: [18, 25, 35, 45, 55, 65]
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
  }

  dimension: first_name {
    label: "名"
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: gender {
    label: "性別"
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
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

  dimension: state_city {
    label: "州と市"
    type:  string
    sql: CONCAT(${state}, ${city}) ;;
  }

  dimension: traffic_source {
    label: "トラフィック・ソース"
    type: string
    sql: ${TABLE}.traffic_source ;;
  }

  dimension: zip {
    label: "郵便番号"
    type: zipcode
    sql: ${TABLE}.zip ;;
  }

  measure: count {
    type: count
    drill_fields: [id, first_name, last_name, events.count, order_items.count]
  }
}
