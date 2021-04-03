import 'package:flutter/material.dart';
import 'package:get/get.dart';

Positioned homeHeaderText(String title, String subTitle) {
  return Positioned(
    top: Get.size.height * 0.08,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              height: 1.3,
              color: Colors.white,
              fontSize: 30,
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
    ),
  );
}