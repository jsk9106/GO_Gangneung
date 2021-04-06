import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_gangneung/screens/attraction/attraction_screen.dart';

Container homeCardList() {
  return Container(
    height: 300,
    child: ListView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      children: [
        stackCard('assets/images/home_card1.png', () => Get.to(() => AttractionScreen())),
        stackCard('assets/images/home_card2.png', () {}),
        stackCard('assets/images/home_card3.png', () {}),
      ],
    ),
  );
}

Widget stackCard(String imagePath, Function press) {
  return GestureDetector(
    onTap: press,
    child: Container(
      margin: const EdgeInsets.only(right: 15),
      width: Get.size.width * 0.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: Image.asset(imagePath).image,
          fit: BoxFit.cover,
        ),
      ),
    ),
  );
}