import 'package:flutter/widgets.dart';
import 'package:masla_bolo_app/navigation/app_navigation.dart';
import 'package:masla_bolo_app/navigation/route_name.dart';

class IssueDetailNavigator {
  final AppNavigation navigation;
  late BuildContext context;
  pop() {
    navigation.pop();
  }

  IssueDetailNavigator(this.navigation);
}

mixin IssueDetailRoute {
  AppNavigation get navigation;

  void goToIssueDetail() => navigation.push(RouteName.issueDetail);
}
