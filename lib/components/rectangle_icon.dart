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
      width: 40,
      height: 20,
      decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(3)
      ),
      child: Center(
        child: Text(
          name,
          style: TextStyle(
              color: color,
              fontWeight: FontWeight.w700,
              fontSize: 10
          ),
        ),
      ),
    );
  }
}

class PaymentMethodIcon extends StatelessWidget {
  const PaymentMethodIcon({
    super.key,
    required this.image,
    required this.color,
    required this.bg
  });

  final String image;
  final Color color;
  final Color bg;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 30,
      child: Center(
        child: Image.asset(
            image,
        ),
      ),
    );
  }
}