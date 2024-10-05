import 'package:flutter_bloc/flutter_bloc.dart';
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

  getUser() async {
    if (state.user.id == null) {
      final user = await getIt<UserStore>().getUser();
      emit(state.copyWith(user: user));
    }
  }

  goToSettings() {
    navigation.goToSettings();
  }

  getMyIssues() {
    emit(
      state.copyWith(isLoaded: false),
    );
    issueRepository.myIssues(queryParams: {}).then((issues) => {
          emit(
            state.copyWith(
              issues: issues,
              isLoaded: true,
            ),
          ),
        });
  }
}
