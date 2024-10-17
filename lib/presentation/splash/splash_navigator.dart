import '../auth/auth_navigator.dart';
import '../bottom_bar/bottom_bar_navigator.dart';
import '../get_started/get_started_navigator.dart';
import '../../navigation/app_navigation.dart';

class SplashNavigator with AuthRoute, BottomBarRoute, GetStartedRoute {
  SplashNavigator(this.navigation);
  @override
  AppNavigation navigation;
}
