class Attraction {
  Attraction({
    this.address,
    this.cat1,
    this.cat2,
    this.cat3,
    this.contentId,
    this.contentTypeId,
    this.createdTime,
    this.firstImage,
    this.firstImage2,
    this.mapX,
    this.mapY,
    this.mLevel,
    this.modifiedTime,
    this.readCount,
    this.title,
    this.zipCode,
  });

  String address;
  String cat1;
  String cat2;
  String cat3;
  int contentId;
  int contentTypeId;
  int createdTime;
  String firstImage;
  String firstImage2;
  var mapX; // String 형도 있고 double 형도 있음
  var mapY; // String 형도 있고 double 형도 있음
  int mLevel;
  int modifiedTime;
  int readCount;
  String title;
  var zipCode; // String 형도 있고 int 형도 있음

  factory Attraction.fromJson(Map<String, dynamic> json) => Attraction(
    address: json["addr1"],
    cat1: json["cat1"],
    cat2: json["cat2"],
    cat3: json["cat3"],
    contentId: json["contentid"],
    contentTypeId: json["contenttypeid"],
    createdTime: json["createdtime"],
    firstImage: json["firstimage"],
    firstImage2: json["firstimage2"],
    mapX: json["mapx"],
    mapY: json["mapy"],
    mLevel: json["mlevel"],
    modifiedTime: json["modifiedtime"],
    readCount: json["readcount"],
    title: json["title"],
    zipCode: json["zipcode"],
  );

  Map<String, dynamic> toJson() => {
    "addr1": address,
    "cat1": cat1,
    "cat2": cat2,
    "cat3": cat3,
    "contentid": contentId,
    "contenttypeid": contentTypeId,
    "createdtime": createdTime,
    "firstimage": firstImage,
    "firstimage2": firstImage2,
    "mapx": mapX,
    "mapy": mapY,
    "mlevel": mLevel,
    "modifiedtime": modifiedTime,
    "readcount": readCount,
    "title": title,
    "zipcode": zipCode,
  };
}