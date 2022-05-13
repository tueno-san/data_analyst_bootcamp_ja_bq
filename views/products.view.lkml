view: products {
  sql_table_name: `looker-private-demo.thelook.products` ;;





  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: brand {
    label: "ブランド"
    type: string
    sql: ${TABLE}.brand ;;
    link: {
      label: "Website"
      url: "http://www.google.com/search?q={{ value | encode_uri }}"
      icon_url: "http://www.google.com/s2/favicons?domain=www.{{ value | encode_uri }}.com"
    }
    link: {
      label: "Google"
      url: "http://www.google.com/search?q={{ value | endoce_uri}}"
      icon_url: "http://google.com/favicon.ico"
    }


  }

  dimension: category {
    label: "カテゴリ"
    type: string
    sql: ${TABLE}.category ;;
    link: {
      label: "View Category Detail"
      url: "/explore/data_analyst_bootcamp_ja_bq/inventory_items?fields=inventory_items.product_category,inventory_items.product_name,inventory_items.count&f[products.category]={{value | url_encode }}"
    }

  }

  dimension: cost {
    label: "原価"
    type: number
    sql: ${TABLE}.cost ;;
  }

  dimension: department {
    label: "部門"
    type: string
    sql: ${TABLE}.department ;;
  }

  dimension: distribution_center_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.distribution_center_id ;;
  }

  dimension: name {
    label: "名称"
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: retail_price {
    label: "小売価格"
    type: number
    sql: ${TABLE}.retail_price ;;
  }

  dimension: sku {
    label: "SKU"
    type: string
    sql: ${TABLE}.sku ;;
  }

  parameter: select_product_detail {
    type: string
    default_value: "department"
    allowed_value: {
      value: "department"
      label: "Department"
    }
    allowed_value: {
      value: "category"
      label: "Category"
    }
    allowed_value: {
      value: "brand"
      label: "Brand"
    }
  }

  dimension: product_hierarchy {
    label_from_parameter: select_product_detail
    type: string
    sql: ${TABLE}.{% parameter select_product_detail %}
      ;;
  }

  filter: choose_a_category_to_compare {
    type: string
    suggest_explore: inventory_items
    suggest_dimension: inventory_items.product_category
  }

  dimension: category_comparator {
    type: string
    sql:
      CASE
        WHEN {% condition choose_a_category_to_compare %}
        ${category}
        {% endcondition %}
      THEN ${category}
      ELSE 'All Other Categories'
      END
      ;;
  }





  measure: count {
    type: count
    drill_fields: [id, name, distribution_centers.id, distribution_centers.name, inventory_items.count]
  }
}
