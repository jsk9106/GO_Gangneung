import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_gangneung/controller/list_controller.dart';
import 'package:get/get.dart';
import 'package:go_gangneung/contstants.dart';
import 'package:go_gangneung/model/category.dart';
import 'package:go_gangneung/screens/detail/detail_screen.dart';
import 'package:go_gangneung/widgets/build_sliver_app_bar.dart';

class Body extends StatefulWidget {
  final Categories category;

  const Body({Key key, @required this.category}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final ListController controller = Get.put(ListController());

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
          if(index % 2 == 0) return buildListItem(controller.items[index], true); // 짝수
          else return buildListItem(controller.items[index], false); // 홀수
        },
        childCount: controller.items.length + 1,
      ),
    );
  }

  Widget buildListItem(item, bool isEven) {
    return GestureDetector(
      onTap: () => Get.to(() => DetailScreen(item: item, category: widget.category)),
      child: Container(
        margin: isEven ? EdgeInsets.fromLTRB(40, 0, 0, 30) : EdgeInsets.fromLTRB(0, 0, 40, 30),
        width: double.infinity,
        height: 300,
        decoration: BoxDecoration(
          boxShadow: [kDefaultBoxShadow],
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: isEven ? BorderRadius.only(topLeft: Radius.circular(15)) : BorderRadius.only(topRight: Radius.circular(15)),
                    image: DecorationImage(
                      image: item.firstImage == null
                          ? Image.asset('assets/images/not_image.png').image
                          : CachedNetworkImageProvider(item.firstImage),
                      // colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.1), BlendMode.saturation),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                      borderRadius: isEven ? BorderRadius.only(topLeft: Radius.circular(15)) : BorderRadius.only(topRight: Radius.circular(15)),
                    color: Colors.black.withOpacity(0.1)
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: isEven ? BorderRadius.only(bottomLeft: Radius.circular(15)) : BorderRadius.only(bottomRight: Radius.circular(15)),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Column(
                  crossAxisAlignment: isEven ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: isEven ? MainAxisAlignment.end : MainAxisAlignment.start,
                      children: [
                        isEven ? Container() : Icon(Icons.location_on, color: Colors.grey),
                        SizedBox(width: isEven ? 0 : 5),
                        Text(
                          item.address,
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 13,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(width: isEven ? 5 : 0),
                        isEven ? Icon(Icons.location_on, color: Colors.grey) : Container(),
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
}
