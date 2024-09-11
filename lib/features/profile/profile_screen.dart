import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/features/profile/profile_cubit.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.cubit});
  final ProfileCubit cubit;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileCubit cubit;
  @override
  void initState() {
    super.initState();
    cubit = widget.cubit;
    cubit.navigation.context = context;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SafeArea(
          child: Column(
            children: [
              10.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
