import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/issue_entity.dart';
import '../home/components/issue/issue_detail/issue_detail_initial_params.dart';

import '../../domain/repositories/issue_repository.dart';
import 'like_issue_navigator.dart';
import 'like_issue_state.dart';

class LikeIssueCubit extends Cubit<LikeIssueState> {
  final LikeIssueNavigator navigation;

  final IssueRepository issueRepository;
  LikeIssueCubit(this.navigation, this.issueRepository)
      : super(LikeIssueState.empty());

  getLikedIssues({
    bool clearAll = false,
    String url = "/issues/liked_issues/",
  }) async {
    emit(state.copyWith(isScrolled: false));
    if (clearAll) {
      state.issuesPagination.results.clear();
    }
    final apiUrl = state.issuesPagination.next != null && !clearAll
        ? state.issuesPagination.next.toString()
        : url;

    issueRepository
        .getIssues(
          url: apiUrl,
          queryParams: state.queryParams,
          previousIssues: state.issuesPagination.results,
        )
        .then((response) => response.fold((error) {
              emit(state.copyWith(
                issuesPagination: null,
                isLoaded: true,
                isScrolled: true,
              ));
            }, (issuesPagination) {
              emit(state.copyWith(
                issuesPagination: issuesPagination,
                isLoaded: true,
                isScrolled: true,
              ));
            }));
  }

  refreshIssues() {
    emit(state.copyWith(isLoaded: false));
    getLikedIssues(clearAll: true);
  }

  scrollAndCall() {
    if (state.issuesPagination.next != null && state.isScrolled) {
      getLikedIssues();
    }
  }

  void goToIssueDetail(IssueEntity issue) {
    navigation.goToIssueDetail(IssueDetailInitialParams(issue: issue));
  }
}
