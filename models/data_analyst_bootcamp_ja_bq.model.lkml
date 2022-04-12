connection: "looker-private-demo"
# include all the views
include: "/views/*.view"

label: "ECサイトデータ"

datagroup: data_analyst_bootcamp_ja_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: data_analyst_bootcamp_ja_default_datagroup


### Whitespaces ####

explore: inventory_items {
  label: "(2) 在庫アイテム"
}

# This explore contains multiple views
explore: order_items {
  label: "(1) オーダー、アイテム、ユーザー関連"
  view_label: "オーダー"
  join: users {
    view_label: "ユーザー"
    type: left_outer
    sql_on: ${order_items.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

  join: inventory_items {
    view_label: "在庫アイテム"
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: products {
    view_label: "プロダクト"
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }
}


# explore: products {}


# explore: users {}
