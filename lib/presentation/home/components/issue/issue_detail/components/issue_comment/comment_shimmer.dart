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
                SizedBox(
                  height: 30,
                  width: 30,
                  child: ShimmerEffect(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                5.horizontalSpace,
                SizedBox(
                    height: 0.03.sh,
                    width: 0.8.sw,
                    child: ShimmerEffect(
                      borderRadius: BorderRadius.circular(20),
                    )),
              ],
            ),
          );
        });
  }
}
