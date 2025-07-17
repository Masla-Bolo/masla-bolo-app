import 'package:flutter/material.dart';

import '../../../helpers/styles/app_colors.dart';

class MapLoadingOverlay extends StatelessWidget {
  const MapLoadingOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.darkBlue.withOpacity(0.8),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColor.darkBlueGrey,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppColor.black1.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColor.blueGrey),
                strokeWidth: 3,
              ),
              SizedBox(height: 16),
              Text(
                'Loading issues...',
                style: TextStyle(
                  color: AppColor.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
