import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/helpers/extensions.dart';

import '../../../../../../helpers/widgets/header.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.verticalSpace,
              Header(
                title: "Contact Us",
                fontSize: 22.sp,
                onBackTap: () => Navigator.of(context).pop(),
              ),
              20.verticalSpace,
              Card(
                elevation: 4,
                color: context.colorScheme.onPrimary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Get in Touch",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: context.colorScheme.primary,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      _buildContactItem(
                          "📧 Email", "support@maslabolo.com", context),
                      _buildContactItem(
                          "📞 Phone", "+1 (234) 567-890", context),
                    ],
                  ),
                ),
              ),
              20.verticalSpace,
              // Card(
              //   elevation: 4,
              //   shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(15)),
              //   child: Padding(
              //     padding: const EdgeInsets.all(16),
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Text(
              //           "Follow Us",
              //           style: TextStyle(
              //             fontSize: 20.sp,
              //             fontWeight: FontWeight.bold,
              //             color: Theme.of(context).colorScheme.onPrimary,
              //           ),
              //         ),
              //         SizedBox(height: 10.h),
              //         const Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceAround,
              //           children: [],
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  // Method to create contact items
  Widget _buildContactItem(String title, String detail, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          const SizedBox(width: 8),
          RichText(
            text: TextSpan(
              text: "$title: ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: context.colorScheme.primary,
              ),
              children: <TextSpan>[
                TextSpan(
                    text: detail,
                    style: const TextStyle(fontWeight: FontWeight.normal)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
