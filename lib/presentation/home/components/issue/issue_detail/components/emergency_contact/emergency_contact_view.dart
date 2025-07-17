import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/helpers/extensions.dart';
import 'package:masla_bolo_app/helpers/styles/styles.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../../../domain/model/emergency_contact_item_model.dart';
import '../../../../../../../domain/model/emergency_contact_model.dart';
import '../../../../../../../helpers/styles/app_colors.dart';

class EmergencyContactWidget extends StatelessWidget {
  final EmergencyContactModel emergencyContact;
  const EmergencyContactWidget({
    super.key,
    required this.emergencyContact,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColor.red.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColor.red.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: AppColor.red.withOpacity(0.1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.emergency,
                  color: AppColor.red,
                  size: 24.sp,
                ),
                12.horizontalSpace,
                Text(
                  'Emergency Contacts',
                  style: Styles.boldStyle(
                    fontSize: 18.sp,
                    color: AppColor.red,
                    family: FontFamily.dmSans,
                  ),
                ),
              ],
            ),
          ),

          // Contact Cards
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                _buildContactCard(
                  context,
                  'Primary Contact',
                  emergencyContact.primaryContact,
                  Icons.star,
                  AppColor.red,
                ),
                16.verticalSpace,
                _buildContactCard(
                  context,
                  'Secondary Contact',
                  emergencyContact.secondaryContact,
                  Icons.backup,
                  AppColor.orange,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard(
    BuildContext context,
    String title,
    EmergencyContactItemModel contact,
    IconData icon,
    Color accentColor,
  ) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: accentColor.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Contact Header
          Row(
            children: [
              Icon(
                icon,
                color: accentColor,
                size: 20.sp,
              ),
              8.horizontalSpace,
              Text(
                title,
                style: Styles.boldStyle(
                  fontSize: 16.sp,
                  color: context.colorScheme.onPrimary,
                  family: FontFamily.dmSans,
                ),
              ),
            ],
          ),
          10.verticalSpace,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: accentColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              contact.type,
              style: Styles.mediumStyle(
                fontSize: 12.sp,
                color: accentColor,
                family: FontFamily.dmSans,
              ),
            ),
          ),
          16.verticalSpace,

          // Contact Info
          _buildContactInfo(
            context,
            Icons.phone,
            'Phone',
            contact.phone,
            () => _makePhoneCall(contact.phone),
          ),
          12.verticalSpace,
          _buildContactInfo(
            context,
            Icons.email,
            'Email',
            contact.email,
            () => _sendEmail(contact.email),
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfo(
    BuildContext context,
    IconData icon,
    String label,
    String value,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: AppColor.lightGrey.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppColor.blueGrey,
              size: 18.sp,
            ),
            12.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: Styles.lightStyle(
                      fontSize: 12.sp,
                      color: AppColor.lightGrey,
                      family: FontFamily.dmSans,
                    ),
                  ),
                  4.verticalSpace,
                  Text(
                    value,
                    style: Styles.mediumStyle(
                      fontSize: 14.sp,
                      color: context.colorScheme.onPrimary,
                      family: FontFamily.dmSans,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: AppColor.lightGrey,
              size: 14.sp,
            ),
          ],
        ),
      ),
    );
  }

  void _makePhoneCall(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }

  void _sendEmail(String email) async {
    final Uri emailUri = Uri(scheme: 'mailto', path: email);
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }
}
