view: order_facts {
  derived_table: {
    explore_source: order_items {
      column: order_count {}
      column: order_id {}
      column: sale_price {}
      derived_column: rank_revenue {
        sql: rank() over(order by total_revenue desc) ;;
      }
    }
    datagroup_trigger: order_items
    partition_keys: ["order_id"]
  }
  dimension: order_count {
    label: "注文数"
    type: number
  }
  dimension: order_id {
    label: "オーダーID"
    type: number
  }
  dimension: sale_price {
    label: "売上"
    type: number
  }
  dimension: rank_revenue {
    type: number
  }
}
