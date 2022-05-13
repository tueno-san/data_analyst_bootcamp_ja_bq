view: brand_analysis {
  derived_table: {
    explore_source: order_items {
      column: brand { field: products.brand }
      column: total_revenue {}
      derived_column: brand_rank {
        sql: row_number() over (order by total_revenue desc) ;;
      }
      # filters: [order_items.created_date: "365 days"]
      bind_filters: {
        from_field: order_items.created_date
        to_field:  order_items.created_date
      }
    }
  }
  # dimension: brand_rank_top_5 {
  #   type: yesno
  #   sql: ${brand_rank} <= 5 ;;
  # }
  # dimension: brand_rank_grouped {
  #   type: string
  #   sql: case when ${brand_rank_top_5} then
  #   ${brand_rank} || ') ' || ${brand}
  #   else '6) Other' end;;
  # }
}
