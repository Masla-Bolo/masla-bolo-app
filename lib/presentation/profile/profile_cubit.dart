import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/issue_entity.dart';
import '../../domain/model/paginate.dart';
import '../../domain/repositories/issue_repository.dart';
import '../../domain/stores/user_store.dart';
import '../home/components/issue/issue_detail/issue_detail_initial_params.dart';
import 'profile_navigator.dart';
import 'profile_state.dart';

import '../../di/service_locator.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileNavigator navigation;
  final IssueRepository issueRepository;
  ProfileCubit(this.navigation, this.issueRepository)
      : super(ProfileState.empty());

  getUser() {
    if (state.user.id == null) {
      getIt<UserStore>().getUser().then((user) => {
            if (user == null)
              {
                // fetch profile api here
              }
            else
              {emit(state.copyWith(user: user))}
          });
    }
  }

  goToSettings() {
    navigation.goToSettings();
  }

  appendToPendingIssues(IssueEntity issue) {
    state.allIssues["not_approved"]!.issues.results.insert(0, issue);
    emit(state.copyWith(allIssues: state.allIssues));
  }

  getAllIssues() async {
    await Future.wait(
      state.allIssues.keys.map((key) {
        return getMyIssues(status: key);
      }).toList(),
    ).then((_) {
      emit(state.copyWith(isAllIssuesLoaded: true));
    });
  }

  Future<void> getMyIssues({
    required String status,
    String url = "/issues/my/",
    bool clearAll = false,
  }) async {
    final issue = state.allIssues[status]!.copyWith(isScrolled: false);
    state.allIssues[status] = issue;
    emit(state.copyWith(allIssues: state.allIssues));
    final issues = state.allIssues[status]!.issues;
    if (clearAll && status.isNotEmpty) {
      issues.results.clear();
    }

    final apiUrl =
        issues.next != null && !clearAll ? issues.next.toString() : url;

    final issuesPagination = await issueRepository.getIssues(
      url: apiUrl,
      queryParams: {"issue_status": status},
      previousIssues: issues.results,
    );

    distributeIssues(issuesPagination, status);
  }

  void distributeIssues(Paginate<IssueEntity> result, String status) {
    final issue = state.allIssues[status]!.copyWith(
      issues: result,
      isLoaded: true,
      isScrolled: true,
    );
    state.allIssues[status] = issue;
    emit(state.copyWith(allIssues: state.allIssues));
  }

  goToIssueDetail(IssueEntity issue) {
    navigation.goToIssueDetail(IssueDetailInitialParams(issue: issue));
  }

  refreshIssues(String status) {
    final issue = state.allIssues[status]!.copyWith(isLoaded: false);
    state.allIssues[status] = issue;
    emit(state.copyWith(allIssues: state.allIssues));
    getMyIssues(clearAll: true, status: status);
  }

  scrollAndCall(String status) {
    final result = state.allIssues[status]!;
    if (result.issues.next != null && (result.isScrolled == true)) {
      getMyIssues(status: status);
    }
  }
}
