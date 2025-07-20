import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../domain/model/emergency_contact_model.dart';
import 'emergency_contact_view.dart';

void showEmergencyContactBottomSheet(
    BuildContext context, EmergencyContactModel emergencyContact) {
  showModalBottomSheet(
    showDragHandle: true,
    context: context,
    isScrollControlled: true,
    backgroundColor: Theme.of(context).colorScheme.surface,
    builder: (context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.4,
        maxChildSize: 0.8,
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
