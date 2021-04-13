import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:go_gangneung/repository/repository.dart';
import 'package:flutter/material.dart';

class SearchController extends GetxController{
  final ScrollController scrollController = ScrollController();
  final Repository _repository = Repository();
  RxList items = [].obs;
  RxBool loading = false.obs;
  int page = 1;
  int numOfRows = 10;
  String keyword;
  int totalCount = 1;

  @override
  void onInit() {
    scrollController.addListener(() {
      if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
        page++;
        scrollEvent();
        print('scroll Event!!');
      }
    });
    super.onInit();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  Future getSearchKeyword() async{
    loading(true);
    var _items = await _repository.getSearchKeyword(keyword, page, numOfRows);
    totalCount = _repository.searchTotalCount;
    loading(false);
    if(_items != null) {
      if(_repository.searchTotalCount == 1){
        items.removeRange(0, items.length);
        items.add(_items);
      } else{
        items.removeRange(0, items.length);
        items.addAll(_items);
      }
    } else{
      items.removeRange(0, items.length);
      // Get.snackbar('알림', '검색 결과가 없습니다.');
    }
  }

  Future scrollEvent() async{
    print(totalCount);
    print(items.length);
    if(totalCount <= items.length) return;
    var _items = await _repository.getSearchKeyword(keyword, page, numOfRows);
    totalCount = _repository.searchTotalCount;
    if(_items != null) {
      if(_repository.searchTotalCount == 1){
        items.add(_items);
      } else{
        items.addAll(_items);
      }
    } else{
      return;
    }
  }
}