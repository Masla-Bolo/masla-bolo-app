import 'package:masla_bolo_app/features/auth/auth_navigator.dart';
import 'package:masla_bolo_app/features/bottom_bar/bottom_bar_navigator.dart';
import 'package:masla_bolo_app/features/get_started/get_started_navigator.dart';
import 'package:masla_bolo_app/navigation/app_navigation.dart';
import 'package:flutter/material.dart';

class SplashNavigator with AuthRoute, BottomBarRoute, GetStartedRoute {
  SplashNavigator(this.navigation);
  @override
  AppNavigation navigation;
  @override
  late BuildContext context;
}
