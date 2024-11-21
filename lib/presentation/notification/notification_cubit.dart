import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masla_bolo_app/domain/entities/notification_entity.dart';
import 'package:masla_bolo_app/domain/repositories/notification_repository.dart';
import '../../helpers/helpers.dart';
import 'notification_navigator.dart';

import 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationNavigator navigator;
  NotificationRepository notificationRepository;
  NotificationCubit(this.navigator, this.notificationRepository)
      : super(NotificationState.empty()) {
    _initScrollListener();
  }

  void _initScrollListener() {
    state.scrollController.addListener(_onScroll);
  }

  void updateSeenCount({bool clear = false}) {
    if (clear) {
      for (NotificationEntity notification in state.pagination.results) {
        notification.isNew = false;
      }
      emit(state.copyWith(seenCount: 0, pagination: state.pagination));
    } else {
      emit(state.copyWith(seenCount: 0));
    }
  }

  void _onScroll() {
    if (!state.scrollController.hasClients) return;
    final threshold = state.scrollController.position.maxScrollExtent * 0.2;
    if (state.scrollController.position.pixels >= threshold) {
      scrollAndCall();
    }
  }

  Future<void> getMyNotifications(
      {bool clearAll = false, String url = "/notifications/my/"}) async {
    emit(state.copyWith(isScrolled: false));
    if (clearAll && state.pagination.results.isNotEmpty) {
      state.pagination.results.clear();
    }

    final apiUrl = state.pagination.next != null && !clearAll
        ? state.pagination.next.toString()
        : url;

    notificationRepository
        .getMyNotifications(
          url: apiUrl,
          previousNotifications: state.pagination.results,
        )
        .then((response) => response.fold((error) {
              emit(state.copyWith(
                pagination: null,
                isLoaded: true,
                isScrolled: true,
              ));
              showToast(error.error);
            }, (pagination) {
              emit(state.copyWith(
                pagination: pagination,
                isLoaded: true,
                isScrolled: true,
              ));
            }));
  }

  void addNotification(NotificationEntity notification) {
    if (state.isLoaded) {
      state.pagination.results.insert(0, notification);
    }
    state.seenCount += 1;
    emit(state.copyWith(
        pagination: state.pagination, seenCount: state.seenCount));
  }

  void refreshIssues() {
    emit(state.copyWith(isLoaded: false));
    getMyNotifications(clearAll: true);
  }

  void scrollAndCall() {
    if (state.pagination.next != null && state.isScrolled) {
      getMyNotifications();
    }
  }

  void navigateToRelatedScreen(String routeName, Map<String, dynamic>? args) {
    navigator.push(routeName, args);
  }
}
