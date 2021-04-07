import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:go_gangneung/model/attraction.dart';
import 'package:go_gangneung/model/attraction_detail.dart';

class DetailDescription extends StatelessWidget {
  final Attraction attraction;
  final AttractionDetail attractionDetail;
  final String overView;

  const DetailDescription({
    Key key,
    @required this.attraction,
    @required this.attractionDetail,
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
                text: '문의 및 안내: ',
                style: TextStyle(fontWeight: FontWeight.w600)),
            TextSpan(text: attractionDetail.infoCenter ?? ''),
          ]),
        ),
        SizedBox(height: 10),
        Text.rich(
          TextSpan(children: [
            TextSpan(
                text: '쉬는 날: ', style: TextStyle(fontWeight: FontWeight.w600)),
            TextSpan(text: attractionDetail.restDate ?? ''),
          ]),
        ),
        SizedBox(height: 10),
        Text.rich(
          TextSpan(children: [
            TextSpan(
                text: '주차시설: ', style: TextStyle(fontWeight: FontWeight.w600)),
            TextSpan(text: attractionDetail.parking ?? ''),
          ]),
        ),
        SizedBox(height: 10),
        // Text.rich(
        //   TextSpan(children: [
        //     TextSpan(
        //         text: '이용시간: ',
        //         style: TextStyle(fontWeight: FontWeight.w600)),
        //     TextSpan(text: attractionDetail.useTime ?? ''),
        //   ]),
        // ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('이용시간: ', style: TextStyle(fontWeight: FontWeight.w600)),
            Expanded(
              child: Html(
                data: attractionDetail.useTime ?? '',
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
                    attraction.address,
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
                attraction.title,
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