import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_gangneung/contstants.dart';
import 'package:go_gangneung/db/favorite_helper.dart';
import 'package:go_gangneung/model/category.dart';
import 'package:go_gangneung/model/favorite.dart';
import 'package:go_gangneung/screens/detail/detail_screen.dart';

class Body extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const Body({Key key, @required this.scaffoldKey}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DBHelper().getAllFavorites(),
      builder: (BuildContext context, AsyncSnapshot<List<Favorite>> snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());
        if (snapshot.data.length == 0)
          return Center(child: Text('저장된 장소가 없습니다'));
        return _buildList(context, snapshot.data);
      },
    );
  }

  Widget _buildList(BuildContext context, List<Favorite> favorites) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          return _buildListItem(context, favorites[index]);
        },
      ),
    );
  }

  Widget _buildListItem(BuildContext context, Favorite favorite) {
    Categories category;
    if(favorite.contentTypeId == 12) category = Categories.attraction;
    else if(favorite.contentTypeId == 39) category = Categories.restaurant;
    else if(favorite.contentTypeId == 15) category = Categories.festival;

    return GestureDetector(
      onTap: () => Get.to(() => DetailScreen(item: favorite, category: category)),
      child: Dismissible(
        key: Key(favorite.contentId.toString()),
        direction: DismissDirection.endToStart,
        confirmDismiss: (DismissDirection direction) async {
          return await showDialog(
            context: context,
            builder: (BuildContext context) {
              return _alertDialog(context, favorite.contentId);
            },
          );
        },
        background: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            color: kDismissColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Spacer(),
              Icon(Icons.delete, color: kPinkColor),
            ],
          ),
        ),
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
                  child: CachedNetworkImage(
                    placeholder: (context, url) =>
                        Container(color: Colors.grey[200]),
                    imageUrl: favorite.firstImage,
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
                    Text(favorite.title, style: TextStyle(fontSize: 18)),
                    SizedBox(height: 15),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.location_on, color: Colors.grey),
                          SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              favorite.address,
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
                    Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        icon: Icon(Icons.favorite, color: Colors.red),
                        onPressed: () async {
                          return await showDialog(
                              context: context,
                              builder: (context) =>
                                  _alertDialog(context, favorite.contentId));
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _alertDialog(BuildContext context, int contentId) {
    return AlertDialog(
      title: const Text('즐겨찾기 삭제'),
      actions: [
        FlatButton(
          onPressed: () {
            DBHelper().deleteFavorite(contentId);
            setState(() {});
            Get.back();
            widget.scaffoldKey.currentState.showSnackBar(
              SnackBar(
                content: Text("즐겨찾기에서 삭제되었습니다."),
                action: SnackBarAction(
                  label: '확인',
                  onPressed: (){},
                ),
              ),
            );
          },
          child: const Text('삭제'),
        ),
        FlatButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('취소'),
        ),
      ],
    );
  }
}
