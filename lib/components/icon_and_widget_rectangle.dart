import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../style/constants.dart';

class IconAndWidgetRectangle extends StatelessWidget {
  IconAndWidgetRectangle({
    super.key,
    required this.widget1,
    required this.widget2,
    required this.rectColor,
    this.horizontalPadding = Constants.defaultPadding,
    this.verticalPadding = Constants.defaultPadding,
    this.radius = Constants.defaultPadding,
  });

  Widget widget1;
  Widget widget2;
  Color rectColor;
  double horizontalPadding;
  double verticalPadding;
  double radius;


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding/2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: rectColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 2.0),
            blurRadius: 2,
            spreadRadius: 1.0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              widget1,
              SizedBox(width: horizontalPadding),
              widget2
            ],
          ),
        ],
      ),
    );
  }
}