import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_gangneung/controller/restaurant_detail_controller.dart';
import 'package:go_gangneung/model/restaurant.dart';
import 'package:go_gangneung/widgets/Map.dart';
import 'package:go_gangneung/widgets/header_image_card.dart';

import 'detail_description.dart';

class Body extends StatefulWidget {
  final Restaurant restaurant;

  const Body({Key key, @required this.restaurant}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final RestaurantDetailController controller = Get.put(RestaurantDetailController());
  double mapX;
  double mapY;

  void _changeStringToDouble(){
    if(widget.restaurant.mapX is String){
      mapX = double.parse(widget.restaurant.mapX);
    } else{
      mapX = widget.restaurant.mapX;
    }
    if(widget.restaurant.mapY is String){
      mapY = double.parse(widget.restaurant.mapY);
    } else{
      mapY = widget.restaurant.mapY;
    }
  }

  @override
  void initState() {
    controller.fetchData(widget.restaurant.contentId.toString());
    _changeStringToDouble();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.restaurantDetail.value.firstMenu == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  HeaderImageCard(item: widget.restaurant),
                  DetailDescription(
                    restaurant: widget.restaurant,
                    restaurantDetail: controller.restaurantDetail.value,
                    overView: controller.overview.value,
                  ),
                  Map(mapX: mapX ?? 0.1, mapY: mapY ?? 0.1, title: widget.restaurant.title)
                ],
              ),
            ),
    );
  }
}
