import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/features/explore/explore_cubit.dart';
import 'package:masla_bolo_app/features/explore/explore_state.dart';
import 'package:masla_bolo_app/helpers/extensions.dart';
import 'package:masla_bolo_app/helpers/styles/app_images.dart';
import 'package:masla_bolo_app/helpers/widgets/scroll_shader_mask.dart';

import '../../helpers/styles/styles.dart';
import '../../helpers/widgets/input_field.dart';

class ExplorePage extends StatefulWidget {
  final ExploreCubit cubit;

  const ExplorePage({
    super.key,
    required this.cubit,
  });

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  late final FocusNode focusNode;
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExploreCubit, ExploreState>(
        bloc: widget.cubit,
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  20.verticalSpace,
                  Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 35,
                              child: InputField(
                                borderRadius: 5,
                                focusNode: focusNode,
                                textEditingController: controller,
                                hintText: "find issues here..",
                                onChanged: (val) {
                                  widget.cubit.debounce(val);
                                },
                              ),
                            ),
                          ),
                          10.horizontalSpace,
                          GestureDetector(
                            onTap: () {
                              focusNode.requestFocus();
                            },
                            child: Image.asset(
                              AppImages.search,
                              color: context.colorScheme.onPrimary,
                              height: 30,
                            ),
                          ),
                          10.horizontalSpace,
                        ],
                      )),
                  20.verticalSpace,
                  Expanded(
                    child: ScrollShaderMask(
                      child: ListView.separated(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 10,
                        separatorBuilder: (context, index) => Divider(
                          color:
                              context.colorScheme.onSecondary.withOpacity(0.2),
                        ),
                        itemBuilder: (context, index) {
                          return ListTile(
                            contentPadding: EdgeInsets.symmetric(vertical: 8.h),
                            leading: CircleAvatar(
                              radius: 24.w,
                              backgroundColor: context.colorScheme.secondary
                                  .withOpacity(0.1),
                              child: Icon(
                                Icons.search,
                                color: context.colorScheme.onPrimary,
                              ),
                            ),
                            title: Text(
                              "title",
                              style: Styles.boldStyle(
                                family: FontFamily.varela,
                                fontSize: 16,
                                color: context.colorScheme.onPrimary,
                              ),
                            ),
                            subtitle: Text(
                              "description",
                              style: Styles.mediumStyle(
                                family: FontFamily.varela,
                                fontSize: 14,
                                color: context.colorScheme.onPrimary
                                    .withOpacity(0.7),
                              ),
                            ),
                            trailing: Text(
                              "time",
                              style: Styles.mediumStyle(
                                family: FontFamily.varela,
                                fontSize: 12,
                                color: context.colorScheme.onPrimary
                                    .withOpacity(0.8),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
