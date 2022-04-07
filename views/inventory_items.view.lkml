view: inventory_items {
sql_table_name: `looker-private-demo.thelook.inventory_items` ;;


  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: cost {
    label: "原価"
    type: number
    sql: ${TABLE}.cost ;;
  }

  dimension_group: created {
    label: "在庫登録"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: product_brand {
    label: "プロダクト・ブランド"
    type: string
    sql: ${TABLE}.product_brand ;;
  }

  dimension: product_category {
    label: "プロダクト・カテゴリ"
    type: string
    sql: ${TABLE}.product_category ;;
  }

  dimension: product_department {
    label: "プロダクト・部門"
    type: string
    sql: ${TABLE}.product_department ;;
  }

  dimension: product_distribution_center_id {
    type: number
    sql: ${TABLE}.product_distribution_center_id ;;
  }

  dimension: product_id {
    type: number
#     hidden: yes
    sql: ${TABLE}.product_id ;;
  }

  dimension: product_name {
    label: "プロダクト名"
    type: string
    sql: ${TABLE}.product_name ;;
  }

  dimension: product_retail_price {
    label: "小売価格"
    type: number
    sql: ${TABLE}.product_retail_price ;;
  }

  dimension: product_sku {
    label: "プロダクトSKU"
    type: string
    sql: ${TABLE}.product_sku ;;
  }

  dimension_group: sold {
    label: "発注"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.sold_at ;;
  }

  measure: count {
    type: count
    drill_fields: [id, product_name, products.id, products.name, order_items.count]
  }
}
