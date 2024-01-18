import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/pages/home_page.dart';
import 'package:mobile/pages/map_page.dart';
import 'package:mobile/pages/profile_page.dart';
import 'package:mobile/pages/vouchers_page.dart';
import 'package:mobile/pages/wallet_page.dart';
import 'package:mobile/style/constants.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final PersistentTabController _controller = PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens() {
    return [
      const HomePage(),
      const WalletPage(),
      const MapPage(),
      const VouchersPage(),
      const ProfilePage()
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.home, size: 20),
        title: ("Home"),
        textStyle: TextStyle(fontSize: 10.0),
        activeColorPrimary: Constants.irish2,
        inactiveColorPrimary: CupertinoColors.white,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.wallet, size: 20),
        title: ("Wallet"),
        textStyle: TextStyle(fontSize: 10.0),
        activeColorPrimary: Constants.irish2,
        inactiveColorPrimary: CupertinoColors.white,
      ),
      PersistentBottomNavBarItem(
        icon: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 50,
          child: Image.asset(
            'lib/assets/images/Logo.png',
            width: 40,
            height: 40,
          ),
        ),
        title: ("Stations"),
        textStyle: TextStyle(fontSize: 10.0),
        activeColorPrimary: Constants.irish2,
        activeColorSecondary: Constants.irish2,
        inactiveColorPrimary: CupertinoColors.white,
        contentPadding: 10.0
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.gift, size: 20),
        title: ("Vouchers"),
        textStyle: TextStyle(fontSize: 10.0),
        activeColorPrimary: Constants.irish2,
        inactiveColorPrimary: CupertinoColors.white,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.profile_circled, size: 20),
        title: ("Profile"),
        textStyle: TextStyle(fontSize: 10.0),
        activeColorPrimary: Constants.irish2,
        inactiveColorPrimary: CupertinoColors.white,
      ),
    ];
  }


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Constants.bgColor,
        disabledColor: Colors.grey,
        fontFamily: 'Futura'
      ),
      home: PersistentTabView(
        context,
        controller: _controller,
        navBarHeight: 60,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Constants.primaryColor, // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: const Offset(0, 2.0),
              blurRadius: 10.0,
              spreadRadius: 2.0,
            ),
          ],
          colorBehindNavBar: Constants.bgColor,
          borderRadius: BorderRadius.circular(0.0),
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties( // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style15, // Choose the nav bar style with this property.
      ),
    );
  }
}
