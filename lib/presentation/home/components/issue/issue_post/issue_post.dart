import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/helpers/styles/app_images.dart';
import '../../../../../helpers/widgets/rounded_image.dart';
import 'issue_post_params.dart';
import '../../../../../helpers/extensions.dart';
import '../../../../../helpers/helpers.dart';
import '../../../../../helpers/styles/app_colors.dart';
import '../../../../../helpers/widgets/cached_image.dart';

import '../../../../../helpers/styles/styles.dart';
import '../issue_helper.dart';

class IssuePost extends StatelessWidget {
  final IssuePostParams params;
  const IssuePost({
    super.key,
    required this.params,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        params.cubit.goToIssueDetail(issue: params.issue);
      },
      child: Container(
        color: context.colorScheme.primary,
        child: Column(
          children: [
            20.verticalSpace,
            GestureDetector(
              onTap: () {
                params.cubit.goToIssueDetail(issue: params.issue);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RoundedImage(
                          imageUrl: params.issue.user.image,
                          iconText: params.issue.user.username,
                          radius: 13.w,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                params.issue.isAnonymous
                                    ? "Anonymous"
                                    : params.issue.user.username!,
                                style: Styles.boldStyle(
                                  family: FontFamily.varela,
                                  fontSize: 14,
                                  color: context.colorScheme.onPrimary,
                                ),
                              ),
                              Text(
                                params.issue.status.name.capitalized(),
                                style: Styles.boldStyle(
                                  fontSize: 12,
                                  family: FontFamily.dmSans,
                                  color: IssueHelper.getIssueStatusColor(
                                      params.issue.status),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      params.issue.title,
                      style: Styles.boldStyle(
                        family: FontFamily.varela,
                        fontSize: 16,
                        color: context.colorScheme.onPrimary,
                      ),
                    ),
                    const SizedBox(height: 5),
                    RichText(
                      text: TextSpan(
                          text: params.issue.seeMore
                              ? "${params.description} "
                              : params.description,
                          style: Styles.mediumStyle(
                            family: FontFamily.dmSans,
                            fontSize: 12,
                            color: context.colorScheme.onPrimary,
                          ),
                          children: [
                            if (!params.issue.seeMore &&
                                !(params.issue.description.length <
                                    params.descriptionThreshold))
                              TextSpan(
                                text: "... ",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: context.colorScheme.onPrimary,
                                ),
                              ),
                            if (!(params.issue.description.length < 55))
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    params.calledSeeMore.call();
                                  },
                                text: params.issue.seeMore
                                    ? "see less"
                                    : "see more",
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: AppColor.blue,
                                  decoration: TextDecoration.underline,
                                ),
                              )
                          ]),
                    ),
                  ],
                ),
              ),
            ),
            10.verticalSpace,
            GestureDetector(
              onTap: () {
                params.cubit.goToIssueDetail(issue: params.issue);
              },
              child: SizedBox(
                height: 0.5.sh,
                child: PageView.builder(
                  controller: params.pageController,
                  itemCount: params.issue.images.length,
                  onPageChanged: (index) {
                    params.pageController.jumpToPage(index);
                    params.updateIndex.call(index);
                  },
                  itemBuilder: (context, index) {
                    final image = params.issue.images[index];
                    return Padding(
                      key: Key("${params.currentImageIndex}"),
                      padding: const EdgeInsets.symmetric(horizontal: 1),
                      child: CachedImage(
                        image: image,
                        borderRadius: 0,
                      ),
                    );
                  },
                ),
              ),
            ),
            15.verticalSpace,
            if (params.issue.images.length > 1)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List<Widget>.generate(
                    params.issue.images.length,
                    (index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: InkWell(
                            onTap: () {
                              params.pageController.animateToPage(index,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeIn);
                            },
                            child: CircleAvatar(
                              radius: 3,
                              backgroundColor: params.currentImageIndex == index
                                  ? context.colorScheme.onPrimary
                                  : context.colorScheme.secondary,
                            ),
                          ),
                        )),
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
                          params.cubit.likeUnlikeIssue(params.issue);
                        },
                        child: Image.asset(
                          params.issue.isLiked
                              ? AppImages.raised
                              : AppImages.raise,
                          height: 22,
                          color: context.colorScheme.onPrimary,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          params.cubit.likeUnlikeIssue(params.issue);
                        },
                        child: Text(
                          params.issue.likesCount < 1
                              ? "Raise"
                              : "${IssueHelper.getLikesCount(params.issue.likesCount)} Raises",
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
                          params.cubit.goToIssueDetail(
                            showComment: true,
                            issue: params.issue,
                          );
                        },
                        child: Image.asset(
                          AppImages.comment,
                          color: context.colorScheme.onPrimary,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          params.cubit.goToIssueDetail(
                            showComment: true,
                            issue: params.issue,
                          );
                        },
                        child: Text(
                          params.issue.commentsCount < 1
                              ? "comment"
                              : params.issue.commentsCount == 1
                                  ? "1 comment"
                                  : "${params.issue.commentsCount} comments",
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
                        formatDate(params.issue.createdAt),
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
