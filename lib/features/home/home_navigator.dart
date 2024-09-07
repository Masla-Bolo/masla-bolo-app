import 'package:masla_bolo_app/navigation/app_navigation.dart';
import 'package:masla_bolo_app/navigation/route_name.dart';
import 'package:flutter/widgets.dart';

class HomeNavigator {}

mixin HomeRoute {
  void goToHome() {
    navigation.push(context, RouteName.home);
  }

  AppNavigation get navigation;
  BuildContext get context;
}
