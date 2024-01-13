import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaymentOptions extends StatefulWidget {
  const PaymentOptions({
    super.key,
    required this.paymentMethods
  });

  final Map<String, bool> paymentMethods;

  @override
  State<PaymentOptions> createState() => _PaymentOptionsState();
}

class _PaymentOptionsState extends State<PaymentOptions> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (widget.paymentMethods['cash']!)PaymentMethodBadge(paymentMethod: widget.paymentMethods['cash']!, name: "CASH", color: Colors.green[900]!, bg: Colors.green[200]!),
        if (widget.paymentMethods['credit']!)PaymentMethodBadge(paymentMethod: widget.paymentMethods['credit']!, name: "  CC  ", color: Colors.brown[700]!, bg: Colors.yellow[800]!),
        if (widget.paymentMethods['gcash']!)PaymentMethodBadge(paymentMethod: widget.paymentMethods['gcash']!, name: "GCASH", color: Colors.white!, bg: Colors.blue[700]!),
        if (widget.paymentMethods['maya']!)PaymentMethodBadge(paymentMethod: widget.paymentMethods['maya']!, name: "MAYA", color: Colors.green[900]!, bg: Colors.black)
      ],
    );
  }
}

class PaymentMethodBadge extends StatefulWidget {
  const PaymentMethodBadge({
    super.key,
    required this.paymentMethod,
    required this.name,
    required this.color,
    required this.bg
  });

  final bool paymentMethod;
  final String name;
  final Color color;
  final Color bg;

  @override
  State<PaymentMethodBadge> createState() => _PaymentMethodBadgeState();
}

class _PaymentMethodBadgeState extends State<PaymentMethodBadge> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 6),
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
          color: widget.bg,
          borderRadius: BorderRadius.circular(3)
      ),
      child: Text(
        widget.name,
        style: TextStyle(
            color: widget.color,
            fontWeight: FontWeight.w700,
            fontSize: 10
        ),
      ),
    );
  }
}