import 'package:get/get.dart';
import 'package:go_gangneung/model/attraction.dart';
import 'package:go_gangneung/model/restaurant.dart';
import 'package:go_gangneung/screens/attraction/attraction_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AttractionController extends GetxController{
  RxList attractions = [].obs;

  Future fetchData() async{
    String page = 1.toString();
    String numOfRows = 10.toString();

    Map<String, String> queryPram = {
      'ServiceKey': 'DVubPbaRkkxO0SIo3YdB8gSPBWhtJ30SJT7ht3DiZB1uJ6QcoIE8TCB6PIKUvQeXI5kNR7FI7ZgLjQPj8ZP+Jg==',
      'areaCode': '32', // 강원
      'sigunguCode': '1', // 강릉시
      'contentTypeId': '12', // 관광지
      // 'contentTypeId': '39', // 음식점
      'arrange': 'B', // 조회순
      'pageNo': page, // 페이지
      'numOfRows': numOfRows, // 페이지당 출력 갯수
      'MobileOS': 'AND', // 안드로이드
      'MobileApp': 'GoGangenung', // 고강릉
      '_type': 'json' // 타입
    };
    var uri = Uri.http('api.visitkorea.or.kr', '/openapi/service/rest/KorService/areaBasedList', queryPram);

    try{
      http.Response response = await http.get(uri);
      var body = jsonDecode(utf8.decode(response.bodyBytes));
      List<dynamic> result = body['response']['body']['items']['item'];

      if(result != null){
        result.forEach((item) {
          attractions.add(Attraction.fromJson(item));
        });
        print(attractions[0].title);
      } else print('result is null');

    }catch(err){
      print(err);
    }

  }

}