import 'package:dartz/dartz.dart';

import '../../domain/entities/comments_entity.dart';
import '../../domain/failures/comment_failure.dart';
import '../../domain/repositories/comment_repository.dart';
import '../../domain/model/comments_json.dart';
import '../../service/utility_service.dart';

import '../../helpers/helpers.dart';
import '../../network/network_repository.dart';

class ApiCommentRepository implements CommentRepository {
  final NetworkRepository networkRepository;
  final UtilityService utilityService;
  ApiCommentRepository(this.networkRepository, this.utilityService);

  @override
  Future<Either<CommentFailure, CommentsEntity>> createComment(
    CommentsEntity comment,
  ) async {
    final response = await networkRepository.post(
      url: '/comments/',
      data: comment.toCommentJson(),
    );
    if (response.failed) {
      return Left(CommentFailure(error: response.message));
    }
    final data = CommentsJson.fromJson(response.data).toDomain();
    return right(data);
  }

  @override
  Future<Either<CommentFailure, bool>> deleteComment(int commentId) async {
    final response = await networkRepository.get(url: '/comments/$commentId/');
    return response.failed
        ? left(CommentFailure(error: response.message))
        : right(true);
  }

  @override
  Future<Either<CommentFailure, List<CommentsEntity>>> getComments({
    Map<String, dynamic>? params,
  }) async {
    final response = await networkRepository.get(
      url: '/comments/',
      extraQuery: params,
    );
    if (response.failed) {
      return Left(CommentFailure(error: response.message));
    }
    final data = parseList(response.data["results"], CommentsJson.fromJson)
        .map((json) => json.toDomain())
        .toList();
    return right(data);
  }

  @override
  Future<Either<CommentFailure, void>> likeUnlikeComment(int commentId) async {
    utilityService.addOrRemoveFromQueue(
      commentId,
      () => networkRepository.post(url: '/comments/$commentId/like/'),
    );
    return right(null);
  }

  @override
  Future<Either<CommentFailure, CommentsEntity>> updateComment(
      CommentsEntity comment) async {
    final response = await networkRepository.put(
      url: '/comments/${comment.id}/',
      data: comment.toCommentJson(),
    );
    if (response.failed) {
      return Left(CommentFailure(error: response.message));
    }
    final data = CommentsJson.fromJson(response.data).toDomain();
    return right(data);
  }
}
