import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../domain/entities/comments_entity.dart';
import '../../../../../../../helpers/widgets/rounded_image.dart';
import '../../issue_detail_state.dart';
import '../../../../../../../helpers/extensions.dart';

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
                    padding: const EdgeInsets.only(bottom: 20),
                    child: RoundedImage(
                      imageUrl: comment.user?.image,
                      iconText: comment.user?.username,
                      radius: 20.w,
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
                                    state.currentIssue.isAnonymous
                                        ? "Anonymous"
                                        : comment.user?.username ?? "",
                                    style: Styles.mediumStyle(
                                      fontSize: 16,
                                      color: context.colorScheme.primary,
                                      family: FontFamily.varela,
                                    ),
                                  ),
                                  2.verticalSpace,
                                  Text(
                                    comment.content,
                                    style: Styles.mediumStyle(
                                      fontSize: 12,
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
                            if (comment.replies.isNotEmpty) ...[
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  cubit.showHideReply(comment);
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(
                                      comment.showReplies
                                          ? Icons.arrow_drop_up_outlined
                                          : Icons.arrow_drop_down_outlined,
                                      color: context.colorScheme.onPrimary
                                          .withOpacity(0.9),
                                    ),
                                    2.horizontalSpace,
                                    Text(
                                      comment.showReplies
                                          ? "Hide Replies"
                                          : "Show Replies",
                                      style: Styles.mediumStyle(
                                        fontSize: 12,
                                        color: context.colorScheme.onPrimary
                                            .withOpacity(0.9),
                                        family: FontFamily.varela,
                                      ),
                                    ),
                                    10.horizontalSpace,
                                  ],
                                ),
                              ),
                            ],
                            10.horizontalSpace,
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (comment.replies.isNotEmpty && comment.showReplies)
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
