import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_gangneung/contstants.dart';
import 'package:go_gangneung/screens/home/home_screen.dart';

import 'components/body.dart';

class AttractionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: kYellowColor,
      //   elevation: 0,
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back_ios),
      //     color: Colors.white,
      //     onPressed: () => Get.offAll(HomeScreen()),
      //   ),
      // ),
      body: Body(),
    );
  }
}
