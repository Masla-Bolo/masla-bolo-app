import 'package:flutter/material.dart';

class AppNavigation {
  static final navigatorKey = GlobalKey<NavigatorState>();
  void push(BuildContext context, String routeName, {arguments}) {
    Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  pop(BuildContext context) {
    Navigator.pop(context);
  }

  pushReplacement(BuildContext context, String routeName, {arguments}) {
    Navigator.pushReplacementNamed(context, routeName, arguments: arguments);
  }

  popAll(BuildContext context, String routeName) {
    Navigator.popUntil(context, ModalRoute.withName(routeName));
  }
}
