import 'package:flutter/material.dart';
import 'package:go_gangneung/model/attraction.dart';

import 'components/body.dart';

class AttractionDetailScreen extends StatelessWidget {
  final Attraction attraction;

  const AttractionDetailScreen({
    Key key,
    @required this.attraction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Body(attraction: attraction),
    );
  }
}
