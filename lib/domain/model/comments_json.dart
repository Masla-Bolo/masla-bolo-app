import 'package:masla_bolo_app/domain/model/base_model.dart';

import '../entities/user_entity.dart';
import '../../helpers/helpers.dart';
import 'user_json.dart';

import '../entities/comments_entity.dart';

class CommentsJson implements BaseModel<CommentsEntity> {
  int id;
  String content;
  UserEntity user;
  bool isLiked;
  int? parentId;
  int? replyTo;
  int issueId;
  List<CommentsEntity>? replies;

  CommentsJson({
    this.parentId,
    this.isLiked = false,
    required this.id,
    required this.content,
    required this.user,
    required this.replyTo,
    required this.issueId,
    required this.replies,
  });

  factory CommentsJson.copyWith(CommentsEntity entity) => CommentsJson(
        id: entity.id ?? 0,
        content: entity.content,
        isLiked: entity.isLiked,
        parentId: entity.parent,
        user: entity.user ?? UserEntity.empty(),
        replyTo: entity.replyTo,
        issueId: entity.issueId,
        replies: entity.replies,
      );

  factory CommentsJson.fromJson(Map<String, dynamic> json) => CommentsJson(
        id: json['id'],
        isLiked: json["is_liked"],
        parentId: json["parent"],
        content: json['content'],
        user: UserJson.fromData(json['user']).toDomain(),
        replyTo: json['reply_to'],
        issueId: json['issue'],
        replies: parseList(json["replies"], CommentsJson.fromJson)
            .map((json) => json.toDomain())
            .toList(),
      );

  @override
  CommentsEntity toDomain() => CommentsEntity(
        id: id,
        content: content,
        user: user,
        parent: parentId,
        isLiked: isLiked,
        replyTo: replyTo,
        issueId: issueId,
        replies: replies,
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'user': user.id,
      'reply_to': replyTo,
      "parent": parentId,
      'issueId': issueId,
    };
  }
}
