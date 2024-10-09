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
              child: Row(
                children: [
                  5.horizontalSpace,
                  CircleAvatar(
                    radius: 12,
                    backgroundColor: context.colorScheme.onPrimary,
                    child: Icon(
                      Icons.person,
                      size: 12,
                      color: context.colorScheme.primary,
                    ),
                  ),
                  7.horizontalSpace,
                  Text(
                    issue.isAnonymous ? "Anonymous user" : issue.user.username!,
                    style: Styles.boldStyle(
                      fontSize: 15,
                      color: context.colorScheme.onPrimary,
                      family: FontFamily.varela,
                    ),
                  ),
                ],
              ),
            ),
            10.verticalSpace,
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  issue.title,
                  style: Styles.boldStyle(
                    fontSize: 12,
                    family: FontFamily.varela,
                    color: context.colorScheme.onPrimary,
                  ),
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
