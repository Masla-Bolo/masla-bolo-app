import 'package:masla_bolo_app/domain/model/comments_json.dart';

import 'user_entity.dart';

class CommentsEntity {
  int? id;
  String content;
  UserEntity? user;
  int? replyTo;
  int issueId;
  List<CommentsEntity> replies;

  CommentsEntity({
    this.id,
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
        replyTo: 0,
        issueId: 0,
        replies: [],
      );

  Map<String, dynamic> toCommentJson() {
    return CommentsJson.copyWith(this).toJson();
  }
}
