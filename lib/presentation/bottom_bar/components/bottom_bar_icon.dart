import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:masla_bolo_app/domain/entities/user_entity.dart';
import 'package:masla_bolo_app/domain/stores/user_store.dart';
import 'package:masla_bolo_app/helpers/widgets/shimmer_effect.dart';
import 'package:masla_bolo_app/presentation/notification/notification_cubit.dart';
import 'package:masla_bolo_app/presentation/notification/notification_state.dart';

import '../../../di/service_locator.dart';
import '../../../helpers/widgets/rounded_image.dart';
import 'bottom_bar_item.dart';
import '../../../helpers/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bottom_bar_cubit.dart';
import '../bottom_bar_state.dart';

class BottomBarIcon extends StatelessWidget {
  const BottomBarIcon({
    super.key,
    required this.item,
    required this.index,
    required this.cubit,
  });
  final BottomBarItem item;
  final int index;
  final BottomBarCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomBarCubit, BottomBarState>(
        bloc: cubit,
        builder: (context, state) {
          bool isSelected = state.currentIndex == index;
          bool profileIndex = state.items.length - 1 == index;
          bool notificationIndex = state.items.length - 2 == index;
          return GestureDetector(
            onTap: () => cubit.updateIndex(index),
            child: profileIndex
                ? BlocBuilder(
                    bloc: getIt<UserStore>(),
                    builder: (context, userState) {
                      return FutureBuilder(
                          future: getIt<UserStore>().getUser(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final user = snapshot.data as UserEntity;
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                padding: const EdgeInsets.all(1.5),
                                child: RoundedImage(
                                  imageUrl: user.image,
                                  iconText: user.username,
                                  radius: 13.w,
                                  color: isSelected
                                      ? context.colorScheme.onPrimary
                                      : context.colorScheme.secondary
                                          .withOpacity(0.6),
                                ),
                              );
                            }
                            return ShimmerEffect(
                              borderRadius: BorderRadius.circular(13.w),
                            );
                          });
                    })
                : notificationIndex
                    ? BlocBuilder<NotificationCubit, NotificationState>(
                        bloc: getIt<NotificationCubit>(),
                        builder: (context, notificationState) {
                          final count = notificationState.seenCount;
                          return Badge.count(
                            padding: const EdgeInsets.all(0),
                            count: count,
                            isLabelVisible: count > 0,
                            child: SvgPicture.asset(
                              item.image,
                              height: 25,
                              colorFilter: ColorFilter.mode(
                                isSelected
                                    ? context.colorScheme.onPrimary
                                    : context.colorScheme.secondary
                                        .withOpacity(0.6),
                                BlendMode.srcIn,
                              ),
                            ),
                          );
                        })
                    : SvgPicture.asset(
                        item.image,
                        height: 25,
                        colorFilter: ColorFilter.mode(
                          isSelected
                              ? context.colorScheme.onPrimary
                              : context.colorScheme.secondary.withOpacity(0.6),
                          BlendMode.srcIn,
                        ),
                      ),
          );
        });
  }
}
