class Restaurant {
  Restaurant({
    this.address,
    this.contentId,
    this.contentTypeId,
    this.firstImage,
    this.mapX,
    this.mapY,
    this.readCount,
    this.tel,
    this.title,
  });

  String address;
  int contentId;
  int contentTypeId;
  String firstImage;
  var mapX; // String 형도 있고 double 형도 있음
  var mapY; // String 형도 있고 double 형도 있음
  int readCount;
  String tel;
  String title;

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
    address: json["addr1"],
    contentId: json["contentid"],
    contentTypeId: json["contenttypeid"],
    firstImage: json["firstimage"],
    mapX: json["mapx"],
    mapY: json["mapy"],
    readCount: json["readcount"],
    tel: json["tel"],
    title: json["title"],
  );

  // SqlLite 에 들어갈 데이터라서 맘대로 가공함
  Map<String, dynamic> toJson() => {
    "address": address,
    "contentId": contentId,
    "contentTypeId": contentTypeId,
    "firstImage": firstImage,
    "mapX": mapX,
    "mapY": mapY,
    "readCount": readCount,
    "title": title,
  };
}
