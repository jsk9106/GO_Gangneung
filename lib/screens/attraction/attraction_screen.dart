import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_gangneung/screens/home/home_screen.dart';

import 'components/body.dart';

class AttractionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back_ios),
      //     color: Colors.black,
      //     onPressed: () => Get.offAll(() => HomeScreen()),
      //   ),
      // ),
      body: Body(),
    );
  }
}
