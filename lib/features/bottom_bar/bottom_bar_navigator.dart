import 'package:masla_bolo_app/navigation/app_navigation.dart';
import 'package:masla_bolo_app/navigation/route_name.dart';
import 'package:flutter/material.dart';

class BottomBarNavigator {}

mixin BottomBarRoute {
  void goToBottomBar() {
    navigation.push(context, RouteName.bottomBar);
  }

  AppNavigation get navigation;
  BuildContext get context;
}
