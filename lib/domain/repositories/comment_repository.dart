import 'package:dartz/dartz.dart';
import 'package:masla_bolo_app/domain/failures/comment_failure.dart';

import '../entities/comments_entity.dart';

abstract class CommentRepository {
  Future<Either<CommentFailure, List<CommentsEntity>>> getComments({
    Map<String, dynamic>? params,
  });
  Future<Either<CommentFailure, CommentsEntity>> createComment(
    CommentsEntity comment,
  );
  Future<Either<CommentFailure, CommentsEntity>> updateComment(
    CommentsEntity comment,
  );

  Future<Either<CommentFailure, void>> likeUnlikeComment(
    int commentId,
  );
  Future<Either<CommentFailure, bool>> deleteComment(
    int commentId,
  );
}
