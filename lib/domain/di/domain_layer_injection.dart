import 'module/auth_module.dart';
import 'module/comment_module.dart';
import 'module/issue_module.dart';
import 'module/notification_module.dart';
import 'module/store_module.dart';
import 'module/user_module.dart';

class DomainLayerInjection {
  static Future<void> configureDataLayerInjection() async {
    await StoreModule.configureStoreModuleInjection();
    await AuthModule.configureAuthModuleInjection();
    await UserModule.configureUserModuleInjection();
    await CommentModule.configureCommentModuleInjection();
    await IssueModule.configureIssueModuleInjection();
    await NotificationModule.configureNotificationModuleInjection();
  }
}
