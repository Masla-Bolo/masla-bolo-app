import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/domain/entities/comments_entity.dart';
import 'package:masla_bolo_app/features/home/components/issue/issue_detail/issue_detail_state.dart';
import 'package:masla_bolo_app/helpers/extensions.dart';

import '../../../../../../../helpers/styles/styles.dart';
import '../../issue_detail_cubit.dart';
import 'issue_comments.dart';

class Comment extends StatelessWidget {
  const Comment({super.key, required this.comment, required this.cubit});
  final CommentsEntity comment;
  final IssueDetailCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IssueDetailCubit, IssueDetailState>(
        bloc: cubit,
        builder: (context, state) {
          return Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor:
                          context.colorScheme.onPrimary.withOpacity(0.9),
                      child: Icon(
                        Icons.person_2,
                        size: 15,
                        color: context.colorScheme.primary,
                      ),
                    ),
                  ),
                  5.horizontalSpace,
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(0),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              width: 1.sw,
                              decoration: BoxDecoration(
                                color: context.colorScheme.onPrimary
                                    .withOpacity(0.9),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    comment.user?.username ?? "",
                                    style: Styles.boldStyle(
                                      fontSize: 12,
                                      color: context.colorScheme.primary,
                                      family: FontFamily.varela,
                                    ),
                                  ),
                                  2.verticalSpace,
                                  Text(
                                    comment.content,
                                    style: Styles.mediumStyle(
                                      fontSize: 14,
                                      color: context.colorScheme.primary,
                                      family: FontFamily.varela,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            5.verticalSpace,
                          ],
                        ),
                        subtitle: Row(
                          children: [
                            10.horizontalSpace,
                            GestureDetector(
                              onTap: () {
                                cubit.likeUnlikeComment(comment.id!);
                              },
                              child: Text(
                                "Like",
                                style: Styles.boldStyle(
                                  fontSize: 14,
                                  color: comment.isLiked
                                      ? context.colorScheme.onPrimary
                                      : context.colorScheme.secondary,
                                  family: FontFamily.varela,
                                ),
                              ),
                            ),
                            10.horizontalSpace,
                            Text(
                              "|",
                              style: Styles.boldStyle(
                                fontSize: 14,
                                color: context.colorScheme.onPrimary,
                                family: FontFamily.varela,
                              ),
                            ),
                            10.horizontalSpace,
                            GestureDetector(
                              onTap: () {
                                cubit.makeReply(comment);
                              },
                              child: Text(
                                "Reply",
                                style: Styles.mediumStyle(
                                  fontSize: 12,
                                  color: context.colorScheme.secondary,
                                  family: FontFamily.varela,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (comment.replies.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: IssueComments(
                    comments: comment.replies,
                    cubit: cubit,
                  ),
                ),
            ],
          );
        });
  }
}
