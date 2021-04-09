import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_gangneung/model/attraction.dart';
import 'package:go_gangneung/model/festival.dart';
import 'package:go_gangneung/model/restaurant.dart';
import 'package:go_gangneung/model/category.dart';
import 'package:go_gangneung/repository/repository.dart';

import '../contstants.dart';

class ListController extends GetxController {
  final Repository repository = Repository();
  final ScrollController scrollController = ScrollController();
  RxList items = [].obs;
  int page = 1;
  int numOfRows = 10;
  int totalCount = 1;
  Categories category;

  @override
  void onInit() async{
    _scrollEvent();
    super.onInit();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void fetchData() async {
    switch(category){
      case Categories.attraction:
        loadAttractionList();
        break;
      case Categories.restaurant:
        loadRestaurantList();
        break;
      case Categories.festival:
        loadFestivalList();
        break;
    }
  }

  Future loadAttractionList() async{
    if (items.length < totalCount) { // 관광지 숫자보다 더 많이 안불러오게
      List<Attraction> tempAttractions = await repository.getAttractionList(page, numOfRows);
      totalCount = repository.attractionTotalCount;
      print(totalCount);
      if(tempAttractions != null && tempAttractions.length > 0) items.addAll(tempAttractions);
    } else {
      return _customSnackBar();
    }
  }

  Future loadRestaurantList() async{
    if (items.length < totalCount) { // 카페 숫자보다 더 많이 안불러오게
      List<Restaurant> tempRestaurant = await repository.getRestaurantList(page, numOfRows);
      totalCount = repository.restaurantTotalCount;
      print(totalCount);
      if(tempRestaurant != null && tempRestaurant.length > 0) items.addAll(tempRestaurant);
    } else {
      return _customSnackBar();
    }
  }

  Future loadFestivalList() async{
    if (items.length < totalCount) { // 축제 숫자보다 더 많이 안불러오게
      List<Festival> tempFestival = await repository.getFestivalList(page, numOfRows);
      totalCount = repository.festivalTotalCount;
      print(totalCount);
      if(tempFestival != null && tempFestival.length > 0) items.addAll(tempFestival);
    } else {
      return _customSnackBar();
    }
  }

  void _customSnackBar(){
    Get.snackbar(
      '알림',
      '마지막 목록입니다.',
      backgroundColor: kPrimaryColor.withOpacity(0.5),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void _scrollEvent() {
    scrollController.addListener(() {
      if (scrollController.position.pixels == (scrollController.position.maxScrollExtent)) {
        page++;
        fetchData();
      }
    });
  }

}
