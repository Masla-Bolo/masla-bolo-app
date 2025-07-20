import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/helpers/extensions.dart';
import '../../../../../../../domain/model/issue_json.dart';
import '../../../../../../../helpers/styles/styles.dart';
import '../../../issue_helper.dart';

class IssueStatusDialog extends StatelessWidget {
  const IssueStatusDialog({
    super.key,
    required this.currentStatus,
    required this.nextStatus,
    required this.actionText,
    required this.onConfirm,
  });

  final IssueStatus currentStatus;
  final IssueStatus nextStatus;
  final String actionText;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    final currentColor = IssueHelper.getIssueStatusColor(currentStatus);
    final nextColor = IssueHelper.getIssueStatusColor(nextStatus);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header with icon
            Container(
              width: 60.w,
              height: 60.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    nextColor.withValues(alpha: 0.2),
                    nextColor.withValues(alpha: 0.1),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: Icon(
                _getStatusIcon(nextStatus),
                color: nextColor,
                size: 30.sp,
              ),
            ),

            16.verticalSpace,

            // Title
            Text(
              actionText,
              style: Styles.boldStyle(
                fontSize: 20.sp,
                color: Colors.black87,
                family: FontFamily.dmSans,
              ),
              textAlign: TextAlign.center,
            ),

            12.verticalSpace,

            // Status transition indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildStatusChip(
                    currentStatus.name.capitalized(), currentColor),
                8.horizontalSpace,
                Icon(
                  Icons.arrow_forward_rounded,
                  color: Colors.grey[400],
                  size: 20.sp,
                ),
                8.horizontalSpace,
                _buildStatusChip(nextStatus.name.capitalized(), nextColor),
              ],
            ),

            16.verticalSpace,

            // Description
            Text(
              IssueHelper.getStatusDescription(currentStatus, nextStatus),
              style: Styles.mediumStyle(
                fontSize: 14.sp,
                color: Colors.grey[600]!,
                family: FontFamily.varela,
              ),
              textAlign: TextAlign.center,
            ),

            24.verticalSpace,

            // Action buttons
            Row(
              children: [
                Expanded(
                  child: _buildActionButton(
                    text: 'Cancel',
                    onPressed: () => Navigator.of(context).pop(),
                    isPrimary: false,
                    color: Colors.grey[400]!,
                  ),
                ),
                12.horizontalSpace,
                Expanded(
                  child: _buildActionButton(
                    text: actionText,
                    onPressed: () {
                      Navigator.of(context).pop();
                      onConfirm();
                    },
                    isPrimary: true,
                    color: nextColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Text(
        text,
        style: Styles.mediumStyle(
          fontSize: 12.sp,
          color: color,
          family: FontFamily.varela,
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required String text,
    required VoidCallback onPressed,
    required bool isPrimary,
    required Color color,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 14.h),
          decoration: BoxDecoration(
            gradient: isPrimary
                ? LinearGradient(
                    colors: [color, color.withValues(alpha: 0.8)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            color: isPrimary ? null : Colors.grey[100],
            borderRadius: BorderRadius.circular(12.r),
            border: isPrimary
                ? null
                : Border.all(
                    color: Colors.grey[300]!,
                    width: 1,
                  ),
          ),
          child: Center(
            child: Text(
              text,
              style: Styles.semiMediumStyle(
                fontSize: 14.sp,
                color: isPrimary ? Colors.white : Colors.grey[600]!,
                family: FontFamily.dmSans,
              ),
            ),
          ),
        ),
      ),
    );
  }

  IconData _getStatusIcon(IssueStatus status) {
    switch (status) {
      case IssueStatus.approved:
        return Icons.check_circle;
      case IssueStatus.solving:
        return Icons.engineering;
      case IssueStatus.officialSolved:
        return Icons.verified;
      case IssueStatus.solved:
        return Icons.task_alt;
      default:
        return Icons.help;
    }
  }
}
