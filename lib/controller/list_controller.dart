import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  Future fetchData() async{
    if (items.length < totalCount) { // 리스트의 총 갯수만큼만 호출 되게
      List<dynamic> _items = await repository.getList(page, numOfRows, category);
      totalCount = repository.listTotalCount;
      print(totalCount);
      if(_items != null && _items.length > 0) items.addAll(_items);
      else {
        Get.back();
        _customSnackBar('잠시후 다시 시도해주세요');
      }
    } else {
      return _customSnackBar('마지막 목록입니다.');
    }
  }

  void _customSnackBar(String message){
    Get.snackbar(
      '알림',
      message,
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
