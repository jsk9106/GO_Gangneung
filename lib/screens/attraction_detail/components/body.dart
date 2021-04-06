import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_gangneung/controller/attraction_detail_controller.dart';
import 'package:go_gangneung/model/attraction.dart';

class Body extends StatefulWidget {
  final Attraction attraction;

  const Body({
    Key key,
    @required this.attraction,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final AttractionDetailController controller = Get.put(AttractionDetailController());

  @override
  void initState() {
    controller.fetchData(widget.attraction.contentId.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Obx(()=>Text(controller.attractionDetail.value.useTime)),
    );
  }
}
