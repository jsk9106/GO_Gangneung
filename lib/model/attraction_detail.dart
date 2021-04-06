import 'dart:convert';

AttractionDetail attractionDetailFromJson(String str) => AttractionDetail.fromJson(json.decode(str));

String attractionDetailToJson(AttractionDetail data) => json.encode(data.toJson());

class AttractionDetail {
  AttractionDetail({
    this.accomcount,
    this.chkbabycarriage,
    this.chkcreditcard,
    this.chkpet,
    this.contentId,
    this.contentTypeId,
    this.expguide,
    this.heritage1,
    this.heritage2,
    this.heritage3,
    this.infoCenter,
    this.openDate,
    this.parking,
    this.useTime,
  });

  String accomcount;
  String chkbabycarriage;
  String chkcreditcard;
  String chkpet;
  int contentId;
  int contentTypeId;
  String expguide;
  int heritage1;
  int heritage2;
  int heritage3;
  String infoCenter;
  String openDate;
  String parking;
  String useTime;

  factory AttractionDetail.fromJson(Map<String, dynamic> json) => AttractionDetail(
    accomcount: json["accomcount"],
    chkbabycarriage: json["chkbabycarriage"],
    chkcreditcard: json["chkcreditcard"],
    chkpet: json["chkpet"],
    contentId: json["contentid"],
    contentTypeId: json["contenttypeid"],
    expguide: json["expguide"],
    heritage1: json["heritage1"],
    heritage2: json["heritage2"],
    heritage3: json["heritage3"],
    infoCenter: json["infocenter"],
    openDate: json["opendate"],
    parking: json["parking"],
    useTime: json["usetime"],
  );

  Map<String, dynamic> toJson() => {
    "accomcount": accomcount,
    "chkbabycarriage": chkbabycarriage,
    "chkcreditcard": chkcreditcard,
    "chkpet": chkpet,
    "contentid": contentId,
    "contenttypeid": contentTypeId,
    "expguide": expguide,
    "heritage1": heritage1,
    "heritage2": heritage2,
    "heritage3": heritage3,
    "infocenter": infoCenter,
    "opendate": openDate,
    "parking": parking,
    "usetime": useTime,
  };
}
