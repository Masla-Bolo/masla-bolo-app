import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../helpers/helpers.dart';
import '../../helpers/widgets/indicator.dart';
import 'notification_cubit.dart';
import 'notification_state.dart';
import '../../helpers/extensions.dart';
import '../../helpers/styles/app_colors.dart';
import '../../helpers/styles/styles.dart';

import '../../di/service_locator.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final cubit = getIt<NotificationCubit>();
  @override
  void initState() {
    super.initState();
    cubit.updateSeenCount();
  }

  @override
  void dispose() {
    cubit.updateSeenCount(clear: true);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationCubit, NotificationState>(
        bloc: cubit,
        builder: (context, state) {
          final notifications = state.pagination.results;
          return Scaffold(
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  10.verticalSpace,
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Text(
                      "Notifications",
                      maxLines: 1,
                      style: Styles.boldStyle(
                        fontSize: 20,
                        color: context.colorScheme.onPrimary,
                        family: FontFamily.varela,
                      ),
                    ),
                  ),
                  20.verticalSpace,
                  Expanded(
                    child: RefreshIndicator(
                      color: context.colorScheme.onPrimary,
                      onRefresh: () async {
                        if (state.isLoaded) {
                          cubit.refreshIssues();
                        }
                      },
                      child: SingleChildScrollView(
                          controller: state.scrollController,
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Column(
                            children: [
                              (!state.isLoaded)
                                  ? const Center(child: Indicator())
                                  : (notifications.isEmpty && state.isLoaded)
                                      ? SizedBox(
                                          height: 0.5.sh,
                                          child: Center(
                                            child: Text(
                                              "No Notifications found",
                                              style: Styles.boldStyle(
                                                family: FontFamily.varela,
                                                fontSize: 16,
                                                color: context
                                                    .colorScheme.onPrimary,
                                              ),
                                            ),
                                          ),
                                        )
                                      : ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: notifications.length,
                                          itemBuilder: (context, index) {
                                            final notification =
                                                notifications[index];
                                            return Container(
                                              width: 1.sw,
                                              color: notification.isNew
                                                  ? AppColor.lightGrey
                                                      .withOpacity(0.2)
                                                  : context.colorScheme.primary,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(15),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    cubit
                                                        .navigateToRelatedScreen(
                                                      notification.screen,
                                                      notification.screenParams,
                                                    );
                                                  },
                                                  child: Row(
                                                    children: [
                                                      CircleAvatar(
                                                        radius: 24.w,
                                                        backgroundColor:
                                                            AppColor.lightGrey
                                                                .withOpacity(
                                                                    0.1),
                                                        child: Icon(
                                                          Icons.notifications,
                                                          color: context
                                                              .colorScheme
                                                              .onPrimary,
                                                        ),
                                                      ),
                                                      10.horizontalSpace,
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  notification
                                                                          .title ??
                                                                      "",
                                                                  style: Styles
                                                                      .boldStyle(
                                                                    family: FontFamily
                                                                        .varela,
                                                                    fontSize:
                                                                        16,
                                                                    color: context
                                                                        .colorScheme
                                                                        .onPrimary,
                                                                  ),
                                                                ),
                                                                const Spacer(),
                                                                Text(
                                                                  formatDate(notification
                                                                          .createdAt ??
                                                                      DateTime
                                                                          .now()),
                                                                  style: Styles
                                                                      .mediumStyle(
                                                                    family: FontFamily
                                                                        .varela,
                                                                    fontSize:
                                                                        12,
                                                                    color: context
                                                                        .colorScheme
                                                                        .onPrimary
                                                                        .withOpacity(
                                                                            0.8),
                                                                  ),
                                                                ),
                                                                5.horizontalSpace,
                                                              ],
                                                            ),
                                                            2.verticalSpace,
                                                            Text(
                                                              notification
                                                                      .description ??
                                                                  "",
                                                              style: Styles
                                                                  .mediumStyle(
                                                                family:
                                                                    FontFamily
                                                                        .varela,
                                                                fontSize: 14,
                                                                color: context
                                                                    .colorScheme
                                                                    .onPrimary
                                                                    .withOpacity(
                                                                        0.7),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                              if (!state.isScrolled && state.isLoaded)
                                const Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Indicator(),
                                ),
                            ],
                          )),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
