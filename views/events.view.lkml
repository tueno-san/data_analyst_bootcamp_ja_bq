include: "geography.view"

view: events {
  sql_table_name: `looker-private-demo.thelook.events` ;;
  extends: [geography_dimensions]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: browser {
    label: "ブラウザ"
    type: string
    sql: ${TABLE}.browser ;;
  }

  dimension_group: created {
    label: "イベント"
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

  dimension: event_type {
    label: "イベント・タイプ"
    type: string
    sql: ${TABLE}.event_type ;;
  }

  dimension: ip_address {
    label: "IPアドレス"
    type: string
    sql: ${TABLE}.ip_address ;;
  }

  dimension: os {
    type: string
    sql: ${TABLE}.os ;;
  }

  dimension: sequence_number {
    label: "シーケンスNo"
    type: number
    sql: ${TABLE}.sequence_number ;;
  }

  dimension: session_id {
    label: "セッションID"
    type: string
    sql: ${TABLE}.session_id ;;
  }

  dimension: traffic_source {
    label: "トラフィック・ソース"
    type: string
    sql: ${TABLE}.traffic_source ;;
  }

  dimension: uri {
    type: string
    sql: ${TABLE}.uri ;;
  }

  dimension: user_id {
    label: "ユーザーID"
    type: number
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
  }
}
