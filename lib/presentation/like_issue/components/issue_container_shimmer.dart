import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../helpers/extensions.dart';
import '../../../../../helpers/widgets/shimmer_effect.dart';

class IssueContainerShimmer extends StatelessWidget {
  const IssueContainerShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: context.colorScheme.onPrimary,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.verticalSpace,
              Row(
                children: [
                  SizedBox(
                      height: 0.01.sh,
                      width: 0.2.sw,
                      child: ShimmerEffect(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  const Spacer(),
                  SizedBox(
                      height: 0.01.sh,
                      width: 0.1.sw,
                      child: ShimmerEffect(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ],
              ),
              10.verticalSpace,
              SizedBox(
                  height: 0.01.sh,
                  width: 0.25.sw,
                  child: ShimmerEffect(
                    borderRadius: BorderRadius.circular(10),
                  )),
              10.verticalSpace,
              SizedBox(
                  height: 0.01.sh,
                  width: 0.3.sw,
                  child: ShimmerEffect(
                    borderRadius: BorderRadius.circular(10),
                  )),
              10.verticalSpace,
              SizedBox(
                  height: 0.01.sh,
                  width: 0.6.sw,
                  child: ShimmerEffect(
                    borderRadius: BorderRadius.circular(10),
                  )),
              10.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
