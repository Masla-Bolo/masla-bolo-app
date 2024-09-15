import 'package:masla_bolo_app/features/home/home_navigator.dart';
import 'package:masla_bolo_app/features/home/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masla_bolo_app/features/issue/components/issue_detail/issue_detail_initial_params.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeNavigator navigation;
  HomeCubit(this.navigation) : super(HomeState.empty());

  pop() {
    navigation.pop();
  }

  goToIssueDetail({bool showComment = false}) {
    navigation
        .goToIssueDetail(IssueDetailInitialParams(showComment: showComment));
  }
}
