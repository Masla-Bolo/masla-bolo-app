import 'package:flutter/material.dart';
import 'package:masla_bolo_app/di/service_locator.dart';
import '../../helpers/styles/app_colors.dart';
import 'components/issue_map_search_field.dart';
import 'components/issue_map_widget.dart';
import 'issue_map_cubit.dart';

class IssueMapScreen extends StatelessWidget {
  const IssueMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const IssueMapView();
  }
}

class IssueMapView extends StatelessWidget {
  const IssueMapView({super.key});

  static final cubit = getIt<IssueMapCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.darkBlue,
      body: SafeArea(
        child: Stack(
          children: [
            // Map Widget
            const IssueMapWidget(),

            // Search Field Overlay
            Positioned(
              top: 16,
              left: 16,
              right: 16,
              child: MapSearchField(
                onTap: () {
                  cubit.goToSearchIssues();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
