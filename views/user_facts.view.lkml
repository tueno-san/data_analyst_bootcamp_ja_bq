view: user_facts {
  derived_table: {
    sql: SELECT order_items.user_id AS user_id,
      COUNT(distinct order_items.order_id) AS lifetime_order_count,
      SUM(order_items.sale_price) AS lifetime_revenue,
      MIN(order_items.created_at) AS first_order_date,
      MAX(order_items.created_at) AS latest_order_date
       FROM `looker-private-demo.thelook.order_items` as order_items
       WHERE {% condition date_filter %} order_items.created_at {% endcondition %}
       GROUP BY user_id
       ;;
  }
  filter: date_filter {
    type: date
  }

  filter: incoming_traffic_source {
    type: string
    suggest_explore: users
    suggest_dimension: users.traffic_source
  }

  measure: count {
    type: count
    drill_fields: [detail*]
    hidden: yes
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension: lifetime_order_count {
    type: number
    sql: ${TABLE}.lifetime_order_count ;;
  }

  dimension: lifetime_revenue {
    type: number
    sql: ${TABLE}.lifetime_revenue ;;
  }

  dimension_group: first_order_date {
    type: time
    sql: ${TABLE}.first_order_date ;;
  }

  dimension_group: latest_order_date {
    type: time
    sql: ${TABLE}.latest_order_date ;;
  }

  dimension: hidden_traffic_source_filter {
    hidden: yes
    type: yesno
    sql: {% condition incoming_traffic_source %} traffic_source {%& endcondition %};;
  }

  measure: user_counts_by_traffic_source {
    type: count_distinct
    sql: id ;;
    filters: [hidden_traffic_source_filter: "Yes"]
  }

  set: detail {
    fields: [user_id, lifetime_order_count, lifetime_revenue, first_order_date_time, latest_order_date_time]
  }
}
