view: brand_analysis {
  derived_table: {
    explore_source: order_items {
      column: brand { field: products.brand }
      column: total_revenue {}
      derived_column: rank_revenue {
      sql:row_number() over(order by total_revenue desc);;
      }
    }
  }
  dimension: brand {
    label: "プロダクト ブランド"
  }
  dimension: total_revenue {
    label: "オーダー Total Revenue"
    type: number
  }
  dimension: rank_revenue {
    type: number
    sql: ${TABLE}.rank_revenue ;;
  }
  dimension: is_top_5 {
    type: yesno
    sql: ${rank_revenue}<=5 ;;
  }
  dimension: brand_group {
    type: string
    sql: case when ${is_top_5} then cancat(${rank_revenue},') ',${brand})
        else '6) Others' end;;
  }

}
