import 'package:masla_bolo_app/domain/entities/user_entity.dart';
import 'package:masla_bolo_app/helpers/helpers.dart';
import 'package:masla_bolo_app/domain/model/user_json.dart';

import '../entities/comments_entity.dart';

class CommentsJson {
  int id;
  CommentsEntity? parentId;
  String content;
  UserEntity user;
  bool isLiked;
  UserEntity? replyTo;
  int issueId;
  List<CommentsEntity> replies;

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
        // parentId: CommentsJson.fromJson(json["parent"]).toDomain(),
        content: json['content'],
        user: UserJson.fromData(json['user']).toDomain(),
        replyTo: json['reply_to'],
        issueId: json['issue'],
        replies: parseList(json["replies"], CommentsJson.fromJson)
            .map((json) => json.toDomain())
            .toList(),
      );

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
      'replyTo': replyTo,
      "paren_id": parentId,
      'issueId': issueId,
    };
  }
}
