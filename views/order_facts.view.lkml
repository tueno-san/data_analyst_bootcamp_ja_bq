view: order_facts {
  derived_table: {
    explore_source: order_items {
      column: order_id {}
      column: count {}
      column: total_sale_price {}
      derived_column: rank {
        sql: rank() over(order by total_sale_price desc) ;;
      }
      # filters: {
      #   field: order_items.created_year
      #   value: "2 years"
      # }
    }
  }
  dimension: order_id {
    label: "オーダーID"
    type: number
  }
  dimension: count {
    type: number
  }
  dimension: total_sale_price {
    type: number
  }
}
