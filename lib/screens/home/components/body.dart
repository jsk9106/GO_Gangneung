import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_gangneung/screens/attraction/attraction_screen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../contstants.dart';
import 'home_header_text.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: Image.asset("assets/images/home_bg.png").image,
                fit: BoxFit.cover),
          ),
        ),
        homeHeaderText(
          '강릉여행\n뽀사버리기',
          '맛집, 카페, 관광지까지 다 있다!!'
        ),
        bottomMenu()
      ],
    );
  }

  Positioned bottomMenu() {
    return Positioned(
        bottom: 0,
        right: 0,
        left: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              menuButton(
                25,
                kYellowColor,
                Icons.card_travel,
                '관광명소',
                () => Get.to(() => AttractionScreen()),
              ),
              menuButton(
                80,
                kRedColor,
                Icons.restaurant,
                '맛집',
                () {},
              ),
              menuButton(
                105,
                kPrimaryColor,
                Icons.local_cafe,
                '카페',
                () {},
              ),
              menuButton(
                80,
                kGreenColor,
                MdiIcons.tag,
                '즐겨찾기',
                () {},
              ),
              menuButton(
                25,
                kPurpleColor,
                Icons.more_horiz,
                '더보기',
                () {},
              ),
            ],
          ),
        ),
      );
  }
}

Widget menuButton(double margin, Color color, IconData iconData, String label,
    Function press) {
  return Container(
    margin: EdgeInsets.only(bottom: margin),
    child: GestureDetector(
      onTap: press,
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            child: Icon(iconData, color: Colors.white),
          ),
          SizedBox(height: 8),
          Text(label, style: TextStyle(color: Colors.white)),
        ],
      ),
    ),
  );
}
