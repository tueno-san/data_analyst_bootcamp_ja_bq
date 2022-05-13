view: order_items {
  sql_table_name: `looker-private-demo.thelook.order_items` ;;

  parameter: select_timeframe {
    type: unquoted
    default_value: "created_month"
    allowed_value: {
      value: "created_date"
      label: "Date"
    }
    allowed_value: {
      value: "created_week"
      label: "Week"
    }
    allowed_value: {
      value: "created_month"
      label: "Month"
    }
  }

  dimension: dynamic_timeframe {
    label_from_parameter: select_timeframe
    type: string
    sql:
    {% if select_timeframe._parameter_value == 'created_date' %}
    ${created_date}
    {% elsif select_timeframe._parameter_value == 'created_week' %}
    ${created_week}
    {% else %}
    ${created_month}
    {% endif %}
    ;;
  }

  dimension: order_item_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: created {
    label: "受注"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      month_name,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: delivered {
    label: "到着"
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
    sql: ${TABLE}.delivered_at ;;
  }

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    label: "オーダーID"
    type: number
    sql: ${TABLE}.order_id ;;
  }

  measure: order_count {
    label: "注文数"
    type:  count_distinct
    sql: ${order_id} ;;
  }

  dimension_group: returned {
    label: "返品"
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
    sql: ${TABLE}.returned_at ;;
  }

  dimension: sale_price {
    label: "売上"
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  measure: total_revenue {
    label: "合計売上"
    type: sum
    sql: ${sale_price} ;;
  }

  measure: average_sales {
    type: average
    sql:  ${sale_price} ;;
  }

  dimension_group: shipped {
    label: "出荷"
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
    sql: ${TABLE}.shipped_at ;;
  }

  dimension: status {
    label: "ステータス"
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: user_id {
    label: "ユーザーID"
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  dimension_group: difference_ship_date_and_deliver_date {
    label: "出荷と到着日付の差"
    type: duration
    sql_start: ${shipped_date};;
    sql_end:  ${delivered_date} ;;
    intervals: [day]
  }

  measure: traffic_source_is_email_count {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [users.traffic_source_is_email: "Yes"]
  }

  measure: total_sales_email_users {
    type: sum
    sql: ${sale_price} ;;
    filters: [users.traffic_source_is_email: "Yes"]
  }

  measure: traffic_source_is_email_total_sale_price_percentage {
    type:  number
    value_format_name: percent_1
    sql: ${total_sales_email_users} / ${total_revenue}
    ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      order_item_id,
      users.id,
      users.first_name,
      users.last_name,
      inventory_items.id,
      inventory_items.product_name
    ]
  }
}
