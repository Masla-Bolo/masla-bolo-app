import 'package:flutter/widgets.dart';
import 'issue_detail_initial_params.dart';
import '../../../../../navigation/app_navigation.dart';
import '../../../../../navigation/route_name.dart';

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
