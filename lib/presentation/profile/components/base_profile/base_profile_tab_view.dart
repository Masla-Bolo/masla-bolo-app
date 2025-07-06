import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/presentation/profile/components/settings/settings_sub_screens/like_issue/components/issue_container_shimmer.dart';
import 'package:masla_bolo_app/presentation/profile/components/base_profile/base_profile_initial_params.dart';
import '../../../../di/service_locator.dart';
import '../../../../domain/model/issue_json.dart';
import '../../profile_cubit.dart';
import '../../profile_state.dart';
import '../../../../helpers/extensions.dart';

import '../../../../helpers/styles/styles.dart';
import '../../../../helpers/widgets/indicator.dart';
import '../../../../helpers/widgets/issue_container.dart';

class BaseProfileTabView extends StatefulWidget {
  const BaseProfileTabView({
    super.key,
    required this.params,
    required this.status,
  });
  final BaseProfileInitialParams params;
  final IssueStatus status;
  @override
  State<BaseProfileTabView> createState() => _BaseProfileTabViewState();
}

class _BaseProfileTabViewState extends State<BaseProfileTabView> {
  final scrollController = ScrollController();
  final profileCubit = getIt<ProfileCubit>();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.hasClients) {
        final threshold = scrollController.position.maxScrollExtent * 0.2;
        if (scrollController.position.pixels >= threshold) {
          widget.params.scrollAndCall.call(widget.status);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
        bloc: profileCubit,
        builder: (context, state) {
          final result = widget.params.allIssues[widget.status]!;
          final isLoaded = result.isLoaded;
          final isScrolled = result.isScrolled;
          final issues = result.issues.results;
          return RefreshIndicator(
            color: context.colorScheme.onPrimary,
            onRefresh: () async {
              if (isLoaded) {
                widget.params.refreshIssues.call(widget.status);
              }
            },
            child: SingleChildScrollView(
              key: Key(widget.status.name),
              physics: const AlwaysScrollableScrollPhysics(),
              controller: scrollController,
              restorationId: widget.status.name,
              child: (!isLoaded)
                  ? ListView.builder(
                      itemCount: 5,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return const IssueContainerShimmer();
                      })
                  : (issues.isEmpty && isLoaded)
                      ? SizedBox(
                          height: 0.5.sh,
                          child: Center(
                            child: Text(
                              "No Issues found",
                              style: Styles.boldStyle(
                                family: FontFamily.varela,
                                fontSize: 16,
                                color: context.colorScheme.onPrimary,
                              ),
                            ),
                          ),
                        )
                      : Column(
                          children: [
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: issues.length,
                              itemBuilder: (context, index) {
                                final issue = issues[index];
                                return IssueContainer(
                                  image: state.user.image,
                                  isUser: state.user.role == "user",
                                  issue: issue,
                                  toggleIssueSelection: () {
                                    widget.params.toggleIssueSelection
                                        ?.call(issue);
                                  },
                                  selectionEnabled:
                                      widget.params.selectionEnabled,
                                  onLongPress: () {
                                    widget.params.onLongPressIssue?.call(issue);
                                  },
                                  onTap: () {
                                    widget.params.goToIssueDetail(issue);
                                  },
                                );
                              },
                            ),
                            if (!isScrolled && isLoaded)
                              const Padding(
                                padding: EdgeInsets.all(8),
                                child: Indicator(),
                              ),
                          ],
                        ),
            ),
          );
        });
  }
}
