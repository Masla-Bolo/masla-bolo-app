import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:masla_bolo_app/service/app_service.dart';

class AppNavigation {
  static final navigatorKey = GlobalKey<NavigatorState>();
  static final context = navigatorKey.currentState!.context;
  void push(String routeName, {arguments}) {
    Navigator.pushNamed(
      context,
      routeName,
      arguments: arguments,
    );
  }

  pop() {
    Navigator.pop(navigatorKey.currentState!.context);
  }

  exitApp() {
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    getIt.popScope();
  }

  pushReplacement(String routeName, {arguments}) {
    Navigator.pushReplacementNamed(
      context,
      routeName,
      arguments: arguments,
    );
  }

  popAll(String routeName) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      routeName,
      ModalRoute.withName(routeName),
    );
  }
}
