import 'package:masla_bolo_app/domain/entities/user_entity.dart';
import 'package:masla_bolo_app/helpers/helpers.dart';
import 'package:masla_bolo_app/model/user_json.dart';

import '../domain/entities/comments_entity.dart';

class CommentsJson {
  String id;
  String content;
  UserEntity user;
  UserEntity replyTo;
  int issueId;
  List<CommentsEntity> replies;

  CommentsJson({
    required this.id,
    required this.content,
    required this.user,
    required this.replyTo,
    required this.issueId,
    required this.replies,
  });

  factory CommentsJson.copyWith(CommentsEntity entity) => CommentsJson(
        id: entity.id,
        content: entity.content,
        user: entity.user,
        replyTo: entity.replyTo,
        issueId: entity.issueId,
        replies: entity.replies,
      );

  factory CommentsJson.fromJson(Map<String, dynamic> json) => CommentsJson(
        id: json['id'],
        content: json['content'],
        user: UserJson.fromData(json['user']).toDomain(),
        replyTo: UserJson.fromData(json['replyTo']).toDomain(),
        issueId: json['issueId'],
        replies: parseList(json["replies"], CommentsJson.fromJson)
            .map((json) => json.toDomain())
            .toList(),
      );

  CommentsEntity toDomain() => CommentsEntity(
        id: id,
        content: content,
        user: user,
        replyTo: replyTo,
        issueId: issueId,
        replies: replies,
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'user': user.id,
      'replyTo': replyTo.id,
      'issueId': issueId,
    };
  }
}
