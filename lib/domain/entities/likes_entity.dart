import '../../model/likes_json.dart';
import 'comments_entity.dart';
import 'issue_entity.dart';
import 'user_entity.dart';

class LikesEntity {
  UserEntity user;
  CommentsEntity comment;
  IssueEntity issue;

  LikesEntity({
    required this.comment,
    required this.issue,
    required this.user,
  });

  factory LikesEntity.empty() => LikesEntity(
        user: UserEntity.empty(),
        comment: CommentsEntity.empty(),
        issue: IssueEntity.empty(),
      );

  Map<String, dynamic> toLikeCommentJson() {
    return LikesJson.copyWith(this).toLikeCommentJson();
  }

  Map<String, dynamic> toLikeIssueJson() {
    return LikesJson.copyWith(this).toLikeIssueJson();
  }
}
