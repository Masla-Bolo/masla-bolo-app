import 'package:masla_bolo_app/presentation/di/module/issue_map_module.dart';
import 'package:masla_bolo_app/presentation/di/module/search_issue_module.dart';

import 'module/bottom_bar_module.dart';
import 'module/create_issue_module.dart';
import 'module/get_started_module.dart';
import 'module/home_module.dart';
import 'module/like_issue_module.dart';
import 'module/notification_module.dart';
import 'module/profile_module.dart';
import 'module/splash_module.dart';

import 'module/presentation_auth_module.dart';

class PresentationLayerInjection {
  static Future<void> configurePresentationLayerInjection() async {
    await BottomBarModule.configureBottomBarModuleInjection();
    await SplashModule.configureSplashModuleInjection();
    await PresentationAuthModule.configurePresentaionAuthModuleInjection();
    await GetStartedModule.configureGetStartedModuleInjection();
    await HomeModule.configureLikeHomeModuleInjection();
    await SearchIssueModule.configureSearchIssueModuleInjection();
    await IssueMapModule.configureIssueMapModuleInjection();
    await LikeIssueModule.configureLikeIssueModuleInjection();
    await CreateIssueModule.configureCreateIssueModuleInjection();
    await ProfileModule.configureProfileModuleInjection();
    await NotificationModule.configureNotificationModuleInjection();
  }
}
