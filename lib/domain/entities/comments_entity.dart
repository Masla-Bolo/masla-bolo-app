import '../model/comments_json.dart';

import 'user_entity.dart';

class CommentsEntity {
  int? id;
  bool isLiked;
  int? parent;
  int? replyTo;
  String content;
  UserEntity? user;
  int issueId;
  List<CommentsEntity> replies;
  bool showReplies;

  CommentsEntity({
    this.id,
    this.showReplies = false,
    this.parent,
    this.isLiked = false,
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
        replyTo: null,
        isLiked: false,
        issueId: 0,
        replies: [],
        parent: null,
      );

  Map<String, dynamic> toCommentJson() {
    return CommentsJson.copyWith(this).toJson();
  }
}
