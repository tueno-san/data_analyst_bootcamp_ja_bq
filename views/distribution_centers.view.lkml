view: distribution_centers {
  sql_table_name: `looker-private-demo.thelook.distribution_centers` ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: latitude {
    label: "緯度"
    type: number
    sql: ${TABLE}.latitude ;;
  }

  dimension: longitude {
    label: "経度"
    type: number
    sql: ${TABLE}.longitude ;;
  }

  dimension: name {
    label: "名称"
    type: string
    sql: ${TABLE}.name ;;
  }

  measure: count {
    type: count
    drill_fields: [id, name]
  }
}
