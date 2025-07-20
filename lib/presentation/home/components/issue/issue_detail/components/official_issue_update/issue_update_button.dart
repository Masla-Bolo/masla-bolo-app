import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/presentation/home/components/issue/issue_detail/components/official_issue_update/issue_update_dialog.dart'
    show IssueStatusDialog;
import '../../../../../../../domain/model/issue_json.dart';
import '../../../../../../../helpers/styles/styles.dart';
import '../../../issue_helper.dart';

class IssueStatusActionButton extends StatelessWidget {
  const IssueStatusActionButton({
    super.key,
    required this.currentStatus,
    required this.onStatusChange,
  });

  final IssueStatus currentStatus;
  final Function(IssueStatus newStatus) onStatusChange;

  @override
  Widget build(BuildContext context) {
    final nextStatus = IssueHelper.getNextStatus(currentStatus);

    if (nextStatus == null) {
      return const SizedBox.shrink();
    }

    final actionText = IssueHelper.getActionText(currentStatus, nextStatus);
    final color = IssueHelper.getIssueStatusColor(currentStatus);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _showStatusDialog(context, nextStatus, actionText),
        borderRadius: BorderRadius.circular(20.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color.withValues(alpha: 0.1),
                color.withValues(alpha: 0.05),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
              color: color.withValues(alpha: 0.3),
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                _getActionIcon(nextStatus),
                color: color,
                size: 16.sp,
              ),
              6.horizontalSpace,
              Text(
                actionText,
                style: Styles.semiMediumStyle(
                  fontSize: 12.sp,
                  color: color,
                  family: FontFamily.varela,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showStatusDialog(
      BuildContext context, IssueStatus nextStatus, String actionText) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => IssueStatusDialog(
        currentStatus: currentStatus,
        nextStatus: nextStatus,
        actionText: actionText,
        onConfirm: () => onStatusChange(nextStatus),
      ),
    );
  }

  IconData _getActionIcon(IssueStatus status) {
    switch (status) {
      case IssueStatus.approved:
        return Icons.check_circle_outline;
      case IssueStatus.solving:
        return Icons.engineering_outlined;
      case IssueStatus.officialSolved:
        return Icons.verified_outlined;
      case IssueStatus.solved:
        return Icons.task_alt_outlined;
      default:
        return Icons.arrow_forward_outlined;
    }
  }
}
