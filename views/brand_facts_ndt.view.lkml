view: brand_facts_ndt {
  derived_table: {
    explore_source: order_items {
      column: brand { field: products.brand }
      column: total_revenue {}
      derived_column: brand_rank {
        sql: rank() over(order by total_revenue desc) ;;
      }
      # filters: {
      #   field: order_items.created_date
      #   value: "365 days"
      # }
      # bind_filters: {
      #   from_field: order_items.created_date
      #   to_field: order_items.created_date
      # }
      bind_all_filters: yes
    }
  }
  dimension: brand {
    label: "ブランド"
  }
  dimension: total_revenue {
    label: "ブランドごとの合計金額"
    type: number
  }

  dimension: brand_rank {
    type: number
  }
  dimension: brand_rank_top_5 {
    type: number
    sql: CASE WHEN ${brand_rank} <= 5 THEN ${brand_rank} ELSE 6 END;;
  }
  dimension: brand_top_5 {
    type: string
    sql:  CASE WHEN ${brand_rank} <= 5 THEN ${brand} ELSE 'Other' END;;
  }
}
