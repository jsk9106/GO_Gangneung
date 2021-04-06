import 'package:flutter/material.dart';

const Color kScaffoldColor = Color(0xFFF0F2F5);
const Color kPrimaryColor = Color(0xff5985de);
const Color kYellowColor = Color(0xfff4c969);
const Color kRedColor = Color(0xfff2573d);
const Color kGreenColor = Color(0xff34c695);
const Color kPurpleColor = Color(0xff6f64f0);

final BoxShadow kDefaultBoxShadow = BoxShadow(
  offset: Offset(0, 5),
  color: Colors.black.withOpacity(0.05),
  blurRadius: 5,
);

const LinearGradient kWaveGradient = LinearGradient(
  colors: [Color(0xFF496AE1), Color(0xFFCE48B1)],
);