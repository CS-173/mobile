import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/components/rectangle_icon.dart';

class PaymentOptions extends StatelessWidget {
  const PaymentOptions({
    super.key,
    required this.paymentMethods
  });

  final Map<String, bool> paymentMethods;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (paymentMethods['cash']!)RectangleIcon(name: "CASH", color: Colors.green[900]!, bg: Colors.green[200]!),
        if (paymentMethods['credit']!)RectangleIcon(name: "CC", color: Colors.brown[700]!, bg: Colors.yellow[800]!),
        if (paymentMethods['gcash']!)RectangleIcon(name: "GCASH", color: Colors.white, bg: Colors.blue[700]!),
        if (paymentMethods['maya']!)RectangleIcon(name: "MAYA", color: Colors.green[900]!, bg: Colors.black)
      ],
    );
  }
}