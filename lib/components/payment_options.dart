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
        if (paymentMethods['cash']!)PaymentMethodIcon(image: "lib/assets/images/Logos-09.png", color: Colors.green[900]!, bg: Colors.white),
        if (paymentMethods['credit']!)PaymentMethodIcon(image: "lib/assets/images/Logos-13.png", color: Colors.brown[700]!, bg: Colors.yellow[800]!),
        if (paymentMethods['gcash']!)PaymentMethodIcon(image: "lib/assets/images/Logos-10.png", color: Colors.blue, bg: Colors.white),
        if (paymentMethods['maya']!)PaymentMethodIcon(image: "lib/assets/images/Logos-12.png", color: Colors.green[900]!, bg: Colors.white)
      ],
    );
  }
}