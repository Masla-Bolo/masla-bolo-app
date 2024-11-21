import 'package:dartz/dartz.dart';
import 'package:masla_bolo_app/domain/entities/notification_entity.dart';
import 'package:masla_bolo_app/domain/failures/notification_failure.dart';
import 'package:masla_bolo_app/domain/model/notification_json.dart';
import 'package:masla_bolo_app/domain/model/paginate.dart';
import 'package:masla_bolo_app/domain/repositories/notification_repository.dart';
import 'package:masla_bolo_app/network/network_repository.dart';

class ApiNotificationRepository extends NotificationRepository {
  NetworkRepository networkRepository;
  ApiNotificationRepository(this.networkRepository);

  @override
  Future<Either<NotificationFailure, Paginate<NotificationEntity>>>
      getMyNotifications({
    String url = '/notifications/my/',
    List<NotificationEntity> previousNotifications = const [],
  }) async {
    final response = await networkRepository.get(url: url);
    if (response.failed) {
      return left(NotificationFailure(error: response.message));
    }
    final pagination = Paginate<NotificationEntity>.fromJson(
      response.data,
      NotificationJson.fromJson,
    );
    if (previousNotifications.isNotEmpty) {
      previousNotifications.addAll(pagination.results);
    } else {
      previousNotifications = pagination.results;
    }
    return right(pagination.copyWith(results: previousNotifications));
  }
}
