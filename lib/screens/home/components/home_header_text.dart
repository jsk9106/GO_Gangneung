import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_gangneung/contstants.dart';

Widget homeHeaderText(String title, String subTitle) {
  return Positioned(
    top: 50,
    left: 30,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            height: 1.3,
            color: Colors.white,
            fontSize: 33,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 15),
        Text(
          subTitle,
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    ),
  );
}