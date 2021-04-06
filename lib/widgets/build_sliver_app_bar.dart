import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_gangneung/screens/home/home_screen.dart';

import '../contstants.dart';

SliverAppBar buildSliverAppBar() {
  return SliverAppBar(
    floating: true,
    snap: true,
    // backgroundColor: kYellowColor,
    leading: IconButton(
      icon: Icon(Icons.arrow_back_ios, color: Colors.white),
      onPressed: () => Get.back(),
    ),
    title: Text('관광지'),
  );
}