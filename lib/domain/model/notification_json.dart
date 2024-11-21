import 'package:masla_bolo_app/domain/entities/issue_entity.dart';
import 'package:masla_bolo_app/domain/entities/notification_entity.dart';
import 'package:masla_bolo_app/domain/model/issue_json.dart';
import 'package:masla_bolo_app/service/notification_service.dart';

class NotificationJson {
  String? title;
  String? description;
  String? image;
  DateTime? createdAt;
  IssueEntity? issue;
  String screen;
  Map<String, dynamic>? screenParams;

  NotificationJson({
    this.screenParams,
    required this.screen,
    this.description,
    this.image,
    this.issue,
    this.title,
    this.createdAt,
  });

  factory NotificationJson.fromJson(Map<String, dynamic> json) =>
      NotificationJson(
        title: json["title"],
        screen: NotificationService.getScreenType(json).$1,
        screenParams: NotificationService.getScreenType(json).$2,
        description: json["description"],
        image: json["image"],
        issue: json["data"] != null
            ? IssueJson.fromJson(json["data"]).toDomain()
            : null,
        createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      );

  NotificationEntity toDomain() => NotificationEntity(
        title: title,
        issue: issue,
        screen: screen,
        screenParams: screenParams,
        description: description,
        image: image,
        createdAt: createdAt,
      );
}
