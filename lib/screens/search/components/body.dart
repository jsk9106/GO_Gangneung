import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_gangneung/controller/search_controller.dart';
import 'package:go_gangneung/model/category.dart';
import 'package:go_gangneung/model/search.dart';
import 'package:go_gangneung/screens/detail/detail_screen.dart';

import '../../../contstants.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final SearchController controller = Get.put(SearchController());
  final FocusNode focusNode = FocusNode();
  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    focusNode.unfocus();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildSearchBar(),
        buildListView(),
      ],
    );
  }

  Widget buildListView() {
    return Expanded(
      child: Obx(() {
        if (controller.loading.value) {
          // 로딩 처리
          return Center(child: CircularProgressIndicator());
        } else if (controller.items.length == 0) {
          // 검색 결과 없을 때
          return Center(child: Text('검색 결과가 없습니다.'));
        }
        return Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            controller: controller.scrollController,
            itemCount: controller.items.length + 1,
            itemBuilder: (context, index) {
              if (index == controller.items.length) {
                if(index == controller.totalCount) return Container();
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              return _buildListItem(controller.items[index]);
            },
          ),
        );
      }),
    );
  }

  Widget _buildListItem(Search item) {
    Categories category;
    if (item.contentTypeId == 12)
      category = Categories.attraction;
    else if (item.contentTypeId == 39)
      category = Categories.restaurant;
    else if (item.contentTypeId == 15) category = Categories.festival;

    return GestureDetector(
      onTap: () => Get.to(() => DetailScreen(item: item, category: category)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        margin: const EdgeInsets.only(bottom: 10),
        width: double.infinity,
        height: 140,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [kDefaultBoxShadow],
        ),
        child: Row(
          children: [
            Container(
              width: 130,
              height: 130,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: item.firstImage == null
                    ? Image.asset('assets/images/not_image.png',
                        fit: BoxFit.cover)
                    : CachedNetworkImage(
                        placeholder: (context, url) =>
                            Container(color: Colors.grey[200]),
                        imageUrl: item.firstImage,
                        errorWidget: (context, url, error) =>
                            Center(child: Icon(Icons.error)),
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Text(item.title, style: TextStyle(fontSize: 18)),
                  SizedBox(height: 15),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.location_on, color: Colors.grey),
                        SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            item.address,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Container buildSearchBar() {
    return Container(
      width: double.infinity,
      height: 60,
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: TextField(
              controller: textEditingController,
              focusNode: focusNode,
              textAlignVertical: TextAlignVertical.center,
              autofocus: true,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '강릉 여행지 검색!!',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  suffixIcon: IconButton(
                      icon: Icon(
                        Icons.cancel,
                        size: 20,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        textEditingController.clear();
                      })),
            ),
          ),
          FlatButton(
            padding: const EdgeInsets.all(0),
            onPressed: () {
              focusNode.unfocus();
              controller.page = 1;
              controller.keyword = textEditingController.text;
              controller.getSearchKeyword();
            },
            child: Text('검색'),
          )
        ],
      ),
    );
  }
}
