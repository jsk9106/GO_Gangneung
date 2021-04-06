import 'package:get/get.dart';
import 'package:go_gangneung/model/attraction_detail.dart';
import 'package:go_gangneung/repository/detail_repository.dart';

class AttractionDetailController extends GetxController{
  final DetailRepository detailRepository = DetailRepository();
  Rx<AttractionDetail> attractionDetail = AttractionDetail().obs;

  Future<void> fetchData(String contentId) async{
    AttractionDetail tempAttractionDetail = await detailRepository.fetchDetailData(contentId);
    attractionDetail(tempAttractionDetail);
  }
}