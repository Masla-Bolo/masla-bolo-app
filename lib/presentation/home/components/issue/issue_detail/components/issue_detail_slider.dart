import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../domain/entities/issue_entity.dart';

import '../../../../../../helpers/widgets/cached_image.dart';

class IssueDetailSlider extends StatelessWidget {
  const IssueDetailSlider(
      {super.key, required this.onTap, required this.issue});
  final void Function(int index) onTap;
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
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: GestureDetector(
                    onLongPress: () {
                      onTap.call(index);
                    },
                    onTap: () {
                      onTap.call(index);
                    },
                    child: SizedBox(
                        width: 0.85.sw,
                        child: Center(
                          child: CachedImage(
                            image: image,
                          ),
                        )),
                  ),
                ),
              );
            }));
  }
}
