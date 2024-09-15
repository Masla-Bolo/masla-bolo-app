import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../helpers/styles/app_colors.dart';
import '../../../helpers/styles/styles.dart';
import '../../../helpers/widgets/header.dart';
import '../home_cubit.dart';

class HomeFilterDrawer extends StatelessWidget {
  const HomeFilterDrawer({super.key, required this.cubit});
  final HomeCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
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
              Text("Categories",
                  style: Styles.boldStyle(
                    fontSize: 20,
                    color: AppColor.black1,
                    family: FontFamily.varela,
                  )),
              20.verticalSpace,
              Wrap(
                spacing: 10.w,
                direction: Axis.horizontal,
                children: [
                  Chip(
                      label: Text("Electric",
                          style: Styles.boldStyle(
                            fontSize: 15,
                            color: AppColor.white,
                            family: FontFamily.varela,
                          ))),
                  Chip(
                    label: Text(
                      "Sewerage",
                      style: Styles.boldStyle(
                        fontSize: 15,
                        color: AppColor.white,
                        family: FontFamily.varela,
                      ),
                    ),
                  ),
                  Chip(
                      label: Text("Street",
                          style: Styles.boldStyle(
                            fontSize: 15,
                            color: AppColor.white,
                            family: FontFamily.varela,
                          ))),
                  Chip(
                      label: Text("Broken",
                          style: Styles.boldStyle(
                            fontSize: 15,
                            color: AppColor.white,
                            family: FontFamily.varela,
                          ))),
                  Chip(
                      label: Text("Other",
                          style: Styles.boldStyle(
                            fontSize: 15,
                            color: AppColor.white,
                            family: FontFamily.varela,
                          ))),
                ],
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    Scaffold.of(context).closeEndDrawer();
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
        ),
      ),
    );
  }
}
