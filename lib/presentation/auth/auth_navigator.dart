import '../bottom_bar/bottom_bar_navigator.dart';
import '../get_started/get_started_navigator.dart';
import '../../navigation/app_navigation.dart';
import '../../navigation/route_name.dart';

class AuthNavigator with BottomBarRoute, AuthRoute, GetStartedRoute {
  AuthNavigator(this.navigation);
  @override
  final AppNavigation navigation;

  pop() {
    navigation.pop();
  }
}

mixin AuthRoute {
  void goToLogin() {
    navigation.pushReplacement(RouteName.login);
  }

  void goToRegister() {
    navigation.pushReplacement(RouteName.register);
  }

  AppNavigation get navigation;
}
