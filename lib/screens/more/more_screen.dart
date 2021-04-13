import 'package:flutter/material.dart';

import 'components/body.dart';

class MoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text('더 보기'),
      ),
      body: Body(),
    );
  }
}
