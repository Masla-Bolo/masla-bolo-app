import 'package:flutter/material.dart';
import 'package:masla_bolo_app/domain/entities/notification_entity.dart';
import 'package:masla_bolo_app/domain/model/paginate.dart';

class NotificationState {
  Paginate<NotificationEntity> pagination;
  bool isScrolled;
  bool isLoaded;
  ScrollController scrollController;
  int seenCount;
  NotificationState({
    required this.pagination,
    required this.scrollController,
    this.isScrolled = false,
    this.isLoaded = false,
    this.seenCount = 0,
  });

  copyWith({
    Paginate<NotificationEntity>? pagination,
    int? seenCount,
    bool? isScrolled,
    bool? isLoaded,
    ScrollController? scrollController,
  }) =>
      NotificationState(
        seenCount: seenCount ?? this.seenCount,
        scrollController: scrollController ?? this.scrollController,
        pagination: pagination ?? this.pagination,
        isScrolled: isScrolled ?? this.isScrolled,
        isLoaded: isLoaded ?? this.isLoaded,
      );

  factory NotificationState.empty() => NotificationState(
        pagination: Paginate<NotificationEntity>.empty(),
        scrollController: ScrollController(),
      );
}
