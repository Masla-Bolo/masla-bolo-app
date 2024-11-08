import 'package:flutter/material.dart';
import 'package:masla_bolo_app/helpers/extensions.dart';

import '../../../../helpers/styles/styles.dart';

class BaseProfileTab extends StatelessWidget {
  const BaseProfileTab({
    super.key,
    required this.tabController,
    required this.tabHeadings,
  });
  final TabController tabController;
  final List<String> tabHeadings;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TabBar(
        indicatorColor: context.colorScheme.onPrimary,
        indicatorSize: TabBarIndicatorSize.tab,
        unselectedLabelStyle: Styles.boldStyle(
          fontSize: 12,
          color: context.colorScheme.onPrimary,
          family: FontFamily.dmSans,
        ),
        labelStyle: Styles.boldStyle(
          fontSize: 12,
          color: context.colorScheme.onPrimary,
          family: FontFamily.dmSans,
        ),
        labelPadding: const EdgeInsets.only(bottom: 5, left: 15, right: 15),
        tabAlignment: TabAlignment.start,
        isScrollable: true,
        dividerColor: Colors.transparent,
        controller: tabController,
        tabs: tabHeadings.map((heading) {
          return Center(
            child: Text(
              heading,
              textAlign: TextAlign.center,
              style: Styles.boldStyle(
                fontSize: 15,
                color: context.colorScheme.onPrimary,
                family: FontFamily.varela,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
