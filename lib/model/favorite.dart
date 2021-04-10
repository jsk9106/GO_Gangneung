class Favorite {
  Favorite({
    this.address,
    this.contentId,
    this.contentTypeId,
    this.firstImage,
    this.mapX,
    this.mapY,
    this.readCount,
    this.title,
  });

  String address;
  int contentId;
  int contentTypeId;
  String firstImage;
  var mapX; // String 형도 있고 double 형도 있음
  var mapY; // String 형도 있고 double 형도 있음
  int readCount;
  String title;

  factory Favorite.fromJson(Map<String, dynamic> json) => Favorite(
    address: json["address"],
    contentId: json["contentId"],
    contentTypeId: json["contentTypeId"],
    firstImage: json["firstImage"],
    mapX: json["mapX"],
    mapY: json["mapY"],
    readCount: json["readCount"],
    title: json["title"],
  );

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
