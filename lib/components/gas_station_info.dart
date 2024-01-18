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
        Padding(
          padding: const EdgeInsets.only(top: Constants.defaultPadding, left: Constants.defaultPadding, right: Constants.defaultPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  gasStation.stationName,
                  style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 20
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              PaymentOptions(paymentMethods: gasStation.paymentMethods)
            ],
          ),
        ),
        Expanded(
          child: Transform.scale(
            scale: 0.95,
              child: FuelList(fuelList: gasStation.fuel))),
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
      physics: const AlwaysScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: fuelList.length,
      itemBuilder: (context, index) {
        Fuel fuel = fuelList[index];
        return Card(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Constants.defaultPadding),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: const Offset(0, 2.0),
                  blurRadius: 3,
                  spreadRadius: 1.0,
                ),
              ],
            ),
            child: ListTile(
              title: Text(fuel.fuelName, style: TextStyle(color: Colors.grey[700]),),
              subtitle: Text('₱${fuel.fuelPrice.toStringAsFixed(2)}', style: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.w900)),
              trailing: fuel.fuelAvailable ? const Icon(Icons.check_circle, color: Colors.green) : const Icon(Icons.cancel, color: Colors.red),
              // Add more widgets as needed for additional information
            ),
          ),
        );
      },
    );
  }
}