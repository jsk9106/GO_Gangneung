import 'package:go_gangneung/model/attraction.dart';
import 'package:go_gangneung/model/attraction_detail.dart';
import 'package:go_gangneung/model/festival.dart';
import 'package:go_gangneung/model/festival_detail.dart';
import 'package:go_gangneung/model/restaurant.dart';
import 'package:go_gangneung/model/restaurant_detail.dart';
import 'package:go_gangneung/model/search.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Repository{
  int attractionTotalCount;
  int restaurantTotalCount;
  int festivalTotalCount;
  int searchTotalCount;

  // Enecoding key
  // DVubPbaRkkxO0SIo3YdB8gSPBWhtJ30SJT7ht3DiZB1uJ6QcoIE8TCB6PIKUvQeXI5kNR7FI7ZgLjQPj8ZP%2BJg%3D%3D

  Future getAttractionList(int page, int numOfRows) async {
    Map<String, String> queryPram = {
      'ServiceKey':
      'DVubPbaRkkxO0SIo3YdB8gSPBWhtJ30SJT7ht3DiZB1uJ6QcoIE8TCB6PIKUvQeXI5kNR7FI7ZgLjQPj8ZP+Jg==',
      'areaCode': '32', // 강원
      'sigunguCode': '1', // 강릉시
      'contentTypeId': '12', // 관광지
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
      attractionTotalCount = body['response']['body']['totalCount'];
      List<dynamic> result = body['response']['body']['items']['item'];

      if (result != null) {
        return result.map((item) => Attraction.fromJson(item)).toList();
      } else
        print('result is null');
    } catch (err) {
      print(err);
    }
  }

  Future getAttractionDetail(String contentId) async{
    Map<String, String> queryPram = {
      'ServiceKey':
      'DVubPbaRkkxO0SIo3YdB8gSPBWhtJ30SJT7ht3DiZB1uJ6QcoIE8TCB6PIKUvQeXI5kNR7FI7ZgLjQPj8ZP+Jg==',
      'contentId': contentId,
      'contentTypeId': '12', // 관광지
      'pageNo': '1', // 페이지
      'numOfRows': '1', // 페이지당 출력 갯수
      'MobileOS': 'AND', // 안드로이드
      'MobileApp': 'GoGangenung', // 고강릉
      '_type': 'json' // 타입
    };
    var uri = Uri.http('api.visitkorea.or.kr',
        '/openapi/service/rest/KorService/detailIntro', queryPram);

    try {
      http.Response response = await http.get(uri);
      var body = jsonDecode(utf8.decode(response.bodyBytes));
      var result = body['response']['body']['items']['item'];

      if (result != null) {
          return AttractionDetail.fromJson(result);
      } else
        print('result is null');
    } catch (err) {
      print(err);
    }
  }

  Future getAttractionOverview(String contentId) async{
    Map<String, String> queryPram = {
      'ServiceKey':
      'DVubPbaRkkxO0SIo3YdB8gSPBWhtJ30SJT7ht3DiZB1uJ6QcoIE8TCB6PIKUvQeXI5kNR7FI7ZgLjQPj8ZP+Jg==',
      'contentId': contentId,
      'contentTypeId': '12', // 관광지
      'pageNo': '1', // 페이지
      'numOfRows': '1', // 페이지당 출력 갯수
      'MobileOS': 'AND', // 안드로이드
      'MobileApp': 'GoGangenung', // 고강릉
      'overviewYN': 'Y',
      '_type': 'json' // 타입
    };
    var uri = Uri.http('api.visitkorea.or.kr',
        '/openapi/service/rest/KorService/detailCommon', queryPram);

    try {
      http.Response response = await http.get(uri);
      var body = jsonDecode(utf8.decode(response.bodyBytes));
      var result = body['response']['body']['items']['item']['overview'];

      if (result != null) {
        return result;
      } else
        print('result is null');
    } catch (err) {
      print(err);
    }
  }

  Future getRestaurantList(int page, int numOfRows) async {
    Map<String, String> queryPram = {
      'ServiceKey':
      'DVubPbaRkkxO0SIo3YdB8gSPBWhtJ30SJT7ht3DiZB1uJ6QcoIE8TCB6PIKUvQeXI5kNR7FI7ZgLjQPj8ZP+Jg==',
      'areaCode': '32', // 강원
      'sigunguCode': '1', // 강릉시
      'contentTypeId': '39', // 음식점
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
      restaurantTotalCount = body['response']['body']['totalCount'];
      List<dynamic> result = body['response']['body']['items']['item'];

      if (result != null) {
        return result.map((item) => Restaurant.fromJson(item)).toList();
      } else
        print('result is null');
    } catch (err) {
      print(err);
    }
  }

  Future getRestaurantDetail(String contentId) async{
    Map<String, String> queryPram = {
      'ServiceKey':
      'DVubPbaRkkxO0SIo3YdB8gSPBWhtJ30SJT7ht3DiZB1uJ6QcoIE8TCB6PIKUvQeXI5kNR7FI7ZgLjQPj8ZP+Jg==',
      'contentId': contentId,
      'contentTypeId': '39', // 음식점
      'pageNo': '1', // 페이지
      'numOfRows': '1', // 페이지당 출력 갯수
      'MobileOS': 'AND', // 안드로이드
      'MobileApp': 'GoGangenung', // 고강릉
      '_type': 'json' // 타입
    };
    var uri = Uri.http('api.visitkorea.or.kr',
        '/openapi/service/rest/KorService/detailIntro', queryPram);

    try{
      http.Response response =  await http.get(uri);
      var body = jsonDecode(utf8.decode(response.bodyBytes));
      Map<String, dynamic> result = body['response']['body']['items']['item'];
      if(result != null){
        return RestaurantDetail.fromJson(result);
      } else{
        print('result is null');
      }
    } catch (err){
      print(err);
    }
  }

  Future getRestaurantOverview(String contentId) async{
    Map<String, String> queryPram = {
      'ServiceKey':
      'DVubPbaRkkxO0SIo3YdB8gSPBWhtJ30SJT7ht3DiZB1uJ6QcoIE8TCB6PIKUvQeXI5kNR7FI7ZgLjQPj8ZP+Jg==',
      'contentId': contentId,
      'contentTypeId': '39', // 음식점
      'pageNo': '1', // 페이지
      'numOfRows': '1', // 페이지당 출력 갯수
      'MobileOS': 'AND', // 안드로이드
      'MobileApp': 'GoGangenung', // 고강릉
      'overviewYN': 'Y',
      '_type': 'json' // 타입
    };
    var uri = Uri.http('api.visitkorea.or.kr',
        '/openapi/service/rest/KorService/detailCommon', queryPram);

    try {
      http.Response response = await http.get(uri);
      var body = jsonDecode(utf8.decode(response.bodyBytes));
      var result = body['response']['body']['items']['item']['overview'];

      if (result != null) {
        return result;
      } else
        print('result is null');
    } catch (err) {
      print(err);
    }
  }

  Future getFestivalList(int page, int numOfRows) async {
    Map<String, String> queryPram = {
      'ServiceKey':
      'DVubPbaRkkxO0SIo3YdB8gSPBWhtJ30SJT7ht3DiZB1uJ6QcoIE8TCB6PIKUvQeXI5kNR7FI7ZgLjQPj8ZP+Jg==',
      'areaCode': '32', // 강원
      'sigunguCode': '1', // 강릉시
      'contentTypeId': '15', // 축제
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
      festivalTotalCount = body['response']['body']['totalCount'];
      List<dynamic> result = body['response']['body']['items']['item'];

      if (result != null) {
        return result.map((item) => Festival.fromJson(item)).toList();
      } else
        print('result is null');
    } catch (err) {
      print(err);
    }
  }

  Future getFestivalDetail(String contentId) async{
    Map<String, String> queryPram = {
      'ServiceKey':
      'DVubPbaRkkxO0SIo3YdB8gSPBWhtJ30SJT7ht3DiZB1uJ6QcoIE8TCB6PIKUvQeXI5kNR7FI7ZgLjQPj8ZP+Jg==',
      'contentId': contentId,
      'contentTypeId': '15', // 축제
      'pageNo': '1', // 페이지
      'numOfRows': '1', // 페이지당 출력 갯수
      'MobileOS': 'AND', // 안드로이드
      'MobileApp': 'GoGangenung', // 고강릉
      '_type': 'json' // 타입
    };
    var uri = Uri.http('api.visitkorea.or.kr',
        '/openapi/service/rest/KorService/detailIntro', queryPram);

    try{
      http.Response response =  await http.get(uri);
      var body = jsonDecode(utf8.decode(response.bodyBytes));
      Map<String, dynamic> result = body['response']['body']['items']['item'];
      if(result != null){
        return FestivalDetail.fromJson(result);
      } else{
        print('result is null');
      }
    } catch (err){
      print(err);
    }
  }

  Future getFestivalOverview(String contentId) async{
    Map<String, String> queryPram = {
      'ServiceKey':
      'DVubPbaRkkxO0SIo3YdB8gSPBWhtJ30SJT7ht3DiZB1uJ6QcoIE8TCB6PIKUvQeXI5kNR7FI7ZgLjQPj8ZP+Jg==',
      'contentId': contentId,
      'contentTypeId': '15', // 축제
      'pageNo': '1', // 페이지
      'numOfRows': '1', // 페이지당 출력 갯수
      'MobileOS': 'AND', // 안드로이드
      'MobileApp': 'GoGangenung', // 고강릉
      'overviewYN': 'Y',
      '_type': 'json' // 타입
    };
    var uri = Uri.http('api.visitkorea.or.kr',
        '/openapi/service/rest/KorService/detailCommon', queryPram);

    try{
      http.Response response = await http.get(uri);
      var body = jsonDecode(utf8.decode(response.bodyBytes));
      String result = body['response']['body']['items']['item']['overview'];
      if(result != null) return result;
       else print('result is null');
    } catch(err){
      print(err);
    }
  }

  Future getSearchKeyword(String keyword, int page, int numOfRows) async{
    Map<String, String> queryPram = {
      'ServiceKey':
      'DVubPbaRkkxO0SIo3YdB8gSPBWhtJ30SJT7ht3DiZB1uJ6QcoIE8TCB6PIKUvQeXI5kNR7FI7ZgLjQPj8ZP+Jg==',
      'keyword': keyword, // 키워드
      'areaCode': '32', // 강원
      'sigunguCode': '1', // 강릉시
      'pageNo': page.toString(), // 페이지
      'numOfRows': numOfRows.toString(), // 페이지당 출력 갯수
      'MobileOS': 'AND', // 안드로이드
      'MobileApp': 'GoGangenung', // 고강릉
      '_type': 'json' // 타입
    };
    var uri = Uri.http('api.visitkorea.or.kr',
        '/openapi/service/rest/KorService/searchKeyword', queryPram);

    try{
      http.Response response = await http.get(uri);
      var body = jsonDecode(utf8.decode(response.bodyBytes));
      searchTotalCount = body['response']['body']['totalCount'];
      var result = body['response']['body']['items']['item'];
      if(result != null){
        if(searchTotalCount == 1) {
          if(result['contenttypeid'] != 25 && result['contenttypeid'] != 32) return Search.fromJson(result); // 검색결과가 하나일 때
        }
        List<Search> searchList = [];
        result.forEach((item){ // contentTypeId 가 여행코스가 아닌 것만 리스트에 담아서 리턴
          if(item['contenttypeid'] != 25 && item['contenttypeid'] != 32){
            searchList.add(Search.fromJson(item));
          } else{
            searchTotalCount--;
          }
        });
        return searchList;
      } else{
        print('result is null');
      }
    }catch(err){
      print(err);
      return null;
    }
  }

}