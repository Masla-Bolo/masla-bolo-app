import 'package:masla_bolo_app/domain/repositories/notification_repository.dart';

import '../../../data/notification/api_notification_repository.dart';
import '../../../di/service_locator.dart';

class NotificationModule {
  static Future<void> configureNotificationModuleInjection() async {
    getIt.registerSingleton<NotificationRepository>(
      ApiNotificationRepository(
        getIt(),
      ),
    );
  }
}
