import 'package:flutter/material.dart';
import 'package:greenhouses/screens/greenhouse_screen.dart';
import 'package:greenhouses/screens/lightning_screen.dart';
import 'package:greenhouses/screens/main_screen.dart';

class MainNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> _navigatorKey;

  MainNavigator(this._navigatorKey);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _navigatorKey,
      initialRoute: MainScreen.route,
      onGenerateRoute: (routeSettings) {
        return PageRouteBuilder(pageBuilder: (context, animation1, animation2) {
          if (routeSettings.name == MainScreen.route) {
            return MainScreen();
          } else if (routeSettings.name == GreenhouseScreen.route) {
            return GreenhouseScreen(routeSettings.arguments);
          } else if (routeSettings.name == LightningScreen.route) {
            return LightningScreen(routeSettings.arguments);
          } else {
            throw Exception('Uknown rout ${routeSettings.name}');
          }
        });
      },
    );
  }
}
