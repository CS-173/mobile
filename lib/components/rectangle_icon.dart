import 'package:flutter/cupertino.dart';

class RectangleIcon extends StatelessWidget {
  const RectangleIcon({
    super.key,
    required this.name,
    required this.color,
    required this.bg
  });

  final String name;
  final Color color;
  final Color bg;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 6),
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(3)
      ),
      child: Text(
        name,
        style: TextStyle(
            color: color,
            fontWeight: FontWeight.w700,
            fontSize: 10
        ),
      ),
    );
  }
}