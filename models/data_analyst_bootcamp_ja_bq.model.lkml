connection: "looker-private-demo"
# include all the views
include: "/views/*.view"

label: "ECサイトデータ"

datagroup: data_analyst_bootcamp_ja_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

datagroup: reflesh_cache_1day_datagroup {
  sql_trigger: SELECT cerrent_date ;;
  max_cache_age: "24 hour"
}

datagroup: order_items_datagroup {
  sql_trigger: SELECT MAX(created_time) FROM order_items ;;
  max_cache_age: "4 hour"
}

persist_with: data_analyst_bootcamp_ja_default_datagroup

access_grant: is_pii_viewer {
  user_attribute: is_pii_viewer
  allowed_values: ["Yes"]
}

### Whitespaces ####

explore: inventory_items {
  label: "(2) 在庫アイテム"
}

# This explore contains multiple views
explore: order_items {
  # sql_always_where: ${order_items.returned_date} is not null ;;
  # sql_always_having: ${total_sale_price} > 200  ;;
  # always_filter: {
  #   filters: [order_items.status: "Complete"]
  # }
  persist_with: order_items_datagroup
  conditionally_filter: {
    filters: [order_items.created_year: "2 years"]
    unless: [users.id]
  }
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

  join: users_facts {
    type: left_outer
    sql_on: ${order_items.user_id} = ${users_facts.user_id} ;;
    relationship: many_to_one
  }

  join: brand_facts_ndt {
    type: left_outer
    sql_on: ${products.brand} = ${brand_facts_ndt.brand} ;;
    relationship: many_to_one
  }
}

explore: order_facts {}

# explore: products {}


explore: users {
  group_label: "Lookerブートキャンプ"
  label: "ユーザ一覧"
  description: "ユーザーを起点とした分析"
  view_label: "ユーザー情報"
  always_filter: {
    filters: [order_items.created_date: "before today"]
  }
  persist_with: reflesh_cache_1day_datagroup
  access_filter: {
    field: state
    user_attribute: state
  }
  join: order_items {
    view_label: "オーダー情報"
    type: left_outer
    sql_on: ${users.id} = ${order_items.user_id} ;;
    relationship: one_to_many
  }
}

explore: events {
  join: event_session_funnel {
    type: left_outer
    sql_on: ${events.session_id} = ${event_session_funnel.session_id} ;;
    relationship: many_to_one
  }
  join: users {
    type: left_outer
    sql_on: ${events.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}
