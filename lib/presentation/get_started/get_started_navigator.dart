import '../auth/auth_navigator.dart';
import '../bottom_bar/bottom_bar_navigator.dart';
import '../../navigation/app_navigation.dart';
import '../../navigation/route_name.dart';

class GetStartedNavigator with AuthRoute, BottomBarRoute {
  @override
  final AppNavigation navigation;

  GetStartedNavigator(this.navigation);

  exitApp() {
    navigation.exitApp();
  }
}

mixin GetStartedRoute {
  AppNavigation get navigation;

  goToGetStarted() => navigation.pushReplacement(RouteName.getStarted);
}
