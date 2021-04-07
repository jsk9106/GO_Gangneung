import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_gangneung/model/attraction.dart';
import 'package:intl/intl.dart';

class HeaderImageCard extends StatelessWidget {
  final Attraction attraction;

  const HeaderImageCard({
    Key key,
    @required this.attraction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _views = NumberFormat.compact().format(attraction.readCount);
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: Get.size.height * 0.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            image: DecorationImage(
              image: attraction.firstImage == null
                  ? Image.asset('assets/images/not_image.png').image
                  : CachedNetworkImageProvider(attraction.firstImage),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
          width: double.infinity,
          height: Get.size.height * 0.5,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.2),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () => Get.back(),
              ),
              Container(
                alignment: Alignment.center,
                width: 60,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  _views,
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
