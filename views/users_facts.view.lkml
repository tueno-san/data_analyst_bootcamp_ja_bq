view: user_facts {
  derived_table: {
    sql: SELECT
        order_items.user_id as user_id,
        COUNT(distinct order_items.order_id) as liftime_order_count,
        SUM(order_items.sale_price) as lifetime_revenue
      FROM `looker-private-demo.thelook.order_items` as order_items
      GROUP BY user_id
       ;;
  }

  dimension: user_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension: liftime_order_count {
    type: number
    sql: ${TABLE}.liftime_order_count ;;
  }

  dimension: lifetime_revenue {
    type: number
    sql: ${TABLE}.lifetime_revenue ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  set: detail {
    fields: [user_id, liftime_order_count, lifetime_revenue]
  }
}
