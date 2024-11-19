import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../di/service_locator.dart';

class AppNavigation {
  static final navigatorKey = GlobalKey<NavigatorState>();
  static final context = navigatorKey.currentState!.context;
  void push(String routeName, {arguments}) {
    Navigator.restorablePushNamed(
      context,
      routeName,
      arguments: arguments,
    );
  }

  pop() {
    Navigator.pop(navigatorKey.currentState!.context);
  }

  exitApp() async {
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    await getIt.reset();
  }

  pushReplacement(String routeName, {arguments}) {
    Navigator.restorablePushReplacementNamed(
      context,
      routeName,
      arguments: arguments,
    );
  }

  popAll(String routeName) {
    getIt.reset().then((_) {
      ServiceLocator.configureServiceLocator();
    }).then((_) {
      if (context.mounted) {
        Navigator.restorablePushNamedAndRemoveUntil(
          context,
          routeName,
          (Route<dynamic> route) => false,
        );
      }
    });
  }
}
