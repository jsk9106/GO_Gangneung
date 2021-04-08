import 'package:get/get.dart';
import 'package:go_gangneung/model/restaurant.dart';
import 'package:go_gangneung/model/restaurant_detail.dart';
import 'package:go_gangneung/repository/repository.dart';

class RestaurantDetailController extends GetxController{
  final Repository _repository = Repository();
  Rx<RestaurantDetail> restaurantDetail = RestaurantDetail().obs;
  RxString overview = ''.obs;

  Future<void> fetchData(String contentId) async{
    RestaurantDetail tempRestaurantDetail = await _repository.getRestaurantDetail(contentId);
    if(tempRestaurantDetail != null) restaurantDetail(tempRestaurantDetail);
    String tempOverView = await _repository.getRestaurantDetailCommon(contentId);
    if(tempOverView != null) overview(tempOverView);
  }
}