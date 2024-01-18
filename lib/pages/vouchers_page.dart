import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../style/constants.dart';

class VouchersPage extends StatelessWidget {
  const VouchersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: Constants.defaultPadding, top: Constants.defaultPadding, right: Constants.defaultPadding),
              child: Text(
                "Vouchers",
                style: TextStyle(
                    color: Constants.primaryColor,
                    fontSize: 27,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),

            SizedBox(height: Constants.defaultPadding),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: Constants.defaultPadding),
              child: Text(
                "GASULIT MEMBER BENEFITS",
                style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),

            SizedBox(height: Constants.defaultPadding),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Transform.scale(
                scale: 0.94,
                child: Row(
                  children: [
                    RectangleWIthImageText(header: "Get 10% off your next Refill!", subtext: "Valid until 29/06/2024"),
                    const SizedBox(width: Constants.defaultPadding),
                    RectangleWIthImageText(header: "Get 5% off your next Refill!", subtext: "Valid until 29/06/2024"),
                  ],
                ),
              ),
            ),

            SizedBox(height: Constants.defaultPadding),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: Constants.defaultPadding),
              child: Text(
                "GASULIT PLUS REWARDS",
                style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),

            const SizedBox(height: Constants.defaultPadding),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: Constants.defaultPadding),
              child: Container(
                padding: EdgeInsets.all(Constants.defaultPadding),
                width: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Constants.defaultPadding),
                  color: Colors.white,
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
                    Text(
                      "Learn about your Gasulit Plus Rewards",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800]
                      ),
                    ),
                    SizedBox(height: Constants.defaultPadding/3),
                    Text(
                      "Tap here to learn how to unlock your rewards.",
                      style: TextStyle(
                          fontSize: 13,
                      ),
                    ),
                  ],
                ),
              )
            ),

          ],
        )
      ),
    );
  }
}

class RectangleWIthImageText extends StatelessWidget {
  RectangleWIthImageText({
    super.key,
    required this.header,
    required this.subtext
  });

  String header;
  String subtext;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Constants.defaultPadding),
        color: Colors.white,
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
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(Constants.defaultPadding), topRight: Radius.circular(Constants.defaultPadding)
              ),
              color: Colors.red
            ),
            height: 175,
            width: 275,
          ),

          Container(
            padding: EdgeInsets.all(Constants.defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  header,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800]
                  ),
                ),
                SizedBox(height: Constants.defaultPadding/3),
                Text(
                  subtext
                ),
                SizedBox(height: Constants.defaultPadding*1.5)
              ],
            ),
          )
        ],
      ),
    );
  }
}