view: order_items {
  sql_table_name: `looker-private-demo.thelook.order_items` ;;

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
    datatype: date
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

  dimension_group: shipped {
    label: "出荷"
    type: time
    datatype: date
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

  dimension_group: shipping {
    type: duration
    #datatype: date
    sql_start: ${shipped_date} ;;
    sql_end: ${delivered_date} ;;
    intervals: [day, week]
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

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: count_order_id {
    type: count_distinct
    sql: ${order_id} ;;
  }

  measure: count_email_users {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [users.is_email: "yes"]
  }

  measure: total_sale_price {
    type: sum
    sql: ${sale_price} ;;
  }

  measure: total_sales_of_email_users {
    type: sum
    sql: ${sale_price} ;;
    filters: [users.is_email: "yes"]
  }

  measure: average_sale_price {
    type: average
    sql: ${sale_price} ;;
  }

  measure: parcentage_sales_of_email_users {
    type: number
    value_format_name: percent_1
    sql: 1.0*${total_sales_of_email_users} / NULLIF(${total_sale_price}, 0) ;;
  }

  measure: total_revenue {
    type: sum
    sql: ${sale_price}  ;;
  }

  measure: order_item_count {
    type: count_distinct
    sql: ${order_item_id} ;;
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

  parameter: select_created_timeframe_scale {
    type: unquoted
    default_value: "created_date"
    allowed_value: {
      label: "Date"
      value: "created_date"
    }
    allowed_value: {
      label: "Week"
      value: "created_week"
    }
    allowed_value: {
      label: "Month"
      value: "created_month"
    }
  }

  dimension: dynamic_scale_created_timeframe {
    type: string
    label_from_parameter: select_created_timeframe_scale
    sql:
      {% if select_created_timeframe_scale._parameter_value == 'created_date' %}
        ${created_date}
      {% elsif select_created_timeframe_scale._parameter_value == 'created_date' %}
        ${created_week}
      {% else %}
        ${created_month}
      {% endif %}
    ;;
  }
}
