import 'package:go_gangneung/model/attraction.dart';
import 'package:go_gangneung/model/attraction_detail.dart';
import 'package:go_gangneung/model/category.dart';
import 'package:go_gangneung/model/festival.dart';
import 'package:go_gangneung/model/festival_detail.dart';
import 'package:go_gangneung/model/restaurant.dart';
import 'package:go_gangneung/model/restaurant_detail.dart';
import 'package:go_gangneung/model/search.dart';
import 'package:go_gangneung/primary.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Repository {
  int searchTotalCount;
  int listTotalCount;

  // category 값에 따라 contentTypeId 바꿔주기
  int createContentTypeId(Categories category){
    int contentTypeId;
    switch(category){
      case Categories.attraction:
        contentTypeId = 12;
        break;
      case Categories.restaurant:
        contentTypeId = 39;
        break;
      case Categories.festival:
        contentTypeId = 15;
        break;
    }
    return contentTypeId;
  }

  // category 값에 따라 리스트 가져오기
  Future getList(int page, int numOfRows, Categories category) async {
    int contentTypeId = createContentTypeId(category);

    Map<String, String> queryPram = {
      'ServiceKey': serviceKey,
      'areaCode': '32', // 강원
      'sigunguCode': '1', // 강릉시
      'contentTypeId': contentTypeId.toString(), // 12: 관광지, 39: 음식점, 15: 축제
      'arrange': 'Q', // 대표이미지가 반드시 있는 수정순
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
      listTotalCount = body['response']['body']['totalCount'];
      List<dynamic> result = body['response']['body']['items']['item'];

      if (result != null) {
        switch(category){
          case Categories.attraction:
            return result.map((item) => Attraction.fromJson(item)).toList();
          case Categories.restaurant:
            return result.map((item) => Restaurant.fromJson(item)).toList();
          case Categories.festival:
            return result.map((item) => Festival.fromJson(item)).toList();
        }
      } else return null;
    } catch (err) {
      print(err);
    }
  }

  // category 값에 따라 디테일 정보 가져오기
  Future getDetail(String contentId, Categories category) async {
    int contentTypeId = createContentTypeId(category);

    Map<String, String> queryPram = {
      'ServiceKey': serviceKey,
      'contentId': contentId,
      'contentTypeId': contentTypeId.toString(),  // 12: 관광지, 39: 음식점, 15: 축제
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
        switch(category){
          case Categories.attraction:
            return AttractionDetail.fromJson(result);
          case Categories.restaurant:
            return RestaurantDetail.fromJson(result);
          case Categories.festival:
            return FestivalDetail.fromJson(result);
        }
      } else return null;
    } catch (err) {
      print(err);
    }
  }

  // overview 가져오기
  Future getOverView(String contentId, Categories category) async {
    int contentTypeId = createContentTypeId(category);

    Map<String, String> queryPram = {
      'ServiceKey': serviceKey,
      'contentId': contentId,
      'contentTypeId': contentTypeId.toString(), // 12: 관광지, 39: 음식점, 15: 축제
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
      String result = body['response']['body']['items']['item']['overview'];

      if (result != null) {
        return result;
      } else return null;
    } catch (err) {
      print(err);
    }
  }

  // 검색 결과 가져오기
  Future getSearchKeyword(String keyword, int page, int numOfRows) async {
    Map<String, String> queryPram = {
      'ServiceKey': serviceKey,
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

    try {
      http.Response response = await http.get(uri);
      var body = jsonDecode(utf8.decode(response.bodyBytes));
      searchTotalCount = body['response']['body']['totalCount'];
      var result = body['response']['body']['items']['item'];
      if (result != null) {
        if (searchTotalCount == 1) { // 검색 결과가 하나 일 때
          // 관광지, 축제, 음식점에 속할 때 Search 에 담아서 리턴
          if (result['contenttypeid'] == 12 ||
              result['contenttypeid'] == 15 ||
              result['contenttypeid'] == 39)
            return Search.fromJson(result);
          else
            searchTotalCount--; // 아니면 총 갯수 마이너스
        }

        // 검색 결과가 하나가 아니라면
        List<Search> searchList = [];
        // 관광지, 축제, 음식점에 속할 때 SearchList 에 담기
        result.forEach((item) {
          if (item['contenttypeid'] == 12 ||
              item['contenttypeid'] == 15 ||
              item['contenttypeid'] == 39) {
            searchList.add(Search.fromJson(item));
          } else {
            searchTotalCount--;
          }
        });
        return searchList;
      } else {
        print('result is null');
      }
    } catch (err) {
      print(err);
      return null;
    }
  }
}
