view: add_a_unique_name_1649998707 {
  derived_table: {
    explore_source: order_items {
      column: user_id {}
      column: count {}
      column: total_sale_price {}
      derived_column: rank_order {
        sql: rank() over(order by total_sale_price desc) ;;
      }
      # filters: {
      #   field: order_items.created_year
      #   value: "2 years"
      # }
      filters: [created_date: "this month"]
    }
  }
  dimension: user_id {
    label: "Order Items ユーザーID"
    type: number
  }
  dimension: count {
    type: number
  }
  dimension: total_sale_price {
    type: number
  }
}
