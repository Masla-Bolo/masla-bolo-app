import 'package:masla_bolo_app/domain/model/comments_json.dart';

import 'user_entity.dart';

class CommentsEntity {
  int? id;
  CommentsEntity? parent;
  String content;
  UserEntity? user;
  UserEntity? replyTo;
  int issueId;
  List<CommentsEntity> replies;

  CommentsEntity({
    this.id,
    this.parent,
    required this.content,
    this.user,
    this.replyTo,
    required this.issueId,
    this.replies = const [],
  });

  factory CommentsEntity.empty() => CommentsEntity(
        id: 0,
        content: '',
        user: UserEntity.empty(),
        replyTo: UserEntity.empty(),
        issueId: 0,
        replies: [],
      );

  Map<String, dynamic> toCommentJson() {
    return CommentsJson.copyWith(this).toJson();
  }
}
