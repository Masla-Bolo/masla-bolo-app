import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../helpers/extensions.dart';
import '../../../../../helpers/widgets/shimmer_effect.dart';

class IssuePostShimmer extends StatelessWidget {
  const IssuePostShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colorScheme.primary,
      child: Column(
        children: [
          Center(
            child: SizedBox(
                height: 200,
                width: 1.sw,
                child: const ShimmerEffect(
                  borderRadius: BorderRadius.zero,
                )),
          ),
          10.verticalSpace,
          Container(
            padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 0.025.sh,
                  width: 0.7.sw,
                  child: const ShimmerEffect(),
                ),
                20.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 0.015.sh,
                      width: 0.2.sw,
                      child: const ShimmerEffect(),
                    ),
                    5.horizontalSpace,
                    Text(
                      "•",
                      style: TextStyle(
                        color: context.colorScheme.onPrimary,
                      ),
                    ),
                    5.horizontalSpace,
                    SizedBox(
                      width: 0.2.sw,
                      height: 0.015.sh,
                      child: const ShimmerEffect(),
                    ),
                    5.horizontalSpace,
                    Text(
                      "•",
                      style: TextStyle(
                        color: context.colorScheme.onPrimary,
                      ),
                    ),
                    5.horizontalSpace,
                    SizedBox(
                      width: 0.2.sw,
                      height: 0.015.sh,
                      child: const ShimmerEffect(),
                    ),
                    5.horizontalSpace,
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
