import 'package:flutter/material.dart';

import '../../../helpers/styles/app_colors.dart';
import '../home_cubit.dart';

class HomeFilter extends StatelessWidget {
  const HomeFilter({super.key, required this.cubit});
  final HomeCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColor.black1),
                ),
                child: Center(child: Text("Filter ${index + 1}")),
              ),
            );
          }),
    );
  }
}
