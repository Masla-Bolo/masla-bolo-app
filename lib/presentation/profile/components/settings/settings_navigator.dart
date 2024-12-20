import '../../../../navigation/route_name.dart';

import '../../../../navigation/app_navigation.dart';

class SettingsNavigator {
  final AppNavigation navigation;

  SettingsNavigator(this.navigation);

  void pop() {
    navigation.pop();
  }

  void push(String routeName) => navigation.push(routeName);

  void popAll() {
    navigation.popAll(RouteName.login);
  }
}

mixin SettingsRoute {
  void goToSettings() => navigation.push(RouteName.settings);
  AppNavigation get navigation;
}
