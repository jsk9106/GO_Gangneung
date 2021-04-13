import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_gangneung/screens/nav/nav_screen.dart';

import 'components/body.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('검색'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Get.offAll(() => NavScreen()),
        ),
      ),
      body: Body(),
    );
  }
}
