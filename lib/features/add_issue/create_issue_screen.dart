import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/features/add_issue/components/create_issue_form.dart';
import 'package:masla_bolo_app/features/add_issue/components/create_issue_header.dart';
import 'package:masla_bolo_app/features/add_issue/create_issue_cubit.dart';
import 'package:masla_bolo_app/features/add_issue/create_issue_state.dart';
import 'package:masla_bolo_app/helpers/extensions.dart';
import 'package:masla_bolo_app/helpers/helpers.dart';
import 'package:masla_bolo_app/helpers/widgets/cached_image.dart';

import '../../di/service_locator.dart';
import '../../helpers/styles/styles.dart';

class CreateIssueScreen extends StatelessWidget {
  const CreateIssueScreen({super.key});
  static final cubit = getIt<CreateIssueCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateIssueCubit, CreateIssueState>(
        bloc: cubit,
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    10.verticalSpace,
                    IssueHeader(cubit: cubit),
                    10.verticalSpace,
                    IssueForm(cubit: cubit),
                    20.verticalSpace,
                    if (state.issue.images.isNotEmpty)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: state.issue.images.map((image) {
                              return Stack(
                                children: [
                                  SizedBox(
                                    height: 0.2.sh,
                                    width: 0.4.sw,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: CachedImage(image: image),
                                    ),
                                  ),
                                  Positioned(
                                    top: -2,
                                    right: 1,
                                    child: GestureDetector(
                                        onTap: () {
                                          cubit.removeImage(image);
                                        },
                                        child: const Icon(Icons.cancel)),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    20.verticalSpace,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: state.categories.slices(7).map((row) {
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: row.map((value) {
                              return Padding(
                                padding: const EdgeInsets.all(2),
                                child: GestureDetector(
                                  onTap: () {
                                    cubit.updateSelection(value);
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
                                ),
                              );
                            }).toList(),
                          ),
                        );
                      }).toList(),
                    ),
                    30.verticalSpace,
                    Row(
                      children: [
                        10.horizontalSpace,
                        Text(
                          "Post as anonymous",
                          style: Styles.boldStyle(
                            fontSize: 15,
                            color: context.colorScheme.onPrimary,
                            family: FontFamily.dmSans,
                          ),
                        ),
                        const Spacer(),
                        CupertinoSwitch(
                          value: state.issue.isAnonymous,
                          onChanged: (val) {
                            cubit.changeAnonymous(val);
                          },
                          activeColor: context.colorScheme.onPrimary,
                          thumbColor: context.colorScheme.primary,
                        ),
                        10.horizontalSpace,
                      ],
                    ),
                    20.verticalSpace,
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          loader(() => cubit.createIssue());
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          backgroundColor: context.colorScheme.onPrimary,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 20),
                          child: Center(
                            child: Text(
                              "Create",
                              style: Styles.boldStyle(
                                fontSize: 15,
                                color: context.colorScheme.primary,
                                family: FontFamily.dmSans,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    10.verticalSpace,
                  ],
                ),
              ),
            ),
          );
        });
  }
}
