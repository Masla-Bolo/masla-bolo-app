import 'package:masla_bolo_app/features/bottom_bar/bottom_bar_navigator.dart';
import 'package:masla_bolo_app/navigation/app_navigation.dart';
import 'package:masla_bolo_app/navigation/route_name.dart';
import 'package:flutter/material.dart';

class AuthNavigator with BottomBarRoute, AuthRoute {
  AuthNavigator(this.navigation);
  @override
  final AppNavigation navigation;
  @override
  late BuildContext context;

  pop() {
    navigation.pop(context);
  }
}

mixin AuthRoute {
  void goToLogin() {
    navigation.pushReplacement(context, RouteName.login);
  }

  void goToRegister() {
    navigation.pushReplacement(context, RouteName.register);
  }

  BuildContext get context;
  AppNavigation get navigation;
}
