import 'package:masla_bolo_app/navigation/app_navigation.dart';
import 'package:masla_bolo_app/navigation/route_name.dart';
import 'package:flutter/material.dart';

class NotificationNavigator {}

mixin NotificationRoute {
  void goToNotification() => navigation.push(context, RouteName.notification);
  AppNavigation get navigation;
  BuildContext get context;
}
