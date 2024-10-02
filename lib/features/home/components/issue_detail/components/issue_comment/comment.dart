import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/domain/entities/comments_entity.dart';

import '../../../../../../helpers/styles/app_colors.dart';
import '../../../../../../helpers/styles/styles.dart';
import 'issue_comments.dart';

class Comment extends StatelessWidget {
  const Comment({super.key, required this.comment});
  final CommentsEntity comment;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 5, 5, 5),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 12,
                backgroundColor: AppColor.black1,
                child: Icon(
                  Icons.person_2,
                  size: 10,
                  color: AppColor.white,
                ),
              ),
              5.horizontalSpace,
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
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
              ),
            ],
          ),
        ),
        if (comment.replies.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: IssueComments(comments: comment.replies),
          ),
      ],
    );
  }
}
