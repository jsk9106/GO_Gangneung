import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_gangneung/controller/attraction_detail_controller.dart';
import 'package:go_gangneung/model/attraction.dart';
import 'package:go_gangneung/widgets/google_map.dart';

import 'detail_description.dart';
import 'header_image_card.dart';

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
  double mapX;
  double mapY;

  void _changeStringToDouble(){
    if(widget.attraction.mapX is String) {
      mapX = double.parse(widget.attraction.mapX);
    } else{
      mapX = widget.attraction.mapX;
    }
    if(widget.attraction.mapY is String) {
      mapY = double.parse(widget.attraction.mapY);
    } else{
      mapY = widget.attraction.mapY;
    }
  }

  @override
  void initState() {
    controller.fetchData(widget.attraction.contentId.toString());
    _changeStringToDouble();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.attractionDetail.value.infoCenter == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  HeaderImageCard(attraction: widget.attraction),
                  DetailDescription(
                    attraction: widget.attraction,
                    attractionDetail: controller.attractionDetail.value,
                    overView: controller.overView.value,
                  ),
                  MapSample(title: widget.attraction.title, mapX: mapX ?? 0.1, mapY: mapY ?? 0.1),
                ],
              ),
            ),
    );
  }
}
