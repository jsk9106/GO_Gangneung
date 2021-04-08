import 'package:flutter/material.dart';
import 'package:go_gangneung/model/category.dart';

import 'components/body.dart';

class ListScreen extends StatelessWidget {
  final Categories category;

  const ListScreen({Key key, @required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(category: category),
    );
  }
}
