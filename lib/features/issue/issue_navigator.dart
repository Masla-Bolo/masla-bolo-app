import 'package:flutter/widgets.dart';
import 'package:masla_bolo_app/navigation/app_navigation.dart';
import 'package:masla_bolo_app/navigation/route_name.dart';

class IssueNavigator {
  final AppNavigation navigation;
  late BuildContext context;
  IssueNavigator(this.navigation);
}

mixin IssueRoute {
  AppNavigation get navigation;
  BuildContext get context;

  void goToIssue() => navigation.push(context, RouteName.issue);
}
