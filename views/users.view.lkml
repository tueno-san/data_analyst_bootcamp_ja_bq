include: "geography.view"

view: users {
  sql_table_name: `looker-private-demo.thelook.users` ;;
  extends: [geography]

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
    link: {
      label: "Category Detail Dashboard"
      url: "/dashboards/1813?Email={{ value }}"
    }
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

  dimension: traffic_source {
    label: "トラフィック・ソース"
    type: string
    sql: ${TABLE}.traffic_source ;;
  }

  # dimension: city_and_state {
  #   type: string
  #   sql:  CONCAT(${city}, ${state}) ;;
  # }

  dimension: age_group_buckets  {
    type: tier
    sql:  ${age} ;;
    tiers:  [18, 25, 35, 45, 55, 65, 75, 90]
    style:  integer
  }

dimension: traffic_source_is_email {
  type: yesno
  sql: ${traffic_source} = "Email" ;;
}

  measure: count {
    type: count
    drill_fields: [id, first_name, last_name, events.count, order_items.count]
  }
}
