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
                          fontWeight: FontWeight.w900
                      ),
                    ),

                    const SizedBox(height: Constants.defaultPadding),

                    Text(
                      "Our multi-layered security keeps\nyou safe",
                      style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 15,
                          fontWeight: FontWeight.w400
                      ),
                    ),

                    const SizedBox(height: Constants.defaultPadding),

                    Container(
                      width: double.maxFinite,
                      height: 175, // Adjust the height of the container
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Constants.defaultPadding),
                        gradient: LinearGradient(
                          colors: [
                            Colors.red.shade900, // Dark red at the bottom left
                            Colors.red.shade300, // Bright red at the top right
                          ],
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(top: Constants.defaultPadding, left: Constants.defaultPadding, right: Constants.defaultPadding, bottom: Constants.defaultPadding/1.5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Gasulit Wallet',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),
                            Text(
                              '₱32,467.25',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: Constants.defaultPadding),

                    IconAndWidgetRectangle(
                        radius: Constants.defaultPadding,
                        icon: const Icon(Icons.health_and_safety_outlined, color: Colors.white, size: 25),
                        rectColor: Constants.irish5,
                        widget: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Activate your Gasulit Wallet",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w800
                              ),
                            ),
                            Text(
                              "Go cashless and earn Vouchers",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400
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
                        icon: Icon(Icons.account_balance_wallet_outlined, color: Constants.primaryColor, size: 25),
                        rectColor: Constants.white,
                        verticalPadding: Constants.defaultPadding / 2,
                        widget: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Cash In",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: Constants.defaultPadding),
                      IconAndWidgetRectangle(
                        icon: Icon(Icons.document_scanner_outlined, color: Constants.primaryColor, size: 25),
                        rectColor: Constants.white,
                        verticalPadding: Constants.defaultPadding / 2,
                        widget: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Scan to Pay",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: Constants.defaultPadding),
                      IconAndWidgetRectangle(
                        icon: Icon(Icons.move_to_inbox, color: Constants.primaryColor, size: 25),
                        rectColor: Constants.white,
                        verticalPadding: Constants.defaultPadding / 2,
                        widget: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Transfer",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
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
                          fontWeight: FontWeight.w900
                      ),
                    ),

                    const SizedBox(height: Constants.defaultPadding),

                    Container(
                      padding: const EdgeInsets.all(Constants.defaultPadding),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
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
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),

                                    const SizedBox(height: Constants.defaultPadding/4),

                                    Text(
                                      "Explore activities that can win you vouchers!",
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: Constants.defaultPadding, right: Constants.defaultPadding/2),
                                child: Column(
                                  children: [
                                    Center(
                                      child: Icon(
                                        CupertinoIcons.gift_fill, // Choose the desired icon
                                        color: Constants.primaryColor, // Adjust the color of the icon
                                        size: 75, // Adjust the size of the icon
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
                          fontWeight: FontWeight.w900
                      ),
                    ),

                    const SizedBox(height: Constants.defaultPadding),

                    SquareTextWidget(text: 'Get started\nwith GasulitPay', squareColorTop: Colors.green[700]!, squareColorBottom: Colors.green[200]!, textColor: Colors.white),

                    const SizedBox(height: Constants.defaultPadding),

                    Divider(color: Colors.grey[300]),

                    const SizedBox(height: Constants.defaultPadding/2),

                    Text(
                      "Recent Transactions",
                      style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 27,
                          fontWeight: FontWeight.w900
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
                            Text('See past transactions', style: TextStyle(color: Colors.lightBlue[800], fontWeight: FontWeight.w700)),
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