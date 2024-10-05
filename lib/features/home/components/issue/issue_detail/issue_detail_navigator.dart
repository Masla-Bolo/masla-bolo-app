import 'package:flutter/widgets.dart';
import 'package:masla_bolo_app/features/home/components/issue/issue_detail/issue_detail_initial_params.dart';
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

  void goToIssueDetail(IssueDetailInitialParams params) =>
      navigation.push(RouteName.issueDetail, arguments: {"params": params});
}
