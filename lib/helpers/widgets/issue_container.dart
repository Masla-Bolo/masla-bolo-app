import 'package:flutter/material.dart';
import 'package:masla_bolo_app/domain/entities/issue_entity.dart';
import 'package:masla_bolo_app/helpers/extensions.dart';

import '../../features/home/components/issue/issue_helper.dart';
import '../helpers.dart';
import '../styles/styles.dart';

class IssueContainer extends StatelessWidget {
  const IssueContainer({super.key, required this.onTap, required this.issue});
  final IssueEntity issue;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: context.colorScheme.onPrimary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 12,
                    child: Icon(
                      Icons.person,
                      size: 12,
                      color: context.colorScheme.onPrimary,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          issue.user.username!,
                          style: Styles.boldStyle(
                            family: FontFamily.varela,
                            fontSize: 14,
                            color: context.colorScheme.primary,
                          ),
                        ),
                        Text(
                          issue.status.name.capitalized(),
                          style: Styles.boldStyle(
                            fontSize: 12,
                            family: FontFamily.dmSans,
                            color:
                                IssueHelper.getIssueStatusColor(issue.status),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    formatDate(issue.createdAt),
                    style: Styles.mediumStyle(
                      family: FontFamily.dmSans,
                      fontSize: 12,
                      color: context.colorScheme.secondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                issue.title,
                style: Styles.boldStyle(
                  family: FontFamily.varela,
                  fontSize: 16,
                  color: context.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                issue.description,
                style: Styles.mediumStyle(
                  family: FontFamily.dmSans,
                  fontSize: 12,
                  color: context.colorScheme.primary,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
