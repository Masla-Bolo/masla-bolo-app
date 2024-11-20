import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../helpers/extensions.dart';
import '../../../helpers/widgets/scroll_shader_mask.dart';

import '../../../di/service_locator.dart';
import '../../../helpers/styles/styles.dart';
import '../../../helpers/widgets/header.dart';
import '../search_issue_cubit.dart';
import '../search_issue_state.dart';

class SearchFilterDrawer extends StatefulWidget {
  const SearchFilterDrawer({super.key});

  @override
  State<SearchFilterDrawer> createState() => _SearchFilterDrawerState();
}

class _SearchFilterDrawerState extends State<SearchFilterDrawer> {
  final cubit = getIt<SearchIssueCubit>();

  @override
  void initState() {
    super.initState();
    cubit.filterInit();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchIssueCubit, SearchIssueState>(
        bloc: cubit,
        builder: (context, state) {
          return Scaffold(
            body: PopScope(
              canPop: state.canPop,
              onPopInvokedWithResult: (didPop, _) async {
                cubit.closeDrawer();
              },
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    20.verticalSpace,
                    Header(
                      fontSize: 20,
                      title: "Apply Filters",
                      onBackTap: () {
                        cubit.closeDrawer();
                        if (state.canPop) cubit.navigation.pop();
                      },
                    ),
                    30.verticalSpace,
                    Expanded(
                        child: ScrollShaderMask(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Row(
                              children: [
                                Text("Categories",
                                    style: Styles.boldStyle(
                                      fontSize: 20,
                                      color: context.colorScheme.onPrimary,
                                      family: FontFamily.varela,
                                    )),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    cubit.clearAllCategoryFilters();
                                  },
                                  child: Text("Clear All",
                                      style: Styles.mediumStyle(
                                        fontSize: 16,
                                        color: state.categories
                                                .any((val) => val.isSelected)
                                            ? context.colorScheme.onPrimary
                                            : context.colorScheme.secondary
                                                .withOpacity(0.6),
                                        family: FontFamily.varela,
                                      )),
                                ),
                                20.horizontalSpace,
                              ],
                            ),
                          ),
                          20.verticalSpace,
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Wrap(
                              spacing: 10.w,
                              direction: Axis.horizontal,
                              children: state.categories.map((value) {
                                return GestureDetector(
                                  onTap: () {
                                    cubit.updateCategorySelection(value);
                                  },
                                  child: Chip(
                                    backgroundColor: value.isSelected
                                        ? context.colorScheme.onPrimary
                                        : context.colorScheme.primary,
                                    label: Text(
                                      value.item,
                                      style: Styles.boldStyle(
                                        fontSize: 15,
                                        color: value.isSelected
                                            ? context.colorScheme.primary
                                            : context.colorScheme.onPrimary,
                                        family: FontFamily.varela,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          30.verticalSpace,
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Row(
                              children: [
                                Text("Sort By",
                                    style: Styles.boldStyle(
                                      fontSize: 20,
                                      color: context.colorScheme.onPrimary,
                                      family: FontFamily.varela,
                                    )),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    cubit.clearSortByFilter();
                                  },
                                  child: Text("Clear",
                                      style: Styles.mediumStyle(
                                        fontSize: 16,
                                        color: state.sortBy
                                                .any((val) => val.isSelected)
                                            ? context.colorScheme.onPrimary
                                            : context.colorScheme.secondary
                                                .withOpacity(0.6),
                                        family: FontFamily.varela,
                                      )),
                                ),
                                20.horizontalSpace,
                              ],
                            ),
                          ),
                          20.verticalSpace,
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Wrap(
                                spacing: 10.w,
                                direction: Axis.horizontal,
                                children: state.sortBy.map((value) {
                                  return GestureDetector(
                                    onTap: () {
                                      cubit.updateSortBySelection(value);
                                    },
                                    child: Chip(
                                      backgroundColor: value.isSelected
                                          ? context.colorScheme.onPrimary
                                          : context.colorScheme.primary,
                                      label: Text(
                                        value.item,
                                        style: Styles.boldStyle(
                                          fontSize: 15,
                                          color: value.isSelected
                                              ? context.colorScheme.primary
                                              : context.colorScheme.onPrimary,
                                          family: FontFamily.varela,
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          30.verticalSpace,
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: ElevatedButton(
                              onPressed:
                                  (state.hasChanges && state.hasSelection)
                                      ? () {
                                          cubit.applyFilters();
                                          cubit.navigation.pop();
                                        }
                                      : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: context.colorScheme.onPrimary,
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 20, bottom: 20),
                                child: Center(
                                  child: Text(
                                    "Apply",
                                    style: Styles.boldStyle(
                                      fontSize: 15,
                                      color: context.colorScheme.primary,
                                      family: FontFamily.varela,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          30.verticalSpace,
                        ],
                      ),
                    )),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
