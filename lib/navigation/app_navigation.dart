import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppNavigation {
  static final navigatorKey = GlobalKey<NavigatorState>();

  void push(String routeName, {arguments}) {
    Navigator.pushNamed(
      navigatorKey.currentState!.context,
      routeName,
      arguments: arguments,
    );
  }

  pop() {
    Navigator.pop(navigatorKey.currentState!.context);
  }

  exitApp() {
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }

  pushReplacement(String routeName, {arguments}) {
    Navigator.pushReplacementNamed(
      navigatorKey.currentState!.context,
      routeName,
      arguments: arguments,
    );
  }

  popAll(String routeName) {
    Navigator.pushNamedAndRemoveUntil(
      navigatorKey.currentState!.context,
      routeName,
      ModalRoute.withName(routeName),
    );
  }
}
