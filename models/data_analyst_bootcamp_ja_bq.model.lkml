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

datagroup: order_items {
  sql_trigger: SELECT MAX(created_at) FROM order_items ;;
  max_cache_age: "4 hours"
}

# This explore contains multiple views
explore: order_items {
  persist_with: order_items
  conditionally_filter: {
    filters: [order_items.created_date: "last 2 years"]
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
}


# explore: products {}

datagroup: daily_etl {
  max_cache_age: "24 hours"
  sql_trigger: SELECT current_time ;;
}

access_grant: is_pii_viewer {
  user_attribute: is_pii_viewer
  allowed_values: ["Yes"]
}

explore: users {
  # always_filter: {
  #   filters: [order_items.created_date: "before 1 day ago"]
  # }
  persist_with: daily_etl
  access_filter: {
   field: state
   user_attribute: state
  }
  join: order_items {
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
