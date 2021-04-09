import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_gangneung/model/category.dart';

import 'components/body.dart';

class DetailScreen extends StatelessWidget {
  final Categories category;
  final item;

  const DetailScreen({Key key, @required this.item, @required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Body(item: item, category: category),
    );
  }
}
