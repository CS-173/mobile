import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../style/constants.dart';

class IconAndWidgetRectangle extends StatelessWidget {
  IconAndWidgetRectangle({
    super.key,
    required this.icon,
    required this.widget,
    required this.rectColor,
    this.horizontalPadding = Constants.defaultPadding,
    this.verticalPadding = Constants.defaultPadding,
    this.radius = Constants.defaultPadding,
  });

  Icon icon;
  Widget widget;
  Color rectColor;
  double horizontalPadding;
  double verticalPadding;
  double radius;


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
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
              icon,
              SizedBox(width: horizontalPadding),
              widget
            ],
          ),
        ],
      ),
    );
  }
}