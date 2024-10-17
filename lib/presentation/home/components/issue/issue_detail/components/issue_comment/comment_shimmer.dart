import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../helpers/widgets/shimmer_effect.dart';

class CommentShimmer extends StatelessWidget {
  const CommentShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 4,
        reverse: true,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 5, 5),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 12,
                  child: ShimmerEffect(),
                ),
                5.horizontalSpace,
                Expanded(
                  child:
                      SizedBox(height: 0.05.sh, child: const ShimmerEffect()),
                ),
              ],
            ),
          );
        });
  }
}
