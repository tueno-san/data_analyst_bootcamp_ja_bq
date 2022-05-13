view: user_facts_ndt {
    derived_table: {
      explore_source: order_items {
        column: user_id {field:users.id}
        column: total_revenue {}
        column: order_item_count {}
        derived_column: rank_order {
          sql: row_number() over(order by total_revenue desc) ;;
        }
        # # filters: [created_date: "this month"]
        # bind_filters: {
        #   from_field: order_items.creatd_month
        #   to_field: order_items.creatd_month
        # }
        bind_all_filters: yes
        }
    }
    dimension: user_id {
      primary_key: yes
      label: "オーダー ユーザーID"
      type: number
    }
    dimension: total_revenue {
      label: "オーダー Total Revenue"
      type: number
    }
    dimension: order_item_count {
      label: "オーダー Order Item Count"
      type: number
    }
    dimension: rank_order {
      type: number
    }
  }
