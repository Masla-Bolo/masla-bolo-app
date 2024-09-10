import 'package:flutter/material.dart';
import 'package:masla_bolo_app/features/issue/components/issue_detail/issue_detail_cubit.dart';

class IssueDetail extends StatelessWidget {
  const IssueDetail({super.key, required this.cubit});
  final IssueDetailCubit cubit;
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
          child: Column(
        children: [],
      )),
    );
  }
}
