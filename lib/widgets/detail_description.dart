import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:go_gangneung/model/category.dart';
import 'package:go_gangneung/widgets/title_and_favorite.dart';

class DetailDescription extends StatelessWidget {
  final item;
  final itemDetail;
  final String overView;
  final Categories category;

  const DetailDescription({
    Key key,
    @required this.item,
    @required this.itemDetail,
    @required this.overView,
    @required this.category,
  }) : super(key: key);

  Widget _changeWidget() {
    switch (category) {
      case Categories.attraction:
        return attractionDescription();
        break;
      case Categories.restaurant:
        return restaurantDescription();
        break;
      case Categories.festival:
        return festivalDescription();
        break;
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleAndFavorite(item: item),
          SizedBox(height: 30),
          overView == ''
              ? Text(
                  '불러오는 중..',
                  style: TextStyle(color: Colors.black54, fontSize: 11),
                )
              : Html(
                  data: overView ?? '',
                  style: {
                    "*": Style(
                        color: Colors.black54,
                        margin: const EdgeInsets.all(0),
                        lineHeight: 1.3,
                        fontSize: FontSize.small),
                  },
                ),
          SizedBox(height: 20),
          Text(
            'More',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 25),
          _changeWidget(),
        ],
      ),
    );
  }

  Widget attractionDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text.rich(
          TextSpan(children: [
            TextSpan(
                text: '문의 및 안내: ',
                style: TextStyle(fontWeight: FontWeight.w600)),
            TextSpan(text: itemDetail.infoCenter ?? ''),
          ]),
        ),
        SizedBox(height: 10),
        Text.rich(
          TextSpan(children: [
            TextSpan(
                text: '쉬는 날: ', style: TextStyle(fontWeight: FontWeight.w600)),
            TextSpan(text: itemDetail.restDate ?? ''),
          ]),
        ),
        SizedBox(height: 10),
        Text.rich(
          TextSpan(children: [
            TextSpan(
                text: '주차시설: ', style: TextStyle(fontWeight: FontWeight.w600)),
            TextSpan(text: itemDetail.parking ?? ''),
          ]),
        ),
        SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('이용시간: ', style: TextStyle(fontWeight: FontWeight.w600)),
            Expanded(
              child: Html(
                data: itemDetail.useTime ?? '',
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

  Widget restaurantDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text.rich(
          TextSpan(children: [
            TextSpan(
                text: '대표 메뉴: ', style: TextStyle(fontWeight: FontWeight.w600)),
            TextSpan(text: itemDetail.firstMenu ?? ''),
          ]),
        ),
        SizedBox(height: 10),
        Text.rich(
          TextSpan(children: [
            TextSpan(
                text: '메뉴: ', style: TextStyle(fontWeight: FontWeight.w600)),
            TextSpan(text: itemDetail.treatMenu ?? ''),
          ]),
        ),
        SizedBox(height: 10),
        Text.rich(
          TextSpan(children: [
            TextSpan(
                text: '문의 및 안내: ',
                style: TextStyle(fontWeight: FontWeight.w600)),
            TextSpan(text: itemDetail.infoCenterFood ?? ''),
          ]),
        ),
        SizedBox(height: 10),
        Text.rich(
          TextSpan(children: [
            TextSpan(
                text: '쉬는 날: ', style: TextStyle(fontWeight: FontWeight.w600)),
            TextSpan(text: itemDetail.restDateFood ?? ''),
          ]),
        ),
        SizedBox(height: 10),
        Text.rich(
          TextSpan(children: [
            TextSpan(
                text: '주차시설: ', style: TextStyle(fontWeight: FontWeight.w600)),
            TextSpan(text: itemDetail.parkingFood ?? ''),
          ]),
        ),
        SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('엽업 시간: ', style: TextStyle(fontWeight: FontWeight.w600)),
            Expanded(
              child: Html(
                data: itemDetail.openTimeFood ?? '',
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

  Widget festivalDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text.rich(
          TextSpan(children: [
            TextSpan(
                text: '축제 기간: ', style: TextStyle(fontWeight: FontWeight.w600)),
            itemDetail.eventStartDate == null && itemDetail.eventEndDate == null
                ? TextSpan()
                : TextSpan(
                    text:
                        '${itemDetail.eventStartDate} ~ ${itemDetail.eventEndDate}'),
          ]),
        ),
        SizedBox(height: 10),
        Text.rich(
          TextSpan(children: [
            TextSpan(
                text: '입장 가능 시간: ',
                style: TextStyle(fontWeight: FontWeight.w600)),
            TextSpan(text: itemDetail.spendTimeFestival ?? ''),
          ]),
        ),
        SizedBox(height: 10),
        Text.rich(
          TextSpan(children: [
            TextSpan(
                text: '가능연령: ', style: TextStyle(fontWeight: FontWeight.w600)),
            TextSpan(text: itemDetail.ageLimit ?? ''),
          ]),
        ),
        SizedBox(height: 10),
        Text.rich(
          TextSpan(children: [
            TextSpan(
                text: '주최: ', style: TextStyle(fontWeight: FontWeight.w600)),
            TextSpan(text: itemDetail.sponsor1 ?? ''),
          ]),
        ),
        SizedBox(height: 10),
        Text.rich(
          TextSpan(children: [
            TextSpan(
                text: '주관: ', style: TextStyle(fontWeight: FontWeight.w600)),
            TextSpan(text: itemDetail.sponsor2 ?? ''),
          ]),
        ),
        SizedBox(height: 10),
        Text.rich(
          TextSpan(children: [
            TextSpan(
                text: '문의번호: ', style: TextStyle(fontWeight: FontWeight.w600)),
            TextSpan(text: itemDetail.sponsor1Tel ?? ''),
            itemDetail.sponsor2Tel == null
                ? TextSpan()
                : TextSpan(text: ' / ${itemDetail.sponsor2Tel}'),
          ]),
        ),
        SizedBox(height: 10),
        Text.rich(
          TextSpan(children: [
            TextSpan(
                text: '이용요금: ', style: TextStyle(fontWeight: FontWeight.w600)),
            TextSpan(text: itemDetail.useTimeFestival ?? ''),
          ]),
        ),
        SizedBox(height: 10),
        Text.rich(
          TextSpan(children: [
            TextSpan(
                text: '위치정보: ', style: TextStyle(fontWeight: FontWeight.w600)),
            TextSpan(text: itemDetail.eventPlace ?? ''),
          ]),
        ),
      ],
    );
  }


}
