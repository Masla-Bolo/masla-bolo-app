import '../../domain/entities/comments_entity.dart';
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
  Future<CommentsEntity> createComment(
    CommentsEntity comment,
  ) async {
    final response = await networkRepository.post(
      url: '/comments/',
      data: comment.toCommentJson(),
    );
    final data = CommentsJson.fromJson(response.data).toDomain();
    return data;
  }

  @override
  Future<bool> deleteComment(int commentId) async {
    await networkRepository.get(url: '/comments/$commentId/');
    return true;
  }

  @override
  Future<List<CommentsEntity>> getComments({
    Map<String, dynamic>? params,
  }) async {
    final response = await networkRepository.get(
      url: '/comments/',
      extraQuery: params,
    );
    final data = parseList(response.data["results"], CommentsJson.fromJson)
        .map((json) => json.toDomain())
        .toList();
    return data;
  }

  @override
  Future<void> likeUnlikeComment(int commentId) async {
    utilityService.addOrRemoveFromQueue(
      commentId,
      () => networkRepository.post(url: '/comments/$commentId/like/'),
    );
  }

  @override
  Future<CommentsEntity> updateComment(CommentsEntity comment) async {
    final response = await networkRepository.put(
      url: '/comments/${comment.id}/',
      data: comment.toCommentJson(),
    );
    final data = CommentsJson.fromJson(response.data).toDomain();
    return data;
  }
}
