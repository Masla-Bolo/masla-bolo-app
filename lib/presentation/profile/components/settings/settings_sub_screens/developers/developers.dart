import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/helpers/extensions.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../helpers/styles/styles.dart';
import '../../../../../../helpers/widgets/header.dart';

class Developers extends StatelessWidget {
  const Developers({super.key});

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$text copied to clipboard')),
    );
  }

  void _launchEmail(String email) async {
    final emailUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }

  void _launchPhone(String phoneNumber) async {
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }

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
                  title: "Developers",
                  fontSize: 22,
                  onBackTap: () => Navigator.of(context).pop(),
                ),
                20.verticalSpace,
                _buildDeveloperCard(
                  context,
                  name: "Muhammad Ashar",
                  role: "Full Stack & Flutter Developer",
                  description:
                      "Experienced in Flutter, and backend services, with expertise in building interactive, full-stack applications. Currently exploring cloud services and AI for interactive experiences.",
                  email: "asheressani@gmail.com",
                  phone: "+923312079579",
                ),
                const SizedBox(height: 20),
                _buildDeveloperCard(
                  context,
                  name: "Osama Ali Khan",
                  role: "Python Developer & Aspiring Data Analyst",
                  description:
                      "Specializes in Python programming with a growing interest in data analysis. Passionate about uncovering insights through data-driven solutions.",
                  email: "osamakhannnn499@gmail.com",
                  phone: "+923196172259",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDeveloperCard(
    BuildContext context, {
    required String name,
    required String role,
    required String description,
    required String email,
    required String phone,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: context.colorScheme.onPrimary,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: Styles.boldStyle(
                fontSize: 22,
                color: context.colorScheme.primary,
                family: FontFamily.varela,
              ),
            ),
            Text(role,
                style: Styles.semiMediumStyle(
                  fontSize: 16,
                  color: context.colorScheme.primary,
                  family: FontFamily.varela,
                )),
            const SizedBox(height: 10),
            Text(
              description,
              style: Styles.lightStyle(
                fontSize: 16,
                color: context.colorScheme.primary,
                family: FontFamily.varela,
              ),
            ),
            const SizedBox(height: 15),
            Divider(color: context.colorScheme.primary),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.email, color: context.colorScheme.secondary),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    email,
                    style: Styles.lightStyle(
                      fontSize: 16,
                      color: context.colorScheme.primary,
                      family: FontFamily.varela,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.copy, color: context.colorScheme.secondary),
                  onPressed: () => _copyToClipboard(context, email),
                ),
                IconButton(
                  icon: Icon(Icons.email_outlined,
                      color: context.colorScheme.secondary),
                  onPressed: () => _launchEmail(email),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.phone, color: context.colorScheme.secondary),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    phone,
                    style: Styles.lightStyle(
                      fontSize: 16,
                      color: context.colorScheme.primary,
                      family: FontFamily.varela,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.copy, color: context.colorScheme.secondary),
                  onPressed: () => _copyToClipboard(context, phone),
                ),
                IconButton(
                  icon: Icon(Icons.call, color: context.colorScheme.secondary),
                  onPressed: () => _launchPhone(phone),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
