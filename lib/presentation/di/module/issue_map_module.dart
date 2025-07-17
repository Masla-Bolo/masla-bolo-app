import 'package:masla_bolo_app/presentation/issue_map/issue_map_cubit.dart';
import 'package:masla_bolo_app/presentation/issue_map/issue_map_navigator.dart';

import '../../../di/service_locator.dart';

class IssueMapModule {
  static Future<void> configureIssueMapModuleInjection() async {
    getIt.registerSingleton<IssueMapNavigator>(
      IssueMapNavigator(getIt()),
    );
    getIt.registerSingleton<IssueMapCubit>(
      IssueMapCubit(getIt(), getIt()),
    );
  }
}
