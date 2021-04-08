import 'package:flutter/material.dart';
import 'package:go_gangneung/model/restaurant.dart';

import 'components/body.dart';

class RestaurantDetailScreen extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantDetailScreen({Key key, @required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Body(restaurant: restaurant),
    );
  }
}
