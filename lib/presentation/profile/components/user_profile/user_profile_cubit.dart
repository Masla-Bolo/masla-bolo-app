import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masla_bolo_app/presentation/profile/components/user_profile/user_profile_state.dart';

import '../../../../domain/entities/issue_entity.dart';
import '../../../../domain/model/issue_json.dart';
import '../../../../main.dart';
import '../../../home/components/issue/issue_detail/issue_detail_initial_params.dart';
import '../../profile_navigator.dart';
import '../base_profile/base_profile_issues_service.dart';
import 'user_profile_event.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  BaseProfileIssuesService baseProfileIssuesService;
  ProfileNavigator navigation;
  UserProfileCubit(this.navigation, this.baseProfileIssuesService)
      : super(UserProfileState.empty());

  Future<void> onInit() async {
    eventBus.on<UserProfileEvent>().listen((issue) {
      final updatedIssue = issue.data;
      state.allIssues[issue.status] = updatedIssue;
      emit(state.copyWith(allIssues: state.allIssues));
    });

    baseProfileIssuesService.getAllIssues().then((_) {
      emit(state.copyWith(isAllIssuesLoaded: true));
    });
  }

  refreshIssues(IssueStatus status) {
    baseProfileIssuesService.refreshIssues(status);
  }

  scrollAndCall(IssueStatus status) {
    baseProfileIssuesService.scrollAndCall(status);
  }

  goToIssueDetail(IssueEntity issue) {
    navigation.goToIssueDetail(IssueDetailInitialParams(issueId: issue.id));
  }
}
