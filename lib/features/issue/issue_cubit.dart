import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masla_bolo_app/features/issue/issue_navigator.dart';
import 'package:masla_bolo_app/features/issue/issue_state.dart';

class IssueCubit extends Cubit<IssueState> {
  final IssueNavigator navigator;
  IssueCubit(this.navigator) : super(IssueState.empty());

  void goBack() {
    navigator.navigation.pop(navigator.context);
  }
}
