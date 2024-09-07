import 'package:masla_bolo_app/features/bottom_bar/bottom_bar_navigator.dart';
import 'package:masla_bolo_app/navigation/app_navigation.dart';
import 'package:masla_bolo_app/navigation/route_name.dart';
import 'package:flutter/material.dart';

class AuthNavigator with BottomBarRoute {
  AuthNavigator(this.navigation);
  @override
  final AppNavigation navigation;
  @override
  late BuildContext context;
}

mixin AuthRoute {
  void goToLogin() {
    navigation.push(context, RouteName.login);
  }

  void goToRegister() {
    navigation.push(context, RouteName.register);
  }

  BuildContext get context;
  AppNavigation get navigation;
}
