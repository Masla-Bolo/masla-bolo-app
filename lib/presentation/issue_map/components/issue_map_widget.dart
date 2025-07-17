import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../../di/service_locator.dart';
import '../../../domain/entities/issue_coordinates_entity.dart';
import '../../../helpers/styles/app_colors.dart';
import '../issue_map_cubit.dart';
import '../issue_map_state.dart';
import 'issue_map_overlay.dart';
import 'issue_marker.dart';

class IssueMapWidget extends StatelessWidget {
  const IssueMapWidget({super.key});

  static final cubit = getIt<IssueMapCubit>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IssueMapCubit, IssueMapState>(
      bloc: cubit,
      builder: (context, state) {
        return Stack(
          children: [
            FlutterMap(
              options: const MapOptions(
                initialCenter: LatLng(24.8607, 67.0011),
                initialZoom: 11.0,
                minZoom: 5.0,
                maxZoom: 18.0,
                backgroundColor: AppColor.darkBlue,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.issue_tracker',
                  maxZoom: 18,
                ),
                MarkerLayer(
                  markers: state.issues.map((issue) {
                    return Marker(
                      point: LatLng(
                        issue.location.latitude,
                        issue.location.longitude,
                      ),
                      width: 40,
                      height: 40,
                      child: IssueMarker(
                        issue: issue,
                        onTap: () => _showIssueDetails(context, issue),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
            if (state.isLoading) const MapLoadingOverlay(),
          ],
        );
      },
    );
  }

  void _showIssueDetails(BuildContext context, IssueCoordinatesEntity issue) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColor.darkBlue,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle bar
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: AppColor.lightGrey,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Text(
              issue.title,
              style: const TextStyle(
                color: AppColor.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _getStatusColor(issue.status).withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: _getStatusColor(issue.status),
                  width: 1,
                ),
              ),
              child: Text(
                issue.status.toUpperCase(),
                style: TextStyle(
                  color: _getStatusColor(issue.status),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(
                  Icons.location_on,
                  color: AppColor.lightGrey,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '${issue.location.latitude.toStringAsFixed(6)}, ${issue.location.longitude.toStringAsFixed(6)}',
                    style: const TextStyle(
                      color: AppColor.lightGrey,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Attractive Button
            Container(
              width: double.infinity,
              height: 52,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColor.blueGrey,
                    AppColor.blueGrey.withOpacity(0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(26),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.blueGrey.withOpacity(0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    cubit.goToIssueDetail(issue.id);
                  },
                  borderRadius: BorderRadius.circular(26),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.visibility,
                          color: AppColor.white,
                          size: 20,
                        ),
                        SizedBox(width: 12),
                        Text(
                          'View Details',
                          style: TextStyle(
                            color: AppColor.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(
                          Icons.arrow_forward,
                          color: AppColor.white,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'APPROVED':
        return AppColor.red;
      case 'NOT_APPROVED':
        return AppColor.orange;
      case 'SOLVED':
        return AppColor.green;
      default:
        return AppColor.lightGrey;
    }
  }
}
