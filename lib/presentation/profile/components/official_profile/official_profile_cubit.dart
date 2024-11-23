import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masla_bolo_app/main.dart';
import 'package:masla_bolo_app/presentation/profile/components/official_profile/official_profile_event.dart';
import 'package:masla_bolo_app/presentation/profile/components/official_profile/official_profile_state.dart';

import '../../../../domain/entities/issue_entity.dart';
import '../../../../domain/model/issue_json.dart';
import '../../../home/components/issue/issue_detail/issue_detail_initial_params.dart';
import '../../profile_navigator.dart';
import '../base_profile/base_profile_issues_service.dart';

class OfficialProfileCubit extends Cubit<OfficialProfileState> {
  BaseProfileIssuesService baseProfileIssuesService;
  ProfileNavigator navigation;

  OfficialProfileCubit(this.navigation, this.baseProfileIssuesService)
      : super(OfficialProfileState.empty());

  Future<void> onInit() async {
    eventBus.on<OfficialProfileEvent>().listen((issue) {
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
