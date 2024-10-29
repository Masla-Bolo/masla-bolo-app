import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/presentation/get_started/componenets/info_card.dart';
import '../../../../../../helpers/widgets/header.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.verticalSpace,
              Header(
                title: "Privacy Policy",
                fontSize: 22.sp,
                onBackTap: () => Navigator.of(context).pop(),
              ),
              20.verticalSpace,
              const InfoCard(
                title: "Introduction",
                subTitle:
                    "We value your privacy and are committed to protecting your personal information. This Privacy Policy outlines how we collect, use, and safeguard your data.",
              ),
              10.verticalSpace,
              const InfoCard(
                title: "Information We Collect",
                subTitle:
                    "We collect information you provide directly, such as when you create an account, and automatically, through your interactions with our app.",
              ),
              10.verticalSpace,
              const InfoCard(
                title: "How We Use Information",
                subTitle:
                    "The information we collect helps us improve our services, personalize your experience, and communicate with you about updates and offers.",
              ),
              10.verticalSpace,
              const InfoCard(
                title: "Data Security",
                subTitle:
                    "We take measures to protect your data from unauthorized access and ensure that your information is stored securely.",
              ),
              10.verticalSpace,
              const InfoCard(
                title: "Your Choices",
                subTitle:
                    "You have choices regarding the data you share with us, including options to update or delete your account information.",
              ),
              10.verticalSpace,
              const InfoCard(
                title: "Changes to This Policy",
                subTitle:
                    "We may update this Privacy Policy to reflect changes in our practices. We encourage you to review it periodically.",
              ),
              20.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
