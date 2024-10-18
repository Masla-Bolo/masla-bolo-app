import '../home/components/issue/issue_detail/issue_detail_navigator.dart';
import 'components/settings/settings_navigator.dart';
import '../../navigation/app_navigation.dart';
import '../../navigation/route_name.dart';

class ProfileNavigator with SettingsRoute, IssueDetailRoute {
  @override
  final AppNavigation navigation;
  pop() {
    navigation.pop();
  }

  void goToEditProfile() => navigation.push(RouteName.editProfile);

  ProfileNavigator(this.navigation);
}

mixin ProfileRoute {
  void goToProfile() => navigation.push(RouteName.profile);

  AppNavigation get navigation;
}
