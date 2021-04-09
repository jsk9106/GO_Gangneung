class FestivalDetail {
  FestivalDetail({
    this.ageLimit,
    this.bookingPlace,
    this.contentId,
    this.contentTypeId,
    this.discountInfoFestival,
    this.eventEndDate,
    this.eventPlace,
    this.eventStartDate,
    this.placeInfo,
    this.playTime,
    this.program,
    this.spendTimeFestival,
    this.sponsor1,
    this.sponsor1Tel,
    this.sponsor2,
    this.sponsor2Tel,
    this.subEvent,
    this.useTimeFestival,
  });

  String ageLimit;
  String bookingPlace;
  int contentId;
  int contentTypeId;
  String discountInfoFestival;
  int eventEndDate;
  String eventPlace;
  int eventStartDate;
  String placeInfo;
  String playTime;
  String program;
  String spendTimeFestival;
  String sponsor1;
  String sponsor1Tel;
  String sponsor2;
  String sponsor2Tel;
  String subEvent;
  String useTimeFestival;

  factory FestivalDetail.fromJson(Map<String, dynamic> json) => FestivalDetail(
    ageLimit: json["agelimit"],
    bookingPlace: json["bookingplace"],
    contentId: json["contentid"],
    contentTypeId: json["contenttypeid"],
    discountInfoFestival: json["discountinfofestival"],
    eventEndDate: json["eventenddate"],
    eventPlace: json["eventplace"],
    eventStartDate: json["eventstartdate"],
    placeInfo: json["placeinfo"],
    playTime: json["playtime"],
    program: json["program"],
    spendTimeFestival: json["spendtimefestival"],
    sponsor1: json["sponsor1"],
    sponsor1Tel: json["sponsor1tel"],
    sponsor2: json["sponsor2"],
    sponsor2Tel: json["sponsor2tel"],
    subEvent: json["subevent"],
    useTimeFestival: json["usetimefestival"],
  );

  Map<String, dynamic> toJson() => {
    "agelimit": ageLimit,
    "bookingplace": bookingPlace,
    "contentid": contentId,
    "contenttypeid": contentTypeId,
    "discountinfofestival": discountInfoFestival,
    "eventenddate": eventEndDate,
    "eventplace": eventPlace,
    "eventstartdate": eventStartDate,
    "placeinfo": placeInfo,
    "playtime": playTime,
    "program": program,
    "spendtimefestival": spendTimeFestival,
    "sponsor1": sponsor1,
    "sponsor1tel": sponsor1Tel,
    "sponsor2": sponsor2,
    "sponsor2tel": sponsor2Tel,
    "subevent": subEvent,
    "usetimefestival": useTimeFestival,
  };
}
