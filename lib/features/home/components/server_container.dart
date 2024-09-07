import 'package:flutter/widgets.dart';

import '../../../helpers/styles/app_colors.dart';

class ServerContainer extends StatelessWidget {
  const ServerContainer({
    super.key,
    required this.isSelected,
    required this.content,
  });
  final bool isSelected;
  final Widget content;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: const EdgeInsets.all(5),
            width: 5,
            height: isSelected ? 50 : 10,
            decoration: const BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                )),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: AppColor.lightGrey,
              padding: const EdgeInsets.all(5),
              child: Center(
                child: content,
              ),
            ),
          ),
        )
      ],
    );
  }
}
