import 'package:masla_bolo_app/model/comments_json.dart';

import 'user_entity.dart';

class CommentsEntity {
  int id;
  String content;
  UserEntity user;
  UserEntity replyTo;
  int issueId;
  List<CommentsEntity> replies;

  CommentsEntity({
    required this.id,
    required this.content,
    required this.user,
    required this.replyTo,
    required this.issueId,
    required this.replies,
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
