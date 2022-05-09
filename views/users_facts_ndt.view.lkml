view: users_facts_ndt {
  derived_table: {
    explore_source: order_items {
      column: user_id {}
      # column: id {field:user.id}
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
      bind_filters: {
        from_field: order_items.created_date
        to_field: order_items.created_date
      }
    }
  }
  dimension: user_id {
    primary_key: yes
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
