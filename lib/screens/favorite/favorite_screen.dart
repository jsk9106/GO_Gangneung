import 'package:flutter/material.dart';

import 'components/body.dart';

class FavoriteScreen extends StatelessWidget {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text('즐겨찾기'),
      ),
      body: Body(scaffoldKey: scaffoldKey),
    );
  }
}
