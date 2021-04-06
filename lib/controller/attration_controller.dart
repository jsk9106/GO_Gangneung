import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_gangneung/contstants.dart';
import 'package:go_gangneung/model/attraction.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AttractionController extends GetxController {
  final ScrollController scrollController = ScrollController();
  RxList attractions = [].obs;
  int page = 1;
  int numOfRows = 10;
  int totalCount = 30;

  @override
  void onInit() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        page++;
        fetchData();
      }
    });
    super.onInit();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Future fetchData() async {
    if (totalCount <= attractions.length)
      return Get.snackbar(
        '알림',
        '마지막 목록입니다.',
        backgroundColor: kPrimaryColor.withOpacity(0.5),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );

    Map<String, String> queryPram = {
      'ServiceKey':
          'DVubPbaRkkxO0SIo3YdB8gSPBWhtJ30SJT7ht3DiZB1uJ6QcoIE8TCB6PIKUvQeXI5kNR7FI7ZgLjQPj8ZP+Jg==',
      'areaCode': '32', // 강원
      'sigunguCode': '1', // 강릉시
      'contentTypeId': '12', // 관광지
      // 'contentTypeId': '39', // 음식점
      'arrange': 'B', // 조회순
      'pageNo': page.toString(), // 페이지
      'numOfRows': numOfRows.toString(), // 페이지당 출력 갯수
      'MobileOS': 'AND', // 안드로이드
      'MobileApp': 'GoGangenung', // 고강릉
      '_type': 'json' // 타입
    };
    var uri = Uri.http('api.visitkorea.or.kr',
        '/openapi/service/rest/KorService/areaBasedList', queryPram);

    try {
      http.Response response = await http.get(uri);
      var body = jsonDecode(utf8.decode(response.bodyBytes));
      List<dynamic> result = body['response']['body']['items']['item'];
      totalCount = body['response']['body']['totalCount'];

      if (result != null) {
        result.forEach((item) {
          attractions.add(Attraction.fromJson(item));
        });
          print(attractions[0].title);
      } else
        print('result is null');
    } catch (err) {
      print(err);
    }
  }
}
