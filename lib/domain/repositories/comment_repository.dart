import 'package:masla_bolo_app/domain/entities/comments_entity.dart';

abstract class CommentRepository {
  Future<List<CommentsEntity>> getComments({
    Map<String, dynamic>? params,
  });
  Future<CommentsEntity> createComment(
    CommentsEntity comment,
  );
  Future<CommentsEntity> updateComment(
    CommentsEntity comment,
  );

  Future<void> likeUnlikeComment(
    int commentId,
  );
  Future<bool> deleteComment(
    int commentId,
  );
}
