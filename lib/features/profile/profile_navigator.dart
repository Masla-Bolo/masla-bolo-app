import 'package:masla_bolo_app/navigation/app_navigation.dart';
import 'package:masla_bolo_app/navigation/route_name.dart';
import 'package:flutter/material.dart';

class ProfileNavigator {
  final AppNavigation navigation;
  late BuildContext context;
  pop() {
    navigation.pop(context);
  }

  ProfileNavigator(this.navigation);
}

mixin ProfileRoute {
  void goToProfile() => navigation.push(context, RouteName.profile);
  AppNavigation get navigation;
  BuildContext get context;
}
