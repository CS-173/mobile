import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/icon_and_widget_rectangle.dart';
import '../style/constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(Constants.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hi Irish Ghayle",
                style: TextStyle(
                    color: Constants.primaryColor,
                    fontSize: 27,
                    fontWeight: FontWeight.bold
                ),
              ),
              Text(
                "Nice to see you again",
                style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 15,
                    fontWeight: FontWeight.w500
                ),
              ),

              const SizedBox(height: 10),

              Container(
                padding: const EdgeInsets.all(Constants.defaultPadding),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Constants.defaultPadding),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: Offset(0, 2.0),
                      blurRadius: 2,
                      spreadRadius: 1.0,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "65 points",
                      style: TextStyle(
                          color: Constants.primaryColor,
                          fontSize: 27,
                          fontWeight: FontWeight.bold
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      "How can I collect points?",
                      style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 15,
                          fontWeight: FontWeight.w500
                      ),
                    ),

                    const SizedBox(height: 10),

                    Divider(color: Colors.grey[300]),

                    const SizedBox(height: 10),

                    const Text(
                      "7 stamps to go",
                      style: TextStyle(
                          color: Constants.primaryColor,
                          fontSize: 23,
                          fontWeight: FontWeight.bold
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      "Learn how to get the most out of your stamps",
                      style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 15,
                          fontWeight: FontWeight.w500
                      ),
                    ),

                    const SizedBox(height: 30),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(
                        10,
                            (index) => Container(
                              decoration: BoxDecoration(
                                color: index<3?Constants.primaryColor:Colors.grey[100],
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: index<3?Colors.white:Colors.grey[300]!)
                              ),
                          width: 25, // Adjust the width of each rectangle
                          height: 8, // Adjust the height of each rectangle
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: Constants.defaultPadding),

              IconAndWidgetRectangle(
                icon: Icon(Icons.shopping_basket, color: Constants.primaryColor, size: 25),
                rectColor: Colors.white,
                widget: Text(
                  "Use your points",
                  style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 15,
                      fontWeight: FontWeight.w500
                  ),
                ),
              ),

              const SizedBox(height: Constants.defaultPadding),

              Text(
                "NEAREST STATION",
                style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 12,
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
                                "SH SANTILLAN PASONG TAMO",
                                style: TextStyle(
                                  color: Colors.grey[800],
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                          
                              const SizedBox(height: Constants.defaultPadding/4),
                          
                              Text(
                                "Open 24 hours",
                                style: TextStyle(
                                    color: Colors.grey[800],
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400
                                ),
                              ),
                          
                              const SizedBox(height: Constants.defaultPadding/4),
                          
                              Text(
                                "5 mins • 0.8 km.",
                                style: TextStyle(
                                    color: Colors.grey[800],
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: Constants.defaultPadding, right: Constants.defaultPadding/2),
                          child: Column(
                            children: [
                              Container(
                                width: 30, // Adjust the size of the circle
                                height: 30,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Constants.irish5, // Adjust the color of the circle
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.directions_sharp, // Choose the desired icon
                                    color: Colors.white, // Adjust the color of the icon
                                    size: 25, // Adjust the size of the icon
                                  ),
                                ),
                              ),
                              const SizedBox(height: 3),
                              const Text(
                                "Route",
                                style: TextStyle(
                                    color: Constants.irish5,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500
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
            ],
          ),
        )
      ),
    );
  }
}


