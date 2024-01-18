import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/icon_and_widget_rectangle.dart';
import '../style/constants.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(Constants.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Irish Ghayle",
                style: TextStyle(
                    color: Constants.primaryColor,
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: Constants.defaultPadding),
              Text(
                "Account",
                style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 13,
                    fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: Constants.defaultPadding),
              IconAndWidgetRectangle(widget1: Icon(Icons.person),widget2: Text("View and edit profile"), rectColor: Colors.white),
              const SizedBox(height: Constants.defaultPadding),
              IconAndWidgetRectangle(widget1: Icon(Icons.settings),widget2: Text("Settings"), rectColor: Colors.white),
              const SizedBox(height: Constants.defaultPadding),
              Text(
                "Payments and billing",
                style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 13,
                    fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: Constants.defaultPadding),
              IconAndWidgetRectangle(widget1: Icon(Icons.list_outlined),widget2: Text("Transactions"), rectColor: Colors.white),
              const SizedBox(height: Constants.defaultPadding),
              Text(
                "Help and support",
                style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 13,
                    fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: Constants.defaultPadding),
              IconAndWidgetRectangle(widget1: Icon(Icons.help),widget2: Text("Help"), rectColor: Colors.white),
              const SizedBox(height: Constants.defaultPadding),
              IconAndWidgetRectangle(widget1: Icon(Icons.directions_sharp),widget2: Text("App Tours"), rectColor: Colors.white),
              const SizedBox(height: Constants.defaultPadding),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Legal",
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 10,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    "5.11.0 (511012)",
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 10,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ),
    );
  }
}