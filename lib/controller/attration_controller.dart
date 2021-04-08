import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_gangneung/model/attraction.dart';
import 'package:go_gangneung/model/restaurant.dart';
import 'package:go_gangneung/model/category.dart';
import 'package:go_gangneung/repository/repository.dart';

import '../contstants.dart';

class AttractionController extends GetxController {
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

  // @override
  // void onReady() {
  //   _attractionLoad();
  //   super.onReady();
  // }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void fetchData() async {
    print(category);
    switch(category){
      case Categories.attraction:
        loadAttractionList();
        break;
      case Categories.restaurant:
        loadRestaurantList();
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

// Future fetchData() async {
//   if (totalCount <= attractions.length)
//     return Get.snackbar(
//       '알림',
//       '마지막 목록입니다.',
//       backgroundColor: kPrimaryColor.withOpacity(0.5),
//       colorText: Colors.white,
//       snackPosition: SnackPosition.BOTTOM,
//     );
//
//   Map<String, String> queryPram = {
//     'ServiceKey':
//         'DVubPbaRkkxO0SIo3YdB8gSPBWhtJ30SJT7ht3DiZB1uJ6QcoIE8TCB6PIKUvQeXI5kNR7FI7ZgLjQPj8ZP+Jg==',
//     'areaCode': '32', // 강원
//     'sigunguCode': '1', // 강릉시
//     'contentTypeId': '12', // 관광지
//     // 'contentTypeId': '39', // 음식점
//     'arrange': 'B', // 조회순
//     'pageNo': page.toString(), // 페이지
//     'numOfRows': numOfRows.toString(), // 페이지당 출력 갯수
//     'MobileOS': 'AND', // 안드로이드
//     'MobileApp': 'GoGangenung', // 고강릉
//     '_type': 'json' // 타입
//   };
//   var uri = Uri.http('api.visitkorea.or.kr',
//       '/openapi/service/rest/KorService/areaBasedList', queryPram);
//
//   try {
//     http.Response response = await http.get(uri);
//     var body = jsonDecode(utf8.decode(response.bodyBytes));
//     List<dynamic> result = body['response']['body']['items']['item'];
//     totalCount = body['response']['body']['totalCount'];
//
//     if (result != null) {
//       result.forEach((item) {
//         attractions.add(Attraction.fromJson(item));
//       });
//         print(attractions[0].title);
//     } else
//       print('result is null');
//   } catch (err) {
//     print(err);
//   }
// }
}
