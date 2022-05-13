view: geography_dimensions {
  extension: required

  dimension: city {
    label: "都市"
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    label: "国"
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
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

  dimension: state {
    label: "州"
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: zip {
    label: "郵便番号"
    type: zipcode
    sql: ${TABLE}.zip ;;
  }
}
