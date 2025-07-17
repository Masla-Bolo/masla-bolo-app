import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../domain/model/emergency_contact_model.dart';
import 'emergency_contact_view.dart';

void showEmergencyContactBottomSheet(
    BuildContext context, EmergencyContactModel emergencyContact) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.4,
        maxChildSize: 0.95,
        expand: false,
        builder: (_, scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.r),
                topRight: Radius.circular(24.r),
              ),
            ),
            padding: EdgeInsets.only(top: 16.h),
            child: SingleChildScrollView(
              controller: scrollController,
              child: EmergencyContactWidget(emergencyContact: emergencyContact),
            ),
          );
        },
      );
    },
  );
}
