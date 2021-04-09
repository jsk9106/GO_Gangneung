import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_gangneung/model/category.dart';

SliverAppBar buildSliverAppBar(Categories category) {
  String title = '';
  switch(category){
    case Categories.attraction:
      title = '관광지';
      break;
    case Categories.restaurant:
      title = '맛집';
      break;
    case Categories.festival:
      title = '축제';
      break;
  }

  return SliverAppBar(
    floating: true,
    snap: true,
    leading: IconButton(
      icon: Icon(Icons.arrow_back_ios, color: Colors.white),
      onPressed: () => Get.back(),
    ),
    title: Text(title),
  );
}