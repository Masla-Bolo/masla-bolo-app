import 'package:masla_bolo_app/features/profile/components/settings/settings_navigator.dart';
import 'package:masla_bolo_app/navigation/app_navigation.dart';
import 'package:masla_bolo_app/navigation/route_name.dart';

class ProfileNavigator with SettingsRoute {
  @override
  final AppNavigation navigation;
  pop() {
    navigation.pop();
  }

  ProfileNavigator(this.navigation);
}

mixin ProfileRoute {
  void goToProfile() => navigation.push(RouteName.profile);
  AppNavigation get navigation;
}
