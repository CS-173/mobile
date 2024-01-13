import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/components/payment_options.dart';

import '../models/gas_station_model.dart';

class GasStationInfo extends StatelessWidget {
  const GasStationInfo({
    super.key,
    required this.gasStation,
  });

  final GasStation gasStation;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              gasStation.stationName,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20
              ),
            ),
            PaymentOptions(paymentMethods: gasStation.paymentMethods)
          ],
        ),
        Text(
          gasStation.paymentMethods['cash'].toString(),
          style: TextStyle(
              color: Colors.white,
              fontSize: 20
          ),
        ),
        Text(
          gasStation.isOpen?"Open":"Closed",
          style: TextStyle(
              color: Colors.white,
              fontSize: 20
          ),
        )
      ],
    );
  }
}