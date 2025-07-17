import 'package:flutter/material.dart';
import '../../../domain/entities/issue_coordinates_entity.dart';
import '../../../helpers/styles/app_colors.dart';

class IssueMarker extends StatelessWidget {
  final IssueCoordinatesEntity issue;
  final VoidCallback onTap;

  const IssueMarker({
    super.key,
    required this.issue,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Shadow
          Transform.translate(
            offset: const Offset(2, 3),
            child: CustomPaint(
              size: const Size(40, 48),
              painter: MarkerPainter(
                color: Colors.black.withOpacity(0.3),
              ),
            ),
          ),
          // Main marker
          CustomPaint(
            size: const Size(40, 48),
            painter: MarkerPainter(
              color: _getStatusColor(issue.status),
            ),
          ),
          // Icon container
          Positioned(
            top: 6,
            child: Container(
              width: 28,
              height: 28,
              decoration: const BoxDecoration(
                color: AppColor.white,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  _getStatusIcon(issue.status),
                  size: 16,
                  color: _getStatusColor(issue.status),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return AppColor.red;
      case 'not_approved':
        return AppColor.orange;
      case 'solved':
        return AppColor.green;
      default:
        return AppColor.lightGrey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return Icons.error_outline;
      case 'not_approved':
        return Icons.hourglass_empty;
      case 'solved':
        return Icons.check_circle_outline;
      default:
        return Icons.help_outline;
    }
  }
}

class MarkerPainter extends CustomPainter {
  final Color color;

  MarkerPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final Path path = Path();

    // Create a teardrop/pin shape
    final double width = size.width;
    final double height = size.height;
    final double centerX = width / 2;
    final double circleRadius = width * 0.4;

    // Draw the circular top part
    path.addOval(Rect.fromCircle(
      center: Offset(centerX, circleRadius + 2),
      radius: circleRadius,
    ));

    // Draw the pointed bottom part
    path.moveTo(centerX - circleRadius * 0.3, circleRadius * 1.7);
    path.lineTo(centerX, height - 2);
    path.lineTo(centerX + circleRadius * 0.3, circleRadius * 1.7);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
