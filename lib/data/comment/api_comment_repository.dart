import 'package:dartz/dartz.dart';
import 'package:masla_bolo_app/domain/entities/comments_entity.dart';
import 'package:masla_bolo_app/domain/failures/comment_failure.dart';
import 'package:masla_bolo_app/domain/repositories/comment_repository.dart';
import 'package:masla_bolo_app/model/comments_json.dart';

import '../../helpers/helpers.dart';
import '../../network/network_repository.dart';

class ApiCommentRepository implements CommentRepository {
  final NetworkRepository networkRepository;
  ApiCommentRepository(this.networkRepository);

  @override
  Future<Either<CommentFailure, CommentsEntity>> createComment(
    CommentsEntity comment,
  ) async {
    final response = await networkRepository.get(url: '/comments/');
    return response.fold((failure) {
      return left(CommentFailure(error: failure.error));
    }, (success) {
      final data = CommentsJson.fromJson(success).toDomain();
      return right(data);
    });
  }

  @override
  Future<Either<CommentFailure, bool>> deleteComment(String commentId) async {
    final response = await networkRepository.get(url: '/comments/$commentId');
    return response.fold((failure) {
      return left(CommentFailure(error: failure.error));
    }, (success) {
      return right(true);
    });
  }

  @override
  Future<Either<CommentFailure, List<CommentsEntity>>> getComments({
    Map<String, dynamic>? params,
  }) async {
    final response = await networkRepository.get(
      url: '/comments/',
      extraQuery: params,
    );
    return response.fold((failure) {
      return left(CommentFailure(error: failure.error));
    }, (success) {
      final data = parseList(success, CommentsJson.fromJson)
          .map((json) => json.toDomain())
          .toList();
      return right(data);
    });
  }

  @override
  Future<Either<CommentFailure, CommentsEntity>> likeUnlikeComment(
      String commentId) async {
    final response =
        await networkRepository.get(url: '/comments/$commentId/like');
    return response.fold((failure) {
      return left(CommentFailure(error: failure.error));
    }, (success) {
      final data = CommentsJson.fromJson(success).toDomain();
      return right(data);
    });
  }

  @override
  Future<Either<CommentFailure, CommentsEntity>> updateComment(
      CommentsEntity comment) async {
    final response =
        await networkRepository.get(url: '/comments/${comment.id}');
    return response.fold((failure) {
      return left(CommentFailure(error: failure.error));
    }, (success) {
      final data = CommentsJson.fromJson(success).toDomain();
      return right(data);
    });
  }
}
