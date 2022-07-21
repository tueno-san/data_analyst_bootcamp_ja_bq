view: geography {
  extension: required
  dimension: city {
    group_label: "地理情報"
    label: "都市"
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    group_label: "地理情報"
    label: "国"
    type: string
    sql: ${TABLE}.country ;;
  }

  dimension: state {
    group_label: "地理情報"
    label: "州"
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: zip {
    group_label: "地理情報"
    label: "郵便番号"
    type: zipcode
    sql: ${TABLE}.zip ;;
  }
  dimension: latitude {
    group_label: "地理情報"
    label: "緯度"
    type: number
    sql: ${TABLE}.latitude ;;
  }

  dimension: longitude {
    group_label: "地理情報"
    label: "経度"
    type: number
    sql: ${TABLE}.longitude ;;
  }

}
