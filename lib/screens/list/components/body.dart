import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_gangneung/controller/attration_controller.dart';
import 'package:get/get.dart';
import 'package:go_gangneung/contstants.dart';
import 'package:go_gangneung/model/category.dart';
import 'package:go_gangneung/screens/attraction_detail/attraction_detail_screen.dart';
import 'package:go_gangneung/screens/restaurant_detail/restaurant_detail_screen.dart';
import 'package:go_gangneung/widgets/build_sliver_app_bar.dart';

class Body extends StatefulWidget {
  final Categories category;

  const Body({Key key, @required this.category}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final AttractionController controller = Get.put(AttractionController());

  @override
  void initState() {
    controller.category = widget.category;
    controller.fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: controller.scrollController,
      physics: BouncingScrollPhysics(),
      slivers: [
        buildSliverAppBar(widget.category),
        SliverPadding(padding: const EdgeInsets.only(bottom: 20)),
        Obx(
          () => controller.items.length == 0
              ? SliverToBoxAdapter(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : buildSliverList(),
        ),
        SliverPadding(padding: const EdgeInsets.only(bottom: 20)),
      ],
    );
  }

  Widget buildSliverList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          if(index == controller.items.length) {
            if(index >= controller.totalCount) return Container(); // 총 갯수에 다랐을 때는 빈 컨테이너 리턴
            return Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Center(child: CircularProgressIndicator()),
            );
          }
          return buildListItem(controller.items[index]);
        },
        childCount: controller.items.length + 1,
      ),
    );
  }

  Widget buildListItem(item) {
    return GestureDetector(
      onTap: (){
        switch(widget.category){
          case Categories.attraction:
            Get.to(() => AttractionDetailScreen(attraction: item));
            break;
          case Categories.restaurant:
            Get.to(() => RestaurantDetailScreen(restaurant: item));
            break;
        }
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
        width: double.infinity,
        height: 300,
        decoration: BoxDecoration(
          boxShadow: [kDefaultBoxShadow],
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                image: DecorationImage(
                  image: item.firstImage == null
                      ? Image.asset('assets/images/not_image.png').image
                      : CachedNetworkImageProvider(item.firstImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.grey),
                        SizedBox(width: 10),
                        Text(
                          item.address,
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 13,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // SliverGrid buildSliverGrid() {
  //   return SliverGrid(
  //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //       crossAxisCount: 2,
  //       childAspectRatio: 0.8,
  //     ),
  //     delegate: SliverChildBuilderDelegate(
  //       (BuildContext context, int index) {
  //         if (index >= controller.totalCount) {
  //           // 마지막에는 인디케이터 돌지 않게
  //           return Container();
  //         }
  //         if (index == controller.items.length) {
  //           return Center(
  //             child: CircularProgressIndicator(),
  //           );
  //         }
  //         return buildListItem(controller.items[index]);
  //       },
  //       childCount: controller.items.length + 1,
  //     ),
  //   );
  // }
  //
  // Widget buildListItem(item) {
  //   String _views = NumberFormat.compact().format(item.readCount);
  //   return GestureDetector(
  //     onTap: () {
  //       switch (widget.category) {
  //         case Categories.attraction:
  //           Get.to(() => AttractionDetailScreen(attraction: item));
  //           break;
  //         case Categories.restaurant:
  //           Get.to(() => RestaurantDetailScreen(restaurant: item));
  //           break;
  //       }
  //     },
  //     child: Container(
  //       margin: const EdgeInsets.all(10),
  //       child: Stack(
  //         alignment: Alignment.center,
  //         children: [
  //           Container(
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(10),
  //               image: DecorationImage(
  //                 image: item.firstImage == null
  //                     ? Image.asset('assets/images/not_image.png').image
  //                     : CachedNetworkImageProvider(item.firstImage),
  //                 fit: BoxFit.cover,
  //               ),
  //             ),
  //           ),
  //           Container(
  //             width: double.infinity,
  //             padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
  //             decoration: BoxDecoration(
  //               gradient: LinearGradient(
  //                   begin: Alignment.topCenter,
  //                   end: Alignment.bottomCenter,
  //                   colors: [
  //                     Colors.transparent,
  //                     Colors.transparent,
  //                     Colors.transparent,
  //                     Colors.black.withOpacity(0.7),
  //                   ]),
  //               borderRadius: BorderRadius.circular(10),
  //             ),
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.end,
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   item.title,
  //                   style: TextStyle(color: Colors.white, fontSize: 16),
  //                   maxLines: 1,
  //                   overflow: TextOverflow.ellipsis,
  //                 ),
  //                 SizedBox(height: 3),
  //                 Text(
  //                   item.address,
  //                   style: TextStyle(
  //                     color: Colors.white,
  //                     fontSize: 11,
  //                     fontWeight: FontWeight.w200,
  //                   ),
  //                   maxLines: 1,
  //                   overflow: TextOverflow.ellipsis,
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
