import 'package:masla_bolo_app/domain/repositories/issue_repository.dart';

import '../../../data/issue/api_issue_repository.dart';
import '../../../di/service_locator.dart';

class IssueModule {
  static Future<void> configureIssueModuleInjection() async {
    getIt.registerSingleton<IssueRepository>(
      ApiIssueRepository(
        getIt(),
        getIt(),
      ),
    );
  }
}
