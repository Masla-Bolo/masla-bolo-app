import 'package:flutter/material.dart';

import '../../../helpers/styles/app_colors.dart';

class MapSearchField extends StatelessWidget {
  final VoidCallback onTap;

  const MapSearchField({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: AppColor.black1.withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            const SizedBox(width: 16),
            const Icon(
              Icons.search,
              color: AppColor.lightGrey,
              size: 22,
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'Search locations...',
                style: TextStyle(
                  color: AppColor.lightGrey,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColor.blueGrey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.tune,
                color: AppColor.blueGrey,
                size: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
