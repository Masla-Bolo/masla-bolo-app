import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/helpers/widgets/indicator.dart';
import 'package:masla_bolo_app/presentation/add_issue/components/show_media.dart';
import 'components/create_issue_form.dart';
import 'components/create_issue_header.dart';
import 'create_issue_cubit.dart';
import 'create_issue_state.dart';
import '../../helpers/extensions.dart';
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
              child: Stack(
                children: [
                  CustomScrollView(
                    slivers: [
                      IssueHeader(cubit: cubit),
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            10.verticalSpace,
                            IssueForm(cubit: cubit),
                            20.verticalSpace,
                            if (state.issue.fileImages.isNotEmpty)
                              ShowMedia(
                                  media: state.issue.fileImages,
                                  onCrossTap: (media) {
                                    cubit.removeMedia(media);
                                  }),
                            20.verticalSpace,
                            Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: state.categories
                                    .slices(
                                        (state.categories.length / 3).floor())
                                    .map((row) {
                                  return SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    controller: ScrollController(
                                        initialScrollOffset: 0.5),
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
                                                  ? context
                                                      .colorScheme.onPrimary
                                                  : context.colorScheme.primary,
                                              label: Text(
                                                value.item,
                                                style: Styles.boldStyle(
                                                  fontSize: 15,
                                                  color: value.isSelected
                                                      ? context
                                                          .colorScheme.primary
                                                      : context.colorScheme
                                                          .onPrimary,
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
                                  activeTrackColor:
                                      context.colorScheme.onPrimary,
                                  thumbColor: context.colorScheme.primary,
                                ),
                                10.horizontalSpace,
                              ],
                            ),
                            20.verticalSpace,
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: ElevatedButton(
                                onPressed: () {
                                  cubit.createIssue();
                                },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(double.infinity, 48),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  backgroundColor:
                                      context.colorScheme.onPrimary,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, bottom: 20),
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
                    ],
                  ),
                  if (state.isLoading) const Center(child: Indicator())
                ],
              ),
            ),
          );
        });
  }
}
