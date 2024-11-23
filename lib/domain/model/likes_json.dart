import 'package:masla_bolo_app/domain/model/base_model.dart';

import '../entities/comments_entity.dart';
import '../entities/issue_entity.dart';
import '../entities/likes_entity.dart';
import '../entities/user_entity.dart';
import 'comments_json.dart';
import 'issue_json.dart';
import 'user_json.dart';

class LikesJson implements BaseModel<LikesEntity> {
  UserEntity user;
  CommentsEntity comment;
  IssueEntity issue;

  LikesJson({
    required this.comment,
    required this.issue,
    required this.user,
  });

  factory LikesJson.copyWith(LikesEntity entity) => LikesJson(
        comment: entity.comment,
        issue: entity.issue,
        user: entity.user,
      );

  factory LikesJson.fromJson(Map<String, dynamic> json) => LikesJson(
        comment: CommentsJson.fromJson(json['comment']).toDomain(),
        issue: IssueJson.fromJson(json['issue']).toDomain(),
        user: UserJson.fromData(json['user']).toDomain(),
      );

  @override
  LikesEntity toDomain() => LikesEntity(
        comment: comment,
        user: user,
        issue: issue,
      );

  Map<String, dynamic> toLikeCommentJson() {
    return {
      'comment': comment.id,
      'user': user.id,
    };
  }

  Map<String, dynamic> toLikeIssueJson() {
    return {
      'issue': issue.id,
      'user': user.id,
    };
  }
}
