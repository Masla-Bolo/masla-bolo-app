import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masla_bolo_app/main.dart';
import 'package:masla_bolo_app/presentation/home/components/issue/issue_helper.dart';
import 'package:masla_bolo_app/presentation/profile/components/official_profile/official_profile_event.dart';
import 'package:masla_bolo_app/presentation/profile/components/official_profile/official_profile_state.dart';

import '../../../../di/service_locator.dart';
import '../../../../domain/entities/issue_entity.dart';
import '../../../../domain/model/issue_json.dart';
import '../../../../domain/stores/user_store.dart';
import '../../../home/components/issue/issue_detail/issue_detail_initial_params.dart';
import '../../profile_navigator.dart';
import '../base_profile/base_profile_issues_service.dart';

class OfficialProfileCubit extends Cubit<OfficialProfileState> {
  BaseProfileIssuesService baseProfileIssuesService;
  ProfileNavigator navigation;

  OfficialProfileCubit(this.navigation, this.baseProfileIssuesService)
      : super(OfficialProfileState.empty());

  Future<void> onInit() async {
    final user = getIt<UserStore>().appUser;
    emit(state.copyWith(user: user));
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

  updateStatus(
    TabController controller,
    IssueEntity issue,
    IssueStatus status,
  ) {
    issue.status = status;
    final value = IssueHelper.getValue(issue.status, officialStatus);
    for (var value in state.allIssues.values) {
      value.issues.results.removeWhere((item) => item.id == issue.id);
    }
    final newStatusList = state.allIssues[issue.status]?.issues.results;
    if (newStatusList != null) {
      newStatusList.insert(0, issue);
    }
    // Api call to update the status here!!
    emit(state.copyWith(allIssues: state.allIssues));
    if (value >= 0 && value < controller.length) {
      controller.animateTo(value);
    }
  }

  void onLongPressIssue(IssueEntity issue) {
    emit(state.copyWith(
      selectionEnabled: !state.selectionEnabled,
    ));
  }

  void disableIssueSelection() {
    state.allIssues.map((key, val) {
      final value = val.issues.results.map((issue) {
        issue.selected = false;
        return issue;
      });
      return MapEntry(key, value);
    });
    emit(state.copyWith(selectionEnabled: false, allIssues: state.allIssues));
  }

  void toggleIssueSelection(IssueEntity issue) {
    issue.selected = !issue.selected;
    emit(state.copyWith(
      allIssues: state.allIssues,
    ));
  }
}
