import 'package:flutter/material.dart';
import 'package:masla_bolo_app/domain/entities/comments_entity.dart';

import 'comment.dart';

class IssueComments extends StatelessWidget {
  const IssueComments({super.key, required this.comments});
  final List<CommentsEntity> comments;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: comments.length,
        reverse: true,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final comment = comments[index];
          return Comment(comment: comment);
        });
  }
}
