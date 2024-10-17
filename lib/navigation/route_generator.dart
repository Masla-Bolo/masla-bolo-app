// ignore_for_file: unused_local_variable

import 'package:masla_bolo_app/features/auth/sign_up/sign_up_screen.dart';
import 'package:masla_bolo_app/features/bottom_bar/bottom_bar.dart';
import 'package:masla_bolo_app/features/like_issue/like_issue_page.dart';
import 'package:masla_bolo_app/features/get_started/get_started_screen.dart';
import 'package:masla_bolo_app/features/home/components/issue/issue_detail/issue_detail.dart';
import 'package:masla_bolo_app/features/add_issue/create_issue_screen.dart';
import 'package:masla_bolo_app/features/notification/notification_page.dart';
import 'package:masla_bolo_app/features/profile/components/settings/settings_page.dart';
import 'package:masla_bolo_app/features/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:masla_bolo_app/navigation/route_name.dart';

import '../di/service_locator.dart';
import '../features/auth/login/login_screen.dart';
import '../features/home/home_screen.dart';
import '../features/splash/splash_screen.dart';

enum TransitionType {
  fade,
  slide,
}

Route<dynamic> generateRoute(RouteSettings settings) {
  final args =
      (settings.arguments ?? <String, dynamic>{}) as Map<String, dynamic>;

  switch (settings.name) {
    case RouteName.splash:
      return getRoute(const SplashScreen(), TransitionType.fade);

    case RouteName.login:
      return getRoute(const LoginScreen(), TransitionType.fade);

    case RouteName.bottomBar:
      return getRoute(const BottomBar(), TransitionType.fade);

    case RouteName.register:
      return getRoute(const SignUpScreen(), TransitionType.fade);

    case RouteName.profile:
      return getRoute(const ProfileScreen(), TransitionType.fade);

    case RouteName.home:
      return getRoute(const HomeScreen(), TransitionType.slide);

    case RouteName.notification:
      return getRoute(const NotificationPage(), TransitionType.fade);

    case RouteName.likeIssue:
      return getRoute(const LikeIssuePage(), TransitionType.fade);

    case RouteName.issue:
      return getRoute(const CreateIssueScreen(), TransitionType.fade);

    case RouteName.issueDetail:
      return getRoute(
          IssueDetail(
            cubit: getIt(
              param1: args["params"],
            ),
          ),
          TransitionType.slide);

    case RouteName.getStarted:
      return getRoute(const GetStartedScreen(), TransitionType.fade);

    case RouteName.settings:
      return getRoute(const SettingsPage(), TransitionType.slide);

    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: Center(child: Text('PAGE NOT FOUND!!')),
        ),
      );
  }
}

PageRouteBuilder getRoute(Widget page, TransitionType transitionType) {
  return PageRouteBuilder(
    pageBuilder: (_, __, ___) => page,
    transitionDuration: const Duration(milliseconds: 300),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      switch (transitionType) {
        case TransitionType.fade:
          return FadeTransition(opacity: animation, child: child);
        case TransitionType.slide:
          const begin = Offset(1, 0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
      }
    },
  );
}
