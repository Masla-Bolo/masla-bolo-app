import 'package:masla_bolo_app/features/auth/register/resgister_screen.dart';
import 'package:masla_bolo_app/features/bottom_bar/bottom_bar.dart';
import 'package:masla_bolo_app/features/issue/components/issue_detail/issue_detail.dart';
import 'package:masla_bolo_app/features/issue/issue_screen.dart';
import 'package:masla_bolo_app/features/notification/notification_page.dart';
import 'package:masla_bolo_app/features/profile/profile_screen.dart';
import 'package:masla_bolo_app/main.dart';
import 'package:flutter/material.dart';
import 'package:masla_bolo_app/navigation/route_name.dart';

import '../features/auth/login/login_screen.dart';
import '../features/home/home_screen.dart';
import '../features/splash/splash_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  // final args =
  //     (settings.arguments ?? <String, dynamic>{}) as Map<String, dynamic>;
  switch (settings.name) {
    case RouteName.splash:
      return getRoute(SplashScreen(
        cubit: getIt(),
      ));

    case RouteName.login:
      return getRoute(LoginScreen(
        cubit: getIt(),
      ));

    case RouteName.bottomBar:
      return getRoute(BottomBar(
        cubit: getIt(),
      ));

    case RouteName.register:
      return getRoute(const ResgisterScreen());

    case RouteName.profile:
      return getRoute(const ProfileScreen());

    case RouteName.home:
      return getRoute(HomeScreen(cubit: getIt()));

    case RouteName.notification:
      return getRoute(const NotificationPage());

    case RouteName.issue:
      return getRoute(IssueScreen(cubit: getIt()));

    case RouteName.issueDetail:
      return getRoute(IssueDetail(cubit: getIt()));

    case RouteName.settings:
      return getRoute(const ProfileScreen());
    default:
      return MaterialPageRoute(
          builder: (context) => const Scaffold(
                body: Center(
                  child: Text('PAGE NOT FOUND!!'),
                ),
              ));
  }
}

PageRouteBuilder getRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (_, __, ___) => page,
    transitionDuration: const Duration(milliseconds: 300),
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(
      opacity: animation,
      child: child,
    ),
  );
}
