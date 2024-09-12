import 'package:flutter/material.dart';

class AppNavigation {
  static final navigatorKey = GlobalKey<NavigatorState>();

  void push(String routeName, {arguments}) {
    Navigator.pushNamed(navigatorKey.currentState!.context, routeName,
        arguments: arguments);
  }

  pop() {
    Navigator.pop(navigatorKey.currentState!.context);
  }

  pushReplacement(String routeName, {arguments}) {
    Navigator.pushReplacementNamed(
        navigatorKey.currentState!.context, routeName,
        arguments: arguments);
  }

  popAll(String routeName) {
    Navigator.popUntil(
        navigatorKey.currentState!.context, ModalRoute.withName(routeName));
  }
}
