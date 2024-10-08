import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/features/home/components/issue/issue_cubit.dart';
import 'package:masla_bolo_app/helpers/extensions.dart';
import 'package:masla_bolo_app/helpers/helpers.dart';
import 'package:masla_bolo_app/helpers/widgets/cached_image.dart';

import '../../../../../domain/entities/issue_entity.dart';
import '../../../../../helpers/styles/styles.dart';

class IssuePost extends StatelessWidget {
  const IssuePost({
    super.key,
    required this.index,
    required this.cubit,
    required this.issue,
  });
  final int index;
  final IssueCubit cubit;
  final IssueEntity issue;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colorScheme.primary,
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              cubit.goToIssueDetail(issue: issue);
            },
            child: Stack(
              children: [
                Center(
                  child: SizedBox(
                      height: 200,
                      child: CachedImage(image: issue.images.first)),
                ),
                Positioned(
                  top: 10,
                  child: Row(
                    children: [
                      5.horizontalSpace,
                      CircleAvatar(
                        backgroundColor: context.colorScheme.secondary,
                        radius: 15,
                        child: Icon(Icons.person,
                            color: context.colorScheme.primary),
                      ),
                      7.horizontalSpace,
                      Text(
                        issue.user.username!,
                        style: Styles.boldStyle(
                          fontSize: 12,
                          color: context.colorScheme.onPrimary,
                          family: FontFamily.varela,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          10.verticalSpace,
          Container(
            padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
            color: context.colorScheme.primary,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    cubit.goToIssueDetail(issue: issue);
                  },
                  child: Text(
                    issue.title,
                    style: Styles.boldStyle(
                      fontSize: 15,
                      family: FontFamily.varela,
                      color: context.colorScheme.onPrimary,
                    ),
                  ),
                ),
                20.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        cubit.likeUnlikeIssue(issue);
                      },
                      child: Icon(
                        issue.isLiked
                            ? Icons.thumb_up
                            : Icons.thumb_up_alt_outlined,
                        color: context.colorScheme.onPrimary,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        cubit.likeUnlikeIssue(issue);
                      },
                      child: Text(
                        issue.likesCount < 1
                            ? 'Likes'
                            : "${issue.likesCount} Likes",
                        style: Styles.mediumStyle(
                            fontSize: 12,
                            color: context.colorScheme.onPrimary,
                            family: FontFamily.varela),
                      ),
                    ),
                    5.horizontalSpace,
                    const Text("•"),
                    5.horizontalSpace,
                    GestureDetector(
                      onTap: () {
                        cubit.goToIssueDetail(
                          showComment: true,
                          issue: issue,
                        );
                      },
                      child: Icon(
                        Icons.comment_outlined,
                        color: context.colorScheme.onPrimary,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        cubit.goToIssueDetail(
                          showComment: true,
                          issue: issue,
                        );
                      },
                      child: Text(
                        issue.commentsCount < 1
                            ? 'comments'
                            : "${issue.commentsCount} comments",
                        style: Styles.mediumStyle(
                            fontSize: 12,
                            color: context.colorScheme.onPrimary,
                            family: FontFamily.varela),
                      ),
                    ),
                    5.horizontalSpace,
                    Text(
                      "•",
                      style: Styles.mediumStyle(
                          fontSize: 12,
                          color: context.colorScheme.onPrimary,
                          family: FontFamily.varela),
                    ),
                    5.horizontalSpace,
                    Text(
                      formatDate(issue.createdAt),
                      style: Styles.mediumStyle(
                          fontSize: 12,
                          color: context.colorScheme.onPrimary,
                          family: FontFamily.varela),
                    ),
                    5.horizontalSpace,
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
