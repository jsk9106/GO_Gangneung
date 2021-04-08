import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_gangneung/model/category.dart';

SliverAppBar buildSliverAppBar(Categories category) {
  return SliverAppBar(
    floating: true,
    snap: true,
    // backgroundColor: kYellowColor,
    leading: IconButton(
      icon: Icon(Icons.arrow_back_ios, color: Colors.white),
      onPressed: () => Get.back(),
    ),
    title: category == Categories.attraction ? Text('관광지') : Text('맛집'),
  );
}