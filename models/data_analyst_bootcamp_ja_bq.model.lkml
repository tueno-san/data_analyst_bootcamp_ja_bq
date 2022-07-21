connection: "looker-private-demo"
# include all the views
include: "/views/*.view"

label: "ECサイトデータ"

datagroup: data_analyst_bootcamp_ja_default_datagroup {
  sql_trigger: SELECT current_date;;
  max_cache_age: "24 hours"
}
datagroup: order_items {
  sql_trigger: SELECT max(created_at) from `looker-private-demo.thelook.order_items`;;
  max_cache_age: "4 hours"
}

persist_with: data_analyst_bootcamp_ja_default_datagroup

access_grant: is_pii_viewer {
  user_attribute: is_pii_viewer
  allowed_values: ["Yes"]
}


### Whitespaces ####

explore: inventory_items {
  label: "(2) 在庫アイテム"
  join: products {
    view_label: "プロダクト"
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }
}

# This explore contains multiple views
explore: order_items {
  persist_with: order_items
  # sql_always_where: ${order_items.created_date}>='2012-01-01' ;;
  # always_filter: {
  #   filters: [order_items.status: "Complete"]
  # }
  # conditionally_filter: {
  #   filters: [order_items.status: "Complete"]
  #   unless: [order_items.user_id]
  # }

  group_label: "bootcamp"
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

  join: user_facts {
    type: left_outer
    sql_on: ${order_items.user_id}=${user_facts.user_id} ;;
    relationship: many_to_one
  }

  join: top5_brand_ndt {
    type: left_outer
    sql_on: ${products.brand} = ${top5_brand_ndt.brand} ;;
    relationship: many_to_one
  }

  join: user_facts_ndt {
    type: left_outer
    sql_on: ${order_items.user_id}=${user_facts_ndt.user_id} ;;
    relationship: many_to_one
  }

}

explore: events {
  fields: [ALL_FIELDS*,-users.user_life_time_value]
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

access_grant: sample {
  user_attribute: state
  allowed_values: ["Newyork"]
}

# explore: products {}


 explore: users {
  fields: [ALL_FIELDS*,-users.user_life_time_value]
  # fields: [users_filds*]
  # access_filter: {
  #   field: users.state
  #   user_attribute: state
  # }

 }
# named_value_format: jpy {
#   value_format: "\"¥\"#,##0"
# }
