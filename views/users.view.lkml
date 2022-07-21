include: "geography.view"

view: users {
  extends: [geography]
  sql_table_name: `looker-private-demo.thelook.users` ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

set: users_filds {
  fields: [age]
}

  dimension: age {
    label: "年齢"
    type: number
    sql: ${TABLE}.age ;;
  }

  # dimension: city {
  #   group_label: "地理情報"
  #   label: "都市"
  #   description: "市の情報です。"
  #   type: string
  #   sql: ${TABLE}.city ;;
  # }

  # dimension: country {
  #   group_label: "地理情報"

  #   label: "国"
  #   type: string
  #   map_layer_name: countries
  #   sql: ${TABLE}.country ;;
  # }

  # dimension: latitude {
  #   label: "経度"
  #   type: number
  #   sql: ${TABLE}.latitude ;;
  # }

  # dimension: longitude {
  #   label: "緯度"
  #   type: number
  #   sql: ${TABLE}.longitude ;;
  # }

  # dimension: state {
  #   # required_access_grants: [sample]
  #   label: "州"
  #   type: string
  #   sql: ${TABLE}.state ;;
  # }
  # dimension: zip {
  #   label: "郵便番号"
  #   type: zipcode
  #   sql: ${TABLE}.zip ;;
  # }


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
    # required_access_grants: [is_pii_viewer]
    link: {
      label: "Category Detail Dashboard"
      url: "/dashboards/1813?Email={{value}}"
    }

  }

  dimension: first_name {
    label: "名"
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: gender {
    view_label: "オーダー"
    label: "性別"
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }


  # dimension: sate2 {
  #   type: string
  #   sql: ${state} ;;
  # }

  dimension: traffic_source {
    label: "トラフィック・ソース"
    type: string
    sql: ${TABLE}.traffic_source ;;
  }


  filter: incoming_traffic_source {
    type: string
    suggest_dimension: users.traffic_source
    suggest_explore: user
  }

  dimension: hidden_traffic_source_filter {
    type: yesno
    hidden: yes
    sql: {%condition incoming_traffic_source%}${traffic_source}{%endcondition%};;
  }

  measure: changeable_count_measure {
    type: count_distinct
    sql: ${id} ;;
    filters: [hidden_traffic_source_filter: "yes"]
  }

  measure: user_life_time_value {
    type: number
    sql: ${user_facts.lifetime_revenue}/${order_items.total_revenue} ;;
  }

  measure: count {
    type: count
    drill_fields: [id, first_name, last_name, events.count, order_items.count]
  }
}
