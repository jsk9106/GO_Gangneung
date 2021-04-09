import 'package:get/get.dart';
import 'package:go_gangneung/model/attraction_detail.dart';
import 'package:go_gangneung/model/category.dart';
import 'package:go_gangneung/model/festival_detail.dart';
import 'package:go_gangneung/model/restaurant_detail.dart';
import 'package:go_gangneung/repository/repository.dart';

class DetailController extends GetxController{
  final Repository _repository = Repository();
  Categories category;
  Rx<AttractionDetail> attractionDetail = AttractionDetail().obs;
  Rx<RestaurantDetail> restaurantDetail = RestaurantDetail().obs;
  Rx<FestivalDetail> festivalDetail = FestivalDetail().obs;
  RxString overview = ''.obs;

  void fetchData(String contentId) {
    switch(category){
      case Categories.attraction:
        _getAttractionDetail(contentId);
        break;
      case Categories.restaurant:
        _getRestaurantDetail(contentId);
        break;
      case Categories.festival:
        _getFestivalDetail(contentId);
        break;
    }
  }

  Future<void> _getAttractionDetail(String contentId) async{
    AttractionDetail tempAttractionDetail = await _repository.getAttractionDetail(contentId);
    if(tempAttractionDetail != null) attractionDetail(tempAttractionDetail);
    String tempOverview = await _repository.getAttractionOverview(contentId);
    if(tempOverview != null) overview(tempOverview);
  }

  Future<void> _getRestaurantDetail(String contentId) async{
    RestaurantDetail tempRestaurantDetail = await _repository.getRestaurantDetail(contentId);
    if(tempRestaurantDetail != null) restaurantDetail(tempRestaurantDetail);
    String tempOverview = await _repository.getRestaurantOverview(contentId);
    if(tempOverview != null) overview(tempOverview);
  }

  Future<void> _getFestivalDetail(String contentId) async{
    FestivalDetail tempFestivalDetail = await _repository.getFestivalDetail(contentId);
    if(tempFestivalDetail != null) festivalDetail(tempFestivalDetail);
    String tempOverview = await _repository.getFestivalOverview(contentId);
    if(tempOverview != null) overview(tempOverview);
  }


}