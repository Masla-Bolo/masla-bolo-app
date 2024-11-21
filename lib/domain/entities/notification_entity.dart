import 'issue_entity.dart';

class NotificationEntity {
  String? title;
  String? description;
  String? image;
  bool isNew;
  IssueEntity? issue;
  DateTime? createdAt;
  String screen;
  Map<String, dynamic>? screenParams;

  NotificationEntity({
    this.description,
    this.image,
    this.screen = "",
    this.screenParams,
    this.isNew = false,
    this.title,
    this.issue,
    this.createdAt,
  });
}
