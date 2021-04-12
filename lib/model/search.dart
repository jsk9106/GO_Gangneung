class Search {
  Search({
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

  factory Search.fromJson(Map<String, dynamic> json) => Search(
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
