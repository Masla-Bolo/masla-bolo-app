import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/helpers/extensions.dart';
import 'package:masla_bolo_app/helpers/styles/styles.dart';
import '../../../../../helpers/widgets/indicator.dart';
import 'components/issue_detail_body.dart';
import 'components/issue_detail_footer.dart';
import 'issue_detail_cubit.dart';
import 'issue_detail_state.dart';

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
      cubit.stream.listen((state) {
        if (!state.issueLoading) {
          cubit.state.focusNode.requestFocus();
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
                              Row(
                                children: [
                                  10.horizontalSpace,
                                  GestureDetector(
                                    onTap: () {
                                      widget.cubit.goBack();
                                    },
                                    child: Icon(Icons.arrow_back_ios_new,
                                        size: 20,
                                        color: context.colorScheme.onPrimary),
                                  ),
                                  20.horizontalSpace,
                                  Expanded(
                                    child: Text(
                                      state.currentIssue.title,
                                      style: Styles.boldStyle(
                                        fontSize: 20,
                                        color: context.colorScheme.onPrimary,
                                        family: FontFamily.dmSans,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 50),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    state.currentIssue.isAnonymous
                                        ? "by an Anonymous user"
                                        : "by: ${state.currentIssue.user.username}",
                                    style: Styles.lightStyle(
                                      fontSize: 15,
                                      color: context.colorScheme.onPrimary,
                                      family: FontFamily.dmSans,
                                    ),
                                  ),
                                ),
                              ),
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
