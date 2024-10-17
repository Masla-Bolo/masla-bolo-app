import 'package:masla_bolo_app/domain/di/module/auth_module.dart';
import 'package:masla_bolo_app/domain/di/module/comment_module.dart';
import 'package:masla_bolo_app/domain/di/module/issue_module.dart';
import 'package:masla_bolo_app/domain/di/module/store_module.dart';

class DomainLayerInjection {
  static Future<void> configureDataLayerInjection() async {
    await StoreModule.configureStoreModuleInjection();
    await AuthModule.configureAuthModuleInjection();
    await CommentModule.configureCommentModuleInjection();
    await IssueModule.configureIssueModuleInjection();
  }
}
