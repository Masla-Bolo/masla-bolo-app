import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/features/notification/notification_cubit.dart';
import 'package:masla_bolo_app/features/notification/notification_state.dart';
import 'package:masla_bolo_app/helpers/styles/app_colors.dart';
import 'package:masla_bolo_app/helpers/styles/styles.dart';

import '../../helpers/widgets/header.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key, required this.cubit});
  final NotificationCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationCubit, NotificationState>(
        bloc: cubit,
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  10.verticalSpace,
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Header(
                      title: "Notifications",
                      hideBackIcon: true,
                    ),
                  ),
                  20.verticalSpace,
                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      itemCount: state.notifications.length,
                      separatorBuilder: (context, index) => Divider(
                        color: AppColor.black3.withOpacity(0.2),
                      ),
                      itemBuilder: (context, index) {
                        final notification = state.notifications[index];
                        return ListTile(
                          contentPadding: EdgeInsets.symmetric(vertical: 8.h),
                          leading: CircleAvatar(
                            radius: 24.w,
                            backgroundColor:
                                AppColor.lightGrey.withOpacity(0.1),
                            child: const Icon(
                              Icons.notifications,
                              color: AppColor.black1,
                            ),
                          ),
                          title: Text(
                            notification["title"]!,
                            style: Styles.boldStyle(
                              family: FontFamily.varela,
                              fontSize: 16,
                              color: AppColor.black1,
                            ),
                          ),
                          subtitle: Text(
                            notification["description"]!,
                            style: Styles.mediumStyle(
                              family: FontFamily.varela,
                              fontSize: 14,
                              color: AppColor.black2.withOpacity(0.7),
                            ),
                          ),
                          trailing: Text(
                            notification["time"]!,
                            style: Styles.mediumStyle(
                              family: FontFamily.varela,
                              fontSize: 12,
                              color: AppColor.black3.withOpacity(0.6),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
