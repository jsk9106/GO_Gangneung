import 'dart:convert';

RestaurantDetail restaurantDetailFromJson(String str) => RestaurantDetail.fromJson(json.decode(str));

String restaurantDetailToJson(RestaurantDetail data) => json.encode(data.toJson());

class RestaurantDetail {
  RestaurantDetail({
    this.chkcreditcardfood,
    this.contentid,
    this.contenttypeid,
    this.discountinfofood,
    this.firstMenu,
    this.infoCenterFood,
    this.kidsFacility,
    this.lcnsno,
    this.openTimeFood,
    this.parkingFood,
    this.reservationFood,
    this.restDateFood,
    this.smoking,
    this.treatMenu,
  });

  String chkcreditcardfood;
  int contentid;
  int contenttypeid;
  String discountinfofood;
  String firstMenu;
  String infoCenterFood;
  int kidsFacility;
  int lcnsno;
  String openTimeFood;
  String parkingFood;
  String reservationFood;
  String restDateFood;
  String smoking;
  String treatMenu;

  factory RestaurantDetail.fromJson(Map<String, dynamic> json) => RestaurantDetail(
    chkcreditcardfood: json["chkcreditcardfood"],
    contentid: json["contentid"],
    contenttypeid: json["contenttypeid"],
    discountinfofood: json["discountinfofood"],
    firstMenu: json["firstmenu"],
    infoCenterFood: json["infocenterfood"],
    kidsFacility: json["kidsfacility"],
    lcnsno: json["lcnsno"],
    openTimeFood: json["opentimefood"],
    parkingFood: json["parkingfood"],
    reservationFood: json["reservationfood"],
    restDateFood: json["restdatefood"],
    smoking: json["smoking"],
    treatMenu: json["treatmenu"],
  );

  Map<String, dynamic> toJson() => {
    "chkcreditcardfood": chkcreditcardfood,
    "contentid": contentid,
    "contenttypeid": contenttypeid,
    "discountinfofood": discountinfofood,
    "firstmenu": firstMenu,
    "infocenterfood": infoCenterFood,
    "kidsfacility": kidsFacility,
    "lcnsno": lcnsno,
    "opentimefood": openTimeFood,
    "parkingfood": parkingFood,
    "reservationfood": reservationFood,
    "restdatefood": restDateFood,
    "smoking": smoking,
    "treatmenu": treatMenu,
  };
}
