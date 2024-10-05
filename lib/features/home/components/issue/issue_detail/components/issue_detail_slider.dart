import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/domain/entities/issue_entity.dart';

import '../../../../../../helpers/widgets/cached_image.dart';

class IssueDetailSlider extends StatelessWidget {
  const IssueDetailSlider(
      {super.key, required this.onTap, required this.issue});
  final void Function() onTap;
  final IssueEntity issue;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 0.45.sh,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: issue.images.length,
            itemBuilder: (context, index) {
              final image = issue.images[index];
              return Padding(
                padding: const EdgeInsets.fromLTRB(0, 2, 2, 2),
                child: GestureDetector(
                  onTap: onTap,
                  child: Container(
                      height: 0.45.sh,
                      width: 1.sw,
                      padding: const EdgeInsets.all(5),
                      child: Center(
                        child: CachedImage(image: image),
                      )),
                ),
              );
            }));
  }
}
