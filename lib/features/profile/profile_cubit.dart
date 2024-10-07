import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masla_bolo_app/domain/model/issue_json.dart';
import 'package:masla_bolo_app/domain/repositories/issue_repository.dart';
import 'package:masla_bolo_app/domain/stores/user_store.dart';
import 'package:masla_bolo_app/features/profile/profile_navigator.dart';
import 'package:masla_bolo_app/features/profile/profile_state.dart';
import 'package:masla_bolo_app/service/app_service.dart';

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

  getMyIssues({String? status}) {
    emit(
      state.copyWith(isLoaded: false),
    );
    return issueRepository.myIssues(queryParams: {
      "issue_status": status,
    }).then((issues) {
      state.issues["approved"] = issues.where((issue) {
        return issue.status == IssueStatus.approved;
      }).toList();
      state.issues["not_approved"] = issues.where((issue) {
        return issue.status == IssueStatus.notApproved;
      }).toList();
      state.issues["completed"] = issues
          .where((issue) => issue.status == IssueStatus.completed)
          .toList();
      if (status == null) {
      } else {
        state.issues[status] = issues;
      }
      emit(state.copyWith(
        isLoaded: true,
        issues: state.issues,
      ));
    });
  }
}
