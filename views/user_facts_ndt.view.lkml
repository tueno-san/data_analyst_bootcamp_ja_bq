# If necessary, uncomment the line below to include explore_source.
# include: "data_analyst_bootcamp_ja_bq.model.lkml"

view: user_facts_ndt {
  derived_table: {
    explore_source: order_items {
      column: id { field: users.id }
      column: sale_price {}
      column: count {}
      filters: {
        field: order_items.created_date
        value: "2 years"
      }
    }
  }
  dimension: id {
    type: number
  }
  dimension: sale_price {
    label: "Order Items 売上"
    type: number
  }
  dimension: count {
    type: number
  }
}
