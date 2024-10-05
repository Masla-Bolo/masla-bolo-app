import 'package:masla_bolo_app/navigation/route_name.dart';

import '../../../../navigation/app_navigation.dart';

class SettingsNavigator {
  final AppNavigation navigation;

  SettingsNavigator(this.navigation);

  void pop() {
    navigation.pop();
  }

  void popAll() {
    navigation.popAll(RouteName.login);
  }
}

mixin SettingsRoute {
  void goToSettings() => navigation.push(RouteName.settings);
  AppNavigation get navigation;
}
