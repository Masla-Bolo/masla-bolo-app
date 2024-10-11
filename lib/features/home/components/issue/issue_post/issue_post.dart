import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/features/home/components/issue/issue_cubit.dart';
import 'package:masla_bolo_app/helpers/extensions.dart';
import 'package:masla_bolo_app/helpers/helpers.dart';
import 'package:masla_bolo_app/helpers/widgets/cached_image.dart';

import '../../../../../domain/entities/issue_entity.dart';
import '../../../../../helpers/styles/styles.dart';
import '../issue_helper.dart';

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
    return GestureDetector(
      onTap: () {
        cubit.goToIssueDetail(issue: issue);
      },
      child: Container(
        color: context.colorScheme.primary,
        child: Column(
          children: [
            20.verticalSpace,
            GestureDetector(
              onTap: () {
                cubit.goToIssueDetail(issue: issue);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          issue.isAnonymous
                              ? "by Anonymous user"
                              : "by ${issue.user.username}",
                          style: Styles.mediumStyle(
                            fontSize: 12,
                            family: FontFamily.dmSans,
                            color: context.colorScheme.onPrimary,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          issue.status.name.capitalized(),
                          style: Styles.mediumStyle(
                            fontSize: 12,
                            color:
                                IssueHelper.getIssueStatusColor(issue.status),
                            family: FontFamily.varela,
                          ),
                        ),
                      ],
                    ),
                    5.verticalSpace,
                    Text(
                      issue.title,
                      style: Styles.boldStyle(
                        fontSize: 20,
                        family: FontFamily.varela,
                        color: context.colorScheme.onPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            10.verticalSpace,
            GestureDetector(
              onTap: () {
                cubit.goToIssueDetail(issue: issue);
              },
              child: SizedBox(
                height: 0.5.sh,
                child: CachedImage(image: issue.images.first),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 8),
              color: context.colorScheme.primary,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                              ? "Like"
                              : issue.likesCount == 1
                                  ? "1 Like"
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
                              ? "comment"
                              : issue.commentsCount == 1
                                  ? "1 comment"
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
      ),
    );
  }
}
