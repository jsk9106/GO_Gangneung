import 'package:get/get.dart';
import 'package:go_gangneung/model/attraction_detail.dart';
import 'package:go_gangneung/repository/repository.dart';

class AttractionDetailController extends GetxController{
  final Repository _repository = Repository();
  Rx<AttractionDetail> attractionDetail = AttractionDetail().obs;
  RxString overView = ''.obs;

  Future<void> fetchData(String contentId) async{
    AttractionDetail tempAttractionDetail = await _repository.getAttractionDetail(contentId);
    if(tempAttractionDetail != null) attractionDetail(tempAttractionDetail);
    String tempOverView = await _repository.getAttractionDetailCommon(contentId);
    overView(tempOverView);
  }


}