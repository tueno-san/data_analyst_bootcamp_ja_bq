connection: "looker-private-demo"
# include all the views
include: "/views/*.view"

datagroup: data_analyst_bootcamp_ja_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: data_analyst_bootcamp_ja_default_datagroup


### Whitespaces ####

explore: inventory_items {
}

# This explore contains multiple views
explore: order_items {
  sql_always_where: ${order_items.returned_date} is not null ;;
  join: users {
    type: left_outer
    sql_on: ${order_items.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }
}


# explore: products {}


explore: users {
  group_label: "Lookerブートキャンプ"
  label: "ユーザ一覧"
  description: "ユーザーを起点とした分析"
  view_label: "ユーザー情報"
  join: order_items {
    view_label: "オーダー情報"
    type: left_outer
    sql_on: ${users.id} = ${order_items.user_id} ;;
    relationship: one_to_many
  }
}
