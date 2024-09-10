import 'package:flutter/material.dart';
import 'package:masla_bolo_app/helpers/helpers.dart';

import '../../../helpers/styles/app_colors.dart';
import '../../../helpers/widgets/header.dart';
import '../home_cubit.dart';

class HomeFilterDrawer extends StatelessWidget {
  const HomeFilterDrawer({super.key, required this.cubit});
  final HomeCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Header(
                title: "Apply Filters",
                onBackTap: () {
                  Scaffold.of(context).closeEndDrawer();
                },
                suffix: ElevatedButton(
                    onPressed: () {},
                    child: const Center(
                      child: Text("Apply"),
                    )),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  padding: scrollBottomPadding,
                  itemCount: 20,
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
            ),
          ],
        ),
      ),
    );
  }
}
