import 'package:flutter/widgets.dart';
import 'package:masla_bolo_app/navigation/app_navigation.dart';
import 'package:masla_bolo_app/navigation/route_name.dart';

class IssueDetailNavigator {
  final AppNavigation navigation;
  late BuildContext context;
  IssueDetailNavigator(this.navigation);
}

mixin IssueDetailRoute {
  AppNavigation get navigation;
  BuildContext get context;

  void goToIssueDetail() => navigation.push(context, RouteName.issueDetail);
}
