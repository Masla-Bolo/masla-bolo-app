import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/helpers/widgets/scroll_shader_mask.dart';

import '../../../helpers/styles/app_colors.dart';
import '../../../helpers/styles/styles.dart';
import '../../../helpers/widgets/header.dart';
import '../home_cubit.dart';
import '../home_state.dart';

class HomeFilterDrawer extends StatelessWidget {
  const HomeFilterDrawer({super.key, required this.cubit});
  final HomeCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
        bloc: cubit,
        builder: (context, state) {
          return Scaffold(
            body: PopScope(
              canPop: true,
              onPopInvoked: (didPop) {
                Scaffold.of(context).closeEndDrawer();
              },
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    20.verticalSpace,
                    Header(
                      title: "Apply Filters",
                      onBackTap: () {
                        Scaffold.of(context).closeEndDrawer();
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
                                      color: AppColor.black1,
                                      family: FontFamily.varela,
                                    )),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    cubit.clearAllCategoryFilters();
                                  },
                                  child: Text("Clear All",
                                      style: Styles.mediumStyle(
                                        fontSize: 20,
                                        color: AppColor.grey,
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
                                        ? AppColor.black1
                                        : AppColor.white,
                                    label: Text(
                                      value.item,
                                      style: Styles.boldStyle(
                                        fontSize: 15,
                                        color: value.isSelected
                                            ? AppColor.white
                                            : AppColor.black1,
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
                                      color: AppColor.black1,
                                      family: FontFamily.varela,
                                    )),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    cubit.clearSortByFilter();
                                  },
                                  child: Text("Clear",
                                      style: Styles.mediumStyle(
                                        fontSize: 20,
                                        color: AppColor.grey,
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
                                          ? AppColor.black1
                                          : AppColor.white,
                                      label: Text(
                                        value.item,
                                        style: Styles.boldStyle(
                                          fontSize: 15,
                                          color: value.isSelected
                                              ? AppColor.white
                                              : AppColor.black1,
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
                              onPressed: () {
                                Scaffold.of(context).closeEndDrawer();
                                cubit.applyFilters();
                              },
                              child: const Padding(
                                padding: EdgeInsets.only(top: 20, bottom: 20),
                                child: Center(
                                  child: Text("Apply"),
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
