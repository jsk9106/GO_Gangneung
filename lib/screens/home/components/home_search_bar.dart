import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_gangneung/contstants.dart';
import 'package:go_gangneung/screens/search/search_screen.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: -25,
      child: InkWell(
        onTap: () {
          print('tab!');
          Get.to(() => SearchScreen());
        },
        child: Container(
          padding: const EdgeInsets.only(left: 10),
          alignment: Alignment.center,
          width: Get.size.width * 0.8,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [kDefaultBoxShadow],
          ),
          child: Row(
            children: [
              Icon(Icons.search, color: Colors.grey),
              SizedBox(width: 5),
              Text(
                '강릉 여행지 검색!!',
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
