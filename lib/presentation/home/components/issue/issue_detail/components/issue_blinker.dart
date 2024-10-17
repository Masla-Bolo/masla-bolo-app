import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../domain/model/issue_json.dart';
import '../../issue_helper.dart';
import '../../../../../../helpers/extensions.dart';
import '../../../../../../helpers/styles/styles.dart';

import '../../../../../../helpers/widgets/blinking_widget.dart';

class IssueBlinker extends StatefulWidget {
  const IssueBlinker({
    super.key,
    required this.status,
  });
  final IssueStatus status;

  @override
  State<IssueBlinker> createState() => _IssueBlinkerState();
}

class _IssueBlinkerState extends State<IssueBlinker> {
  late Color color;

  @override
  void initState() {
    super.initState();
    color = IssueHelper.getIssueStatusColor(widget.status);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BlinkingWidget(
              child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          )),
          5.horizontalSpace,
          BlinkingWidget(
            child: Text(
              widget.status.name.capitalized(),
              style: Styles.boldStyle(
                fontSize: 15,
                color: color,
                family: FontFamily.dmSans,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
