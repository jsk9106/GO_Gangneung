import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_gangneung/model/attraction_detail.dart';
import 'package:go_gangneung/model/category.dart';
import 'package:go_gangneung/model/festival_detail.dart';
import 'package:go_gangneung/model/restaurant_detail.dart';
import 'package:go_gangneung/repository/repository.dart';

import '../contstants.dart';

class DetailController extends GetxController {
  final Repository _repository = Repository();
  Categories category;
  Rx<AttractionDetail> attractionDetail = AttractionDetail().obs;
  Rx<RestaurantDetail> restaurantDetail = RestaurantDetail().obs;
  Rx<FestivalDetail> festivalDetail = FestivalDetail().obs;
  RxString overview = ''.obs;

  Future<void> fetchData(String contentId) async {
    dynamic _detail = await _repository.getDetail(contentId, category);
    if (_detail != null) {
      switch (category) {
        case Categories.attraction:
          attractionDetail(_detail);
          break;
        case Categories.restaurant:
          restaurantDetail(_detail);
          break;
        case Categories.festival:
          festivalDetail(_detail);
          break;
      }
    } else {
      Get.back();
      Get.snackbar(
        '오류',
        '잠시후 다시 시도해주세요',
        backgroundColor: kPrimaryColor.withOpacity(0.5),
        colorText: Colors.white,
      );
    }
    String _overview = await _repository.getOverView(contentId, category);
    if (_overview != null)
      overview(_overview);
    else
      overview('정보 없음');
  }
}
