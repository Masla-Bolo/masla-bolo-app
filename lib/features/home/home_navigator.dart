import 'package:masla_bolo_app/features/issue/components/issue_detail/issue_detail_navigator.dart';
import 'package:masla_bolo_app/features/notification/notification_navigator.dart';
import 'package:masla_bolo_app/navigation/app_navigation.dart';
import 'package:masla_bolo_app/navigation/route_name.dart';
import 'package:flutter/widgets.dart';

class HomeNavigator with NotificationRoute, IssueDetailRoute {
  @override
  final AppNavigation navigation;
  @override
  late BuildContext context;

  HomeNavigator(this.navigation);
}

mixin HomeRoute {
  void goToHome() {
    navigation.push(context, RouteName.home);
  }

  AppNavigation get navigation;
  BuildContext get context;
}
