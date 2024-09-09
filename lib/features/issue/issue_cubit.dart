import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masla_bolo_app/features/issue/issue_state.dart';

class IssueCubit extends Cubit<IssueState> {
  IssueCubit() : super(IssueState.empty());
}
