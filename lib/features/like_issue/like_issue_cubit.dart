import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masla_bolo_app/domain/entities/issue_entity.dart';
import 'package:masla_bolo_app/features/home/components/issue/issue_detail/issue_detail_initial_params.dart';

import '../../domain/repositories/issue_repository.dart';
import 'like_issue_navigator.dart';
import 'like_issue_state.dart';

class LikeIssueCubit extends Cubit<LikeIssueState> {
  final LikeIssueNavigator navigation;

  final IssueRepository issueRepository;
  LikeIssueCubit(this.navigation, this.issueRepository)
      : super(LikeIssueState.empty());

  getLikedIssues() {
    issueRepository.likedIssues().then((issues) {
      emit(state.copyWith(
        issues: issues,
        isLoaded: true,
      ));
    });
  }

  void goToIssueDetail(IssueEntity issue) {
    navigation.goToIssueDetail(IssueDetailInitialParams(issue: issue));
  }
}
