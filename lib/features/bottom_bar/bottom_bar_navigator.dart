import 'package:masla_bolo_app/features/issue/issue_navigator.dart';
import 'package:masla_bolo_app/navigation/app_navigation.dart';
import 'package:masla_bolo_app/navigation/route_name.dart';
import 'package:flutter/material.dart';

class BottomBarNavigator with IssueRoute {
  @override
  final AppNavigation navigation;
  @override
  late BuildContext context;

  BottomBarNavigator(this.navigation);
}

mixin BottomBarRoute {
  void goToBottomBar() {
    navigation.pushReplacement(context, RouteName.bottomBar);
  }

  AppNavigation get navigation;
  BuildContext get context;
}
