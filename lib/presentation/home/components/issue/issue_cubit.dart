import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:masla_bolo_app/helpers/strings.dart';
import 'package:masla_bolo_app/service/permission_service.dart';
import '../../../../data/local_storage/local_storage_repository.dart';
import '../../../../domain/entities/issue_entity.dart';
import '../../../../domain/repositories/issue_repository.dart';
import '../../../../service/location_service.dart';
import '../../../../service/notification_service.dart';
import 'issue_navigator.dart';
import 'issue_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'issue_detail/issue_detail_initial_params.dart';
import '../../../../helpers/helpers.dart';
import '../../../../service/music_service.dart';

class IssueCubit extends Cubit<IssueState> {
  final IssueNavigator navigation;
  final IssueRepository issueRepository;
  final MusicService musicService;
  final NotificationService notificationService;
  final PermissionService permissionService;
  final LocationService locationService;
  final LocalStorageRepository localStorageRepository;

  IssueCubit(
    this.navigation,
    this.issueRepository,
    this.permissionService,
    this.localStorageRepository,
    this.musicService,
    this.locationService,
    this.notificationService,
  ) : super(IssueState.empty()) {
    _initScrollListener();
  }

  void _initScrollListener() {
    state.scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!state.scrollController.hasClients) return;
    final threshold = state.scrollController.position.maxScrollExtent * 0.2;
    if (state.scrollController.position.pixels >= threshold) {
      scrollAndCall();
    }
  }

  void initServices() {
    // if user is logged in and service is not initialized then only initilize the services.
    WidgetsBinding.instance.addPostFrameCallback((duration) {
      localStorageRepository
          .getValue(tokenKey)
          .then((result) => result.fold((error) {}, (value) {
                localStorageRepository.getValue(serviceInItKey).then(
                      (result) => result.fold(
                        (error) {
                          getPermission(callFcm: true);
                        },
                        (value) {
                          getPermission();
                        },
                      ),
                    );
              }));
    });
  }

  void getPermission({bool callFcm = false}) {
    permissionService.permissionServiceCall().then((_) {
      notificationService.initNotifications(callFcm: callFcm).then((_) {
        log("Notification Initialized");
        locationService.getLocation().then((_) {
          log("Location Initialized");
        });
      });
      localStorageRepository.setValue(
        serviceInItKey,
        "SERVICE_INIT",
      );
    });
  }

  Future<void> getIssues(
      {bool clearAll = false, String url = "/issues/"}) async {
    emit(state.copyWith(isScrolled: false));
    if (clearAll && state.issuesPagination.results.isNotEmpty) {
      state.issuesPagination.results.clear();
    }

    final apiUrl = state.issuesPagination.next != null && !clearAll
        ? state.issuesPagination.next.toString()
        : url;

    issueRepository
        .getIssues(
          url: apiUrl,
          previousIssues: state.issuesPagination.results,
        )
        .then((response) => response.fold((error) {
              emit(state.copyWith(
                issuesPagination: null,
                isLoaded: true,
                isScrolled: true,
              ));
              showToast(error.error);
            }, (issuesPagination) {
              emit(state.copyWith(
                issuesPagination: issuesPagination,
                isLoaded: true,
                isScrolled: true,
              ));
            }));
  }

  void refreshIssues() {
    emit(state.copyWith(isLoaded: false));
    getIssues(clearAll: true);
  }

  void scrollAndCall() {
    if (state.issuesPagination.next != null && state.isScrolled) {
      getIssues();
    }
  }

  void likeUnlikeIssue(IssueEntity issue) {
    issue.isLiked = !issue.isLiked;
    issue.likesCount += issue.isLiked ? 1 : -1;
    musicService.play(musicService.likeUnlikeMusic);
    emit(state.copyWith(issuesPagination: state.issuesPagination));
    issueRepository.likeUnlikeIssue(issue.id);
  }

  void increaseCommentCount(IssueEntity issue) {
    issue.commentsCount += 1;
    emit(state.copyWith(issuesPagination: state.issuesPagination));
  }

  void pop() => navigation.pop();

  void goToIssueDetail({bool showComment = false, required IssueEntity issue}) {
    navigation.goToIssueDetail(
        IssueDetailInitialParams(showComment: showComment, issueId: issue.id));
  }

  void toggleSeeMore(IssueEntity issue) {
    issue.seeMore = !issue.seeMore;
    emit(state.copyWith(issuesPagination: state.issuesPagination));
  }

  void scrollToTop() {
    if (state.scrollController.hasClients) {
      state.scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Future<void> close() {
    state.scrollController.dispose();
    return super.close();
  }

  void updateIndex(int index, IssueEntity issue) {
    state.issuesPagination.results.firstWhere((result) {
      return result.id == issue.id;
    }).currentIndex = index;
    emit(state.copyWith(issuesPagination: state.issuesPagination));
  }
}
