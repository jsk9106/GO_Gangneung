import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_gangneung/contstants.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: -25,
      child: Container(
        alignment: Alignment.center,
        width: Get.size.width * 0.8,
        height: 50,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [kDefaultBoxShadow],
        ),
        child: TextField(
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search),
            hintText: '강릉 여행지 검색!!',
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 13
            )
          ),
          textAlignVertical: TextAlignVertical.center,
        ),
      ),
    );
  }
}