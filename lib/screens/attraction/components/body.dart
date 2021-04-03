import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_gangneung/controller/attration_controller.dart';
import 'package:go_gangneung/contstants.dart';
import 'package:go_gangneung/model/attraction.dart';
import 'package:go_gangneung/screens/home/home_screen.dart';
import 'package:go_gangneung/widgets/header_text.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final AttractionController controller = AttractionController();

  @override
  void initState() {
    super.initState();
    controller.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      // physics: BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          backgroundColor: kYellowColor,
          floating: true,
          snap: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
            onPressed: () => Get.offAll(HomeScreen()),
          ),
        ),
        SliverToBoxAdapter(
          child: header(),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(vertical: 35),
        ),
        Obx(
          () => SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((BuildContext context, index) {
                return buildListItem(controller.attractions[index]);
              }, childCount: controller.attractions.length),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(vertical: 35),
        ),
      ],
    );
  }

  Widget buildListItem(Attraction attraction) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      width: double.infinity,
      height: 130,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [kDefaultBoxShadow],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(attraction.title),
    );
  }

  Stack header() {
    return Stack(
      alignment: Alignment.center,
      overflow: Overflow.visible,
      children: [
        Container(
          height: Get.size.height * 0.23,
          color: kYellowColor,
        ),
        headerText('관광명소', '강릉에 있는 관광지 싹 다 모았다!!'),
        Positioned(
          bottom: -35,
          // right: 0,
          // left: 0,
          child: Container(
            alignment: Alignment.center,
            height: 70,
            width: Get.size.width * 0.8,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [kDefaultBoxShadow],
            ),
            child: TextField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                border: InputBorder.none,
                hintText: '관광지 키워드 검색',
                hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
                prefixIcon: Icon(Icons.search, color: Colors.black),
              ),
              textAlignVertical: TextAlignVertical.center,
            ),
          ),
        )
      ],
    );
  }
}
