import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/helpers/extensions.dart';
import 'package:masla_bolo_app/helpers/styles/styles.dart';
import 'package:masla_bolo_app/helpers/widgets/header.dart';

import '../../../../../get_started/componenets/info_card.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                10.verticalSpace,
                Header(
                  title: "About Us",
                  fontSize: 22.sp,
                  onBackTap: () => Navigator.of(context).pop(),
                ),
                20.verticalSpace,
                const InfoCard(
                  title: "🎯 Our Mission",
                  subTitle:
                      "We connect you directly with city officials to fix problems faster. No more delays, just results.",
                ),
                10.verticalSpace,
                const InfoCard(
                  title: "💡 Our Core Values",
                  subTitle:
                      "We stand by the principles of empathy, inclusivity, and confidentiality. Every voice matters, and every story is treated with respect.",
                ),
                10.verticalSpace,
                const InfoCard(
                  title: "🤝 Our Community Focus",
                  subTitle:
                      "Masla Bolo is more than a platform; it’s a community built on trust and understanding. We connect users with like-minded individuals.",
                ),
                10.verticalSpace,
                const InfoCard(
                  title: "🌍 Make a Difference",
                  subTitle:
                      "Together, we can create a cleaner, safer city. Your reports matter!",
                ),
                10.verticalSpace,
                _buildQuoteSection(
                  "“Your story is unique, and so are your struggles. Speak up, be heard, and let others find strength in your courage.”",
                  context,
                ),
                10.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuoteSection(String quote, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: context.colorScheme.secondary.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(children: [
        Text(
          quote,
          textAlign: TextAlign.center,
          style: Styles.boldStyle(
            fontSize: 18.sp,
            color: context.colorScheme.onPrimary,
            family: FontFamily.varela,
          ),
        )
      ]),
    );
  }
}
