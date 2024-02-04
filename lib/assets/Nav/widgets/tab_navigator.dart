import 'package:flutter/material.dart';
import 'package:fluttertest/LoginScreen/Login_Screen.dart';
import 'package:fluttertest/Screens/Screen.dart';
import 'package:fluttertest/assets/buttom_nav_item.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

String? firstPage;
var getPages = <GetPage<dynamic>>[
  GetPage(name: '/profileScreen', page: () => userScreen()),
  GetPage(name: '/authen', page: () => LoginSceen()),
];

class TabNavigator extends StatelessWidget {
  static const String TabNavigatorRoot = '/';

  final GlobalKey<NavigatorState> navigatorKey;
  final ButtomNavItem item;

  const TabNavigator(
      {super.key,
      required this.navigatorKey,
      required this.item,
      GlobalKey<NavigatorState>? navigatorKeys});

  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilders();
    return Navigator(
      key: navigatorKey,
      initialRoute: TabNavigatorRoot,
      onGenerateInitialRoutes: (_, initialRoute) {
        return [
          MaterialPageRoute(
            settings: RouteSettings(name: TabNavigatorRoot),
            builder: (context) => routeBuilders[initialRoute]!(context),
          )
        ];
      },
    );
  }

  Map<String, WidgetBuilder> _routeBuilders() {
    return {TabNavigatorRoot: (context) => _getScreen(context, item)};
  }

  Widget _getScreen(BuildContext context, ButtomNavItem item) {
    switch (item) {
      case ButtomNavItem.feed:
        return homeScreens(
          userID: null,
          firstName: null,
          lastName: null,
        );
      case ButtomNavItem.reserve:
        return reserveScreen();
      // case ButtomNavItem.sale:
      //   return saleScreen();
      case ButtomNavItem.notifications:
        return notificationScreen();
      case ButtomNavItem.porfile:
        return userScreen();
      default:
        return Scaffold();
    }
  }
}
