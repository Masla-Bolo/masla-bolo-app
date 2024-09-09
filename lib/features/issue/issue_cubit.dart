import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masla_bolo_app/features/issue/issue_navigator.dart';
import 'package:masla_bolo_app/features/issue/issue_state.dart';
import 'package:masla_bolo_app/helpers/image_helper.dart';

class IssueCubit extends Cubit<IssueState> {
  final IssueNavigator navigator;
  final ImageHelper imageHelper;
  IssueCubit(this.navigator, this.imageHelper) : super(IssueState.empty());
  void goBack() {
    navigator.navigation.pop(navigator.context);
  }

  Future<void> showOptions(BuildContext context) async {
    final image = await imageHelper.showOptions(context);
    if (image != null) {}
  }
}
