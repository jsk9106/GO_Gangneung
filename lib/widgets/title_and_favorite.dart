import 'package:flutter/material.dart';
import 'package:go_gangneung/db/favorite_helper.dart';
import 'package:go_gangneung/model/favorite.dart';

class TitleAndFavorite extends StatefulWidget {
  final item;

  const TitleAndFavorite({Key key, @required this.item}) : super(key: key);

  @override
  _TitleAndFavoriteState createState() => _TitleAndFavoriteState();
}

class _TitleAndFavoriteState extends State<TitleAndFavorite> {
  bool isFavorite = false;

  Future<void> _getFavoriteList() async{
    List<Favorite> favoriteList = await DBHelper().getAllFavorites() ?? [];
    for(Favorite f in favoriteList){
      print(f.contentId);
      if(f.contentId == widget.item.contentId){
        setState(() {
          isFavorite = true;
        });
      }
    }
  }

  @override
  void initState() {
    _getFavoriteList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.location_on, color: Colors.grey),
                  SizedBox(width: 5),
                  Text(
                    widget.item.address,
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Text(
                widget.item.title,
                style: TextStyle(fontSize: 33, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () async{
            if(!isFavorite){
              DBHelper().createData(widget.item);
            } else{
              DBHelper().deleteFavorite(widget.item.contentId);
            }
            setState(() {
              isFavorite = !isFavorite;
            });
          },
          child: Container(
            padding: const EdgeInsets.only(bottom: 10),
            alignment: Alignment.bottomCenter,
            width: 45,
            height: 70,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30), color: Colors.grey[200]),
            child: isFavorite ? Icon(Icons.favorite, color: Colors.redAccent) : Icon(Icons.favorite_border),
          ),
        )
      ],
    );
  }
}
