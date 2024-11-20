import 'package:masla_bolo_app/navigation/route_name.dart';
import 'package:masla_bolo_app/presentation/home/components/issue/issue_detail/issue_detail_navigator.dart';

import '../../navigation/app_navigation.dart';

class SearchIssueNavigator with IssueDetailRoute {
  @override
  final AppNavigation navigation;
  SearchIssueNavigator(this.navigation);

  void goToSearchIssueFilter() {
    navigation.push(RouteName.searchIssueFilter);
  }

  void pop() => navigation.pop();
}

mixin SearchIssueRoute {
  void goToSearchIssue() {
    navigation.push(RouteName.searchIssue);
  }

  AppNavigation get navigation;
}
