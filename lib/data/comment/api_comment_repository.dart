import 'package:masla_bolo_app/domain/entities/comments_entity.dart';
import 'package:masla_bolo_app/domain/repositories/comment_repository.dart';
import 'package:masla_bolo_app/domain/model/comments_json.dart';

import '../../helpers/helpers.dart';
import '../../network/network_repository.dart';

class ApiCommentRepository implements CommentRepository {
  final NetworkRepository networkRepository;
  ApiCommentRepository(this.networkRepository);

  @override
  Future<CommentsEntity> createComment(
    CommentsEntity comment,
  ) async {
    final response = await networkRepository.get(url: '/comments/');
    final data = CommentsJson.fromJson(response.data).toDomain();
    return data;
  }

  @override
  Future<bool> deleteComment(String commentId) async {
    await networkRepository.get(url: '/comments/$commentId');
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
    final data = parseList(response.data, CommentsJson.fromJson)
        .map((json) => json.toDomain())
        .toList();
    return data;
  }

  @override
  Future<CommentsEntity> likeUnlikeComment(String commentId) async {
    final response =
        await networkRepository.get(url: '/comments/$commentId/like');
    final data = CommentsJson.fromJson(response.data).toDomain();
    return data;
  }

  @override
  Future<CommentsEntity> updateComment(CommentsEntity comment) async {
    final response =
        await networkRepository.get(url: '/comments/${comment.id}');
    final data = CommentsJson.fromJson(response.data).toDomain();
    return data;
  }
}
