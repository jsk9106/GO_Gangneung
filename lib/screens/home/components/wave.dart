import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_gangneung/contstants.dart';
import 'package:go_gangneung/screens/attraction/attraction_screen.dart';
import 'package:go_gangneung/screens/home/components/menu_button.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Wave extends StatefulWidget {
  @override
  _WaveState createState() => _WaveState();
}

class _WaveState extends State<Wave> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 5000));
    _animation =
        Tween<double>(begin: 0, end: 2 * pi).animate(_animationController);
    _animationController.addListener(() {
      setState(() {});
    });
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  final double waveHeight = 300;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      left: 0,
      child: Stack(
        children: [
          Container(
            height: waveHeight,
            child: ClipPath(
              clipper: WaveClipper(_animation.value),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.blue,
                      Colors.greenAccent,
                    ],
                  ),
                ),
              ),
            ),
          ),
          _oneButton(-.7, 0, kYellowColor, Icons.card_travel, '관광지', () => Get.to(() => AttractionScreen())),
          _oneButton(0, 0, kRedColor, Icons.restaurant, '맛집', () => print('tab!!')),
          _oneButton(.8, 0, kPrimaryColor, Icons.local_cafe, '카페', () => print('tab!!')),
          _oneButton(-.3, 140, kGreenColor, MdiIcons.tag, '즐겨찾기', () => print('tab!!')),
          _oneButton(.5, 120, kPurpleColor, Icons.more_horiz, '더보기', () => print('tab!!')),
        ],
      ),
    );
  }

  // 버튼 그리기
  Widget _oneButton(double align, double topMargin, Color color, IconData iconData, String label, Function press) {
    // -1 ~ 1
    align = (align + 1) / 2; // 0 ~ 1
    var leftPos =
        MediaQuery.of(context).size.width * align - WaveClipper.bottleSize / 2;
    var leftCenterPos = align * MediaQuery.of(context).size.width;
    var degree =
        cos(_animation.value + leftCenterPos * WaveClipper.waveDouble) * 45 * .3;
    return Positioned(
        left: leftPos,
        top: WaveClipper.getYWithx(leftCenterPos.toInt(), _animation.value, topMargin: topMargin),
        child: RotationTransition(
          turns: AlwaysStoppedAnimation(degree / 360),
          child: menuButton(color, iconData, label, press),
        ),
    );
  }

}

// 웨이브 애니메이션
class WaveClipper extends CustomClipper<Path> {
  final double animationValue;

  WaveClipper(this.animationValue);

  @override
  Path getClip(Size size) {
    var p = Path();
    var points = <Offset>[];
    for (var x = 0; x < size.width; x++) {
      points
          .add(Offset(x.toDouble(), WaveClipper.getYWithx(x, animationValue)));
    }

    p.moveTo(0, WaveClipper.getYWithx(0, animationValue));
    p.addPolygon(points, false);
    p.lineTo(size.width, size.height);
    p.lineTo(0, size.height);

    return p;
  }

  static const double waveHeight = 50;
  static const double bottleSize = 80;
  static const double waveDouble = 0.01;

  static double getYWithx(int x, double animationValue,
      {double topMargin = bottleSize / 1.5}) {
    var y = ((sin(animationValue + x * waveDouble) + 1) / 2) * waveHeight +
        topMargin; // 0 - 1
    return y;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
