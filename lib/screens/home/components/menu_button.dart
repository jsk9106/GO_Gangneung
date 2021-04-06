import 'package:flutter/material.dart';

Widget menuButton(Color color, IconData iconData, String label, Function press) {
  return Container(
    child: GestureDetector(
      onTap: press,
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            child: Icon(iconData, color: Colors.white),
          ),
          SizedBox(height: 8),
          Text(label, style: TextStyle(color: Colors.white)),
        ],
      ),
    ),
  );
}