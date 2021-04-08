import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:go_gangneung/model/restaurant.dart';
import 'package:go_gangneung/model/restaurant_detail.dart';

class DetailDescription extends StatelessWidget {
  final Restaurant restaurant;
  final RestaurantDetail restaurantDetail;
  final String overView;

  const DetailDescription({
    Key key,
    @required this.restaurant,
    @required this.restaurantDetail,
    @required this.overView,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titleAndFavorite(),
          SizedBox(height: 30),
          Html(
            data: overView,
            style: {
              "*": Style(color: Colors.black54, margin: const EdgeInsets.all(0), lineHeight: 1.3, fontSize: FontSize.small),
            },
          ),
          SizedBox(height: 20),
          Text(
            'More',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 25),
          moreDescription(),
        ],
      ),
    );
  }

  Widget moreDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text.rich(
          TextSpan(children: [
            TextSpan(
                text: '대표 메뉴: ',
                style: TextStyle(fontWeight: FontWeight.w600)),
            TextSpan(text: restaurantDetail.firstMenu ?? ''),
          ]),
        ),
        SizedBox(height: 10),
        Text.rich(
          TextSpan(children: [
            TextSpan(
                text: '메뉴: ',
                style: TextStyle(fontWeight: FontWeight.w600)),
            TextSpan(text: restaurantDetail.treatMenu ?? ''),
          ]),
        ),
        SizedBox(height: 10),
        Text.rich(
          TextSpan(children: [
            TextSpan(
                text: '문의 및 안내: ',
                style: TextStyle(fontWeight: FontWeight.w600)),
            TextSpan(text: restaurantDetail.infoCenterFood ?? ''),
          ]),
        ),
        SizedBox(height: 10),
        Text.rich(
          TextSpan(children: [
            TextSpan(
                text: '쉬는 날: ', style: TextStyle(fontWeight: FontWeight.w600)),
            TextSpan(text: restaurantDetail.restDateFood ?? ''),
          ]),
        ),
        SizedBox(height: 10),
        Text.rich(
          TextSpan(children: [
            TextSpan(
                text: '주차시설: ', style: TextStyle(fontWeight: FontWeight.w600)),
            TextSpan(text: restaurantDetail.parkingFood ?? ''),
          ]),
        ),
        SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('엽업 시간: ', style: TextStyle(fontWeight: FontWeight.w600)),
            Expanded(
              child: Html(
                data: restaurantDetail.openTimeFood ?? '',
                style: {
                  '*': Style(margin: const EdgeInsets.all(0)),
                },
              ),
            ),
          ],
        )
      ],
    );
  }

  Row titleAndFavorite() {
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
                    restaurant.address,
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
                restaurant.title,
                style: TextStyle(fontSize: 33, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(bottom: 10),
          alignment: Alignment.bottomCenter,
          width: 45,
          height: 70,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30), color: Colors.grey[200]),
          child: Icon(Icons.favorite_border),
        )
      ],
    );
  }
}
