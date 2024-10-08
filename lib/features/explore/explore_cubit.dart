import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/issue_repository.dart';
import '../../helpers/debouncer.dart';
import 'explore_navigator.dart';
import 'explore_state.dart';

class ExploreCubit extends Cubit<ExploreState> {
  final ExploreNavigator navigation;

  final IssueRepository issueRepository;
  ExploreCubit(this.navigation, this.issueRepository)
      : super(ExploreState.empty());

  final debouncer = Debouncer(delay: const Duration(seconds: 2));
  Map<String, dynamic> queryParams = {};
  getIssues({bool clearAll = false}) async {
    // emit(state.copyWith(isScrolled: false));
    if (clearAll) {
      // state.issuesPagination.results.clear();
    }

    // final url = state.issuesPagination.next != null && !clearAll
    //     ? state.issuesPagination.next.toString()
    //     : "/issues/";

    // final issuesPagination = await issueRepository.getIssues(
    //   url: url,
    //   queryParams: queryParams,
    //   previousIssues: state.issuesPagination.results,
    // );

    // emit(state.copyWith(
    //   issuesPagination: issuesPagination,
    //   isLoaded: true,
    //   isScrolled: true,
    // ));
  }

  debounce(String value) {
    if (value.isEmpty) {
      queryParams.remove("search");
      // emit(state.copyWith(isLoaded: false));
      getIssues(clearAll: true);
    } else {
      debouncer.call(() {
        // emit(state.copyWith(isLoaded: false));
        queryParams["search"] = value;
        getIssues(clearAll: true);
      });
    }
  }
}
