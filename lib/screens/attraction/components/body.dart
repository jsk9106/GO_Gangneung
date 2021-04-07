import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_gangneung/controller/attration_controller.dart';
import 'package:go_gangneung/model/attraction.dart';
import 'package:get/get.dart';
import 'package:go_gangneung/screens/attraction_detail/attraction_detail_screen.dart';
import 'package:go_gangneung/widgets/build_sliver_app_bar.dart';
import 'package:intl/intl.dart';

class Body extends StatelessWidget {
  final AttractionController controller = Get.put(AttractionController());

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: controller.scrollController,
      slivers: [
        buildSliverAppBar(),
        SliverPadding(padding: const EdgeInsets.only(bottom: 10)),
        Obx(
          () => controller.attractions.length == 0
              ? SliverToBoxAdapter(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : buildSliverGrid(),
        ),
        SliverPadding(padding: const EdgeInsets.only(bottom: 20)),
      ],
    );
  }

  SliverGrid buildSliverGrid() {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          if (controller.attractions.length == 0)
            return Center(child: CircularProgressIndicator());
          if (index >= controller.totalCount) {
            return Container();
          }
          if (index == controller.attractions.length) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return buildListItem(controller.attractions[index]);
        },
        childCount: controller.attractions.length + 1,
      ),
    );
  }

  Widget buildListItem(Attraction attraction) {
    String _views = NumberFormat.compact().format(attraction.readCount);
    return GestureDetector(
      onTap: () => Get.to(() => AttractionDetailScreen(attraction: attraction)),
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: attraction.firstImage == null
                      ? Image.asset('assets/images/not_image.png').image
                      : CachedNetworkImageProvider(attraction.firstImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.transparent,
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ]),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    attraction.title,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 3),
                  Text(
                    _views,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w200,
                    ),
                  ),
                ],
              ),
            ),
            // Positioned(
            //   bottom: 30,
            //   left: 10,
            //   child: Text(
            //     attraction.title,
            //     style: TextStyle(color: Colors.white, fontSize: 16),
            //     textAlign: TextAlign.center,
            //     // maxLines: 1,
            //     // overflow: TextOverflow.ellipsis,
            //   ),
            // ),
            // Positioned(
            //   bottom: 10,
            //   left: 10,
            //   child: Container(
            //     child: Text(
            //       _views.toString(),
            //       style: TextStyle(
            //           color: Colors.white,
            //           fontSize: 12,
            //           fontWeight: FontWeight.w200),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
