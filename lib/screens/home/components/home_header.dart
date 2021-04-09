import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../contstants.dart';
import 'home_header_text.dart';
import 'home_search_bar.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      overflow: Overflow.visible,
      children: [
        Container(
          height: Get.size.height * 0.3,
          color: kPrimaryColor,
        ),
        homeHeaderText(
          // 헤더 텍스트
          '강릉여행\n뽀사버리기',
          '관광지, 맛집, 축제 정보까지 다 있다!!',
        ),
        HomeSearchBar(), // 검색창
      ],
    );
  }
}