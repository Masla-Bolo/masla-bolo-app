import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/domain/entities/comments_entity.dart';
import 'package:masla_bolo_app/features/home/components/issue_detail/issue_detail_state.dart';

import '../../../../../../helpers/styles/app_colors.dart';
import '../../../../../../helpers/styles/styles.dart';
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
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: AppColor.black1,
                      child: Icon(
                        Icons.person_2,
                        size: 15,
                        color: AppColor.white,
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
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    comment.user?.username ?? "",
                                    style: Styles.boldStyle(
                                      fontSize: 14,
                                      color: AppColor.black1,
                                      family: FontFamily.varela,
                                    ),
                                  ),
                                  2.verticalSpace,
                                  Text(
                                    comment.content,
                                    style: Styles.mediumStyle(
                                      fontSize: 12,
                                      color: AppColor.black1,
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
                              onTap: () {},
                              child: Text(
                                "Like",
                                style: Styles.boldStyle(
                                  fontSize: 14,
                                  color: AppColor.black1,
                                  family: FontFamily.varela,
                                ),
                              ),
                            ),
                            10.horizontalSpace,
                            const Text("•"),
                            10.horizontalSpace,
                            GestureDetector(
                              onTap: () {
                                cubit.makeReply(comment.user?.username ?? "");
                              },
                              child: Text(
                                "Reply",
                                style: Styles.mediumStyle(
                                  fontSize: 12,
                                  color: AppColor.black1,
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
