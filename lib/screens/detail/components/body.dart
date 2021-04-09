import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_gangneung/controller/detail_controller.dart';
import 'package:go_gangneung/model/category.dart';
import 'package:go_gangneung/widgets/Map.dart';
import 'package:go_gangneung/widgets/header_image_card.dart';
import '../../../widgets/detail_description.dart';

class Body extends StatefulWidget {
  final Categories category;
  final item;

  const Body({Key key, @required this.item, @required this.category}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final DetailController controller = Get.put(DetailController());
  double mapX;
  double mapY;

  void _changeStringToDouble(){
    if(widget.item.mapX is String){
      mapX = double.parse(widget.item.mapX);
    } else{
      mapX = widget.item.mapX;
    }
    if(widget.item.mapY is String){
      mapY = double.parse(widget.item.mapY);
    } else{
      mapY = widget.item.mapY;
    }
  }

  dynamic _changeDetail(){
    switch(widget.category){
      case Categories.attraction:
        return controller.attractionDetail.value;
        break;
      case Categories.restaurant:
        return controller.restaurantDetail.value;
        break;
      case Categories.festival:
        return controller.festivalDetail.value;
        break;
    }
  }

  @override
  void initState() {
    controller.category = widget.category;
    controller.fetchData(widget.item.contentId.toString());
    _changeStringToDouble();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _changeDetail == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  HeaderImageCard(item: widget.item),
                  DetailDescription(
                    category: widget.category,
                    item: widget.item,
                    itemDetail: _changeDetail(),
                    overView: controller.overview.value,
                  ),
                  Map(mapX: mapX ?? 0.1, mapY: mapY ?? 0.1, title: widget.item.title)
                ],
              ),
            ),
    );
  }
}
