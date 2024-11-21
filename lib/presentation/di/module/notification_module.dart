import '../../../di/service_locator.dart';
import '../../notification/notification_cubit.dart';
import '../../notification/notification_navigator.dart';

class NotificationModule {
  static Future<void> configureNotificationModuleInjection() async {
    getIt.registerSingleton<NotificationNavigator>(
        NotificationNavigator(getIt()));
    getIt.registerSingleton<NotificationCubit>(NotificationCubit(
      getIt(),
      getIt(),
    ));
  }
}
