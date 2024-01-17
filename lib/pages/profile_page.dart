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
                    fontSize: 27,
                    fontWeight: FontWeight.w900
                ),
              ),
              const SizedBox(height: Constants.defaultPadding),
              Text(
                "Account",
                style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 13,
                    fontWeight: FontWeight.w900
                ),
              ),
              const SizedBox(height: Constants.defaultPadding),
              IconAndWidgetRectangle(icon: Icon(Icons.person),widget: Text("View and edit profile"), rectColor: Colors.white),
              const SizedBox(height: Constants.defaultPadding),
              IconAndWidgetRectangle(icon: Icon(Icons.settings),widget: Text("Settings"), rectColor: Colors.white),
              const SizedBox(height: Constants.defaultPadding),
              Text(
                "Payments and billing",
                style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 13,
                    fontWeight: FontWeight.w900
                ),
              ),
              const SizedBox(height: Constants.defaultPadding),
              IconAndWidgetRectangle(icon: Icon(Icons.list_outlined),widget: Text("Transactions"), rectColor: Colors.white),
              const SizedBox(height: Constants.defaultPadding),
              Text(
                "Help and support",
                style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 13,
                    fontWeight: FontWeight.w900
                ),
              ),
              const SizedBox(height: Constants.defaultPadding),
              IconAndWidgetRectangle(icon: Icon(Icons.help),widget: Text("Help"), rectColor: Colors.white),
              const SizedBox(height: Constants.defaultPadding),
              IconAndWidgetRectangle(icon: Icon(Icons.directions_sharp),widget: Text("App Tours"), rectColor: Colors.white),
              const SizedBox(height: Constants.defaultPadding),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Legal",
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 10,
                        fontWeight: FontWeight.w900
                    ),
                  ),
                  Text(
                    "5.11.0 (511012)",
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 10,
                        fontWeight: FontWeight.w900
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