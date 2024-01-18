import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/icon_and_widget_rectangle.dart';
import '../components/square_text_widget.dart';
import '../style/constants.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(Constants.defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Wallet",
                      style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 27,
                          fontWeight: FontWeight.bold
                      ),
                    ),

                    const SizedBox(height: Constants.defaultPadding),

                    Text(
                      "Our multi-layered security keeps\nyou safe",
                      style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 15,
                          fontWeight: FontWeight.w500
                      ),
                    ),

                    const SizedBox(height: Constants.defaultPadding),

                    Container(
                      height: 220.0, // Set the desired height of the Stack
                      child: Stack(
                        children: [
                          Positioned(
                            child: Padding(
                              padding: const EdgeInsets.only(top: Constants.defaultPadding),
                              child: Transform.scale(
                                scale: 1.119,
                                child: Image.asset(
                                  'lib/assets/images/Card.png',
                                  fit: BoxFit.fitWidth,
                                  width: double.infinity,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 20.0,
                            left: 20.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Pitstop Wallet',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  '₱32,467.25',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    IconAndWidgetRectangle(
                        radius: Constants.defaultPadding,
                        widget1: const Icon(Icons.health_and_safety_outlined, color: Colors.white, size: 25),
                        rectColor: Constants.irish2,
                        widget2: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Activate your Pitstop Wallet",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            Text(
                              "Go cashless and earn Vouchers",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                          ],
                        )
                    ),
                  ],
                ),
              ),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Transform.scale(
                  scale: 0.91,
                  child: Row(
                    children: [
                      IconAndWidgetRectangle(
                        widget1: Icon(Icons.account_balance_wallet_outlined, color: Constants.white, size: 25),
                        rectColor: Constants.irish3,
                        verticalPadding: Constants.defaultPadding,
                        widget2: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Cash In",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.white
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: Constants.defaultPadding),
                      IconAndWidgetRectangle(
                        widget1: Icon(Icons.document_scanner_outlined, color: Constants.white, size: 25),
                        rectColor: Constants.irish5,
                        verticalPadding: Constants.defaultPadding,
                        widget2: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Scan to Pay",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.white
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: Constants.defaultPadding),
                      IconAndWidgetRectangle(
                        widget1: Icon(Icons.move_to_inbox, color: Constants.white, size: 25),
                        rectColor: Constants.irish4,
                        verticalPadding: Constants.defaultPadding,
                        widget2: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Transfer",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.white
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.all(Constants.defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(color: Colors.grey[300]),

                    const SizedBox(height: Constants.defaultPadding/2),

                    Text(
                      "Get more vouchers",
                      style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                    ),

                    const SizedBox(height: Constants.defaultPadding),

                    Container(
                      padding: const EdgeInsets.all(Constants.defaultPadding),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Stand a chance to win up to 10,000 points!",
                                      style: TextStyle(
                                        color: Colors.grey[800],
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),

                                    const SizedBox(height: Constants.defaultPadding/4),

                                    Text(
                                      "Explore activities that can win you vouchers!",
                                      style: TextStyle(
                                          color: Colors.grey[500],
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: Constants.defaultPadding/2, right: Constants.defaultPadding/2),
                                child: Column(
                                  children: [
                                    Center(
                                      child: Image.asset(
                                        'lib/assets/images/Gift-08.png',
                                        width: 75,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: Constants.defaultPadding),

                    Divider(color: Colors.grey[300]),

                    const SizedBox(height: Constants.defaultPadding/2),

                    Text(
                      "Recommended for you",
                      style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                    ),

                    const SizedBox(height: Constants.defaultPadding),

                    SquareTextWidget(text: 'Get started\nwith PitstopPay', squareColorTop: Colors.green[700]!, squareColorBottom: Colors.green[200]!, textColor: Colors.white),

                    const SizedBox(height: Constants.defaultPadding),

                    Divider(color: Colors.grey[300]),

                    const SizedBox(height: Constants.defaultPadding/2),

                    Text(
                      "Recent Transactions",
                      style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    SizedBox(
                      height: 175,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(CupertinoIcons.cube_box, size: 100, color: Colors.grey[500],),
                            Text('There\'s no recent activity to show here.', style: TextStyle(color: Colors.grey[600])),
                            Text('See past transactions', style: TextStyle(color: Colors.lightBlue[800], fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        )
      ),
    );
  }
}