import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../helpers/widgets/indicator.dart';
import 'components/issue_detail_body.dart';
import 'components/issue_detail_footer.dart';
import 'issue_detail_cubit.dart';
import 'issue_detail_state.dart';
import '../../../../../helpers/widgets/header.dart';

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
    cubit.fetchIssueById();
    if (cubit.params.showComment) {
      cubit.state.focusNode.requestFocus();
      cubit.stream.listen((state) {
        if (!state.issueLoading) {
          if (scrollController.hasClients) {
            scrollController.animateTo(
              scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn,
            );
          }
        }
      });
    }
  }

  @override
  void dispose() {
    cubit.close();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IssueDetailCubit, IssueDetailState>(
        bloc: cubit,
        builder: (context, state) {
          final isIssueEmpty = state.currentIssue.id == 0;
          return Scaffold(
            body: SafeArea(
                child: state.issueLoading
                    ? const Center(
                        child: Indicator(),
                      )
                    : (!state.issueLoading && isIssueEmpty)
                        ? const Center(
                            child: Text("Unable to fetch the issue right now!"),
                          )
                        : Column(
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
