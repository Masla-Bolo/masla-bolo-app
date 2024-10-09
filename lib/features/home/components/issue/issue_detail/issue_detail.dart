import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/features/home/components/issue/issue_detail/components/issue_detail_body.dart';
import 'package:masla_bolo_app/features/home/components/issue/issue_detail/components/issue_detail_footer.dart';
import 'package:masla_bolo_app/features/home/components/issue/issue_detail/issue_detail_cubit.dart';
import 'package:masla_bolo_app/features/home/components/issue/issue_detail/issue_detail_state.dart';
import 'package:masla_bolo_app/helpers/widgets/header.dart';

class IssueDetail extends StatefulWidget {
  const IssueDetail({super.key, required this.cubit});
  final IssueDetailCubit cubit;

  @override
  State<IssueDetail> createState() => _IssueDetailState();
}

class _IssueDetailState extends State<IssueDetail> {
  late IssueDetailCubit cubit;
  final scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    cubit = widget.cubit;
    cubit.fetchIssueComments();
    if (cubit.params.showComment) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        cubit.state.focusNode.requestFocus();
        if (scrollController.hasClients) {
          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeIn,
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IssueDetailCubit, IssueDetailState>(
        bloc: cubit,
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
                child: Column(
              children: [
                10.verticalSpace,
                Header(
                  title: state.currentIssue.title,
                  fontSize: 20,
                  onBackTap: () {
                    widget.cubit.goBack();
                  },
                ),
                10.verticalSpace,
                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: IssueDetailBody(cubit: cubit),
                  ),
                ),
                IssueDetailFooter(cubit: cubit),
              ],
            )),
          );
        });
  }
}
