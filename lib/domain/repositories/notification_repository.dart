import 'package:dartz/dartz.dart';
import 'package:masla_bolo_app/domain/entities/notification_entity.dart';
import 'package:masla_bolo_app/domain/failures/notification_failure.dart';
import 'package:masla_bolo_app/domain/model/paginate.dart';

abstract class NotificationRepository {
  Future<Either<NotificationFailure, Paginate<NotificationEntity>>>
      getMyNotifications({
    String url = '/notifications/my/',
    List<NotificationEntity> previousNotifications,
  });
}
