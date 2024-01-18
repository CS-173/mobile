import 'package:flutter/cupertino.dart';

import '../style/constants.dart';

class SquareTextWidget extends StatelessWidget {
  SquareTextWidget({
    super.key,
    required this.text,
    required this.squareColorTop,
    required this.squareColorBottom,
    required this.textColor
  });

  String text;
  Color squareColorTop;
  Color squareColorBottom;
  Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Constants.defaultPadding),
      width: 150,
      height: 150,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Constants.defaultPadding),
          color: Constants.primaryColor,
          gradient: LinearGradient(
              colors: [
                squareColorTop, // Dark red at the bottom left
                squareColorBottom, // Bright red at the top right
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter
          )
      ),
      child: Text(
        text,
        style: TextStyle(
            fontWeight: FontWeight.w500,
            color: textColor,
          fontSize: 15
        ),
      ),
    );
  }
}