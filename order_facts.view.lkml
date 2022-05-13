view: order_facts {
    derived_table: {
      explore_source: order_items {
        column: order_id {}
        column: order_item_count {}
        column: total_revenue {}
        derived_column: rank_revenue {
          sql: rank() over(order by total_revenue desc) ;;
        }
      }
      datagroup_trigger: order_items
      partition_keys: ["order_id"]
    }
    dimension: order_id {
      label: "オーダー オーダーID"
      type: number
    }
    dimension: order_item_count {
      label: "オーダー Order Item Count"
      type: number
    }
    dimension: total_revenue {
      label: "オーダー Total Revenue"
      type: number
    }
    dimension: rank_revenue {
      type: number
    }
  }
