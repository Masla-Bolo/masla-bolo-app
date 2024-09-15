import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masla_bolo_app/features/issue/components/issue_detail/issue_detail_initial_params.dart';
import 'package:masla_bolo_app/helpers/image_helper.dart';

import 'issue_detail_navigator.dart';
import 'issue_detail_state.dart';

class IssueDetailCubit extends Cubit<IssueDetailState> {
  final IssueDetailInitialParams params;
  final IssueDetailNavigator navigator;
  final ImageHelper imageHelper;
  IssueDetailCubit(this.params, this.navigator, this.imageHelper)
      : super(IssueDetailState.empty());
  void goBack() {
    navigator.pop();
  }

  Future<void> showOptions(BuildContext context) async {
    final image = await imageHelper.showOptions(context);
    if (image != null) {}
  }
}
