import 'package:go_gangneung/model/attraction_detail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailRepository{

  Future fetchDetailData(String contentId) async{
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
          // print(result);
          return AttractionDetail.fromJson(result);
      } else
        print('result is null');
    } catch (err) {
      print(err);
    }

  }
}