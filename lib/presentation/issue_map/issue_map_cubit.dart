import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masla_bolo_app/presentation/issue_map/issue_map_state.dart';
import '../../domain/repositories/issue_repository.dart' show IssueRepository;
import '../home/components/issue/issue_detail/issue_detail_initial_params.dart';
import 'issue_map_navigator.dart';

class IssueMapCubit extends Cubit<IssueMapState> {
  final IssueRepository issueRepository;
  final IssueMapNavigator navigator;

  IssueMapCubit(
    this.issueRepository,
    this.navigator,
  ) : super(IssueMapState.initial());

  Future<void> fetchIssues() async {
    emit(state.copyWith(isLoading: true));
    issueRepository.getIssuesCoordinates().then((response) => response.fold(
          (failure) {
            emit(state.copyWith(isLoading: false));
          },
          (issues) {
            emit(state.copyWith(issues: issues, isLoading: false));
          },
        ));
  }

  void goToSearchIssues() {
    navigator.goToSearchIssue();
  }

  void goToIssueDetail(int issueId) {
    navigator.goToIssueDetail(IssueDetailInitialParams(issueId: issueId));
  }
}
