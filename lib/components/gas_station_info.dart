import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/components/payment_options.dart';

import '../models/gas_station_model.dart';
import '../style/constants.dart';

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
        FuelList(fuelList: gasStation.fuel),
      ],
    );
  }
}

class FuelList extends StatelessWidget {
  const FuelList({
    super.key,
    required this.fuelList,
  });

  final List<Fuel> fuelList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: fuelList.length,
      itemBuilder: (context, index) {
        Fuel fuel = fuelList[index];
        return Card(
          margin: EdgeInsets.only(top: 10),
          color: Constants.secondaryColor,
          child: ListTile(
            title: Text(fuel.fuelName, style: TextStyle(color: Colors.white.withOpacity(0.8)),),
            subtitle: Text('Price: ₱${fuel.fuelPrice.toStringAsFixed(2)}', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900)),
            trailing: fuel.fuelAvailable ? const Icon(Icons.check_circle, color: Colors.green) : const Icon(Icons.cancel, color: Colors.red),
            // Add more widgets as needed for additional information
          ),
        );
      },
    );
  }
}