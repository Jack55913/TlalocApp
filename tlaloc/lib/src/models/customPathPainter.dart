import 'package:flutter/material.dart';

class CustomPathPainter extends CustomPainter {
  CustomPathPainter(
      {required this.color,
      required this.waterLevel,
      required this.maximumPoint});
  final Color color;
  final double waterLevel;
  final double maximumPoint;

  @override
  void paint(Canvas canvas, Size size) {
    final Path path = _buildTumblerPath(size.width, size.height);
    final double factor = size.height / maximumPoint;
    final double height = 2 * factor * waterLevel;
    final Paint strokePaint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    final Paint paint = Paint()..color = color;
    canvas.drawPath(path, strokePaint);
    final Rect clipper = Rect.fromCenter(
        center: Offset(size.width / 2, size.height),
        height: height,
        width: size.width);
    canvas.clipRect(clipper);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPathPainter oldDelegate) => true;
}

Path _buildTumblerPath(double width, double height) {
  return Path()
    ..lineTo(width, 0)
    ..lineTo(width * 0.75, height - 15)
    ..quadraticBezierTo(width * 0.74, height, width * 0.67, height)
    ..lineTo(width * 0.33, height)
    ..quadraticBezierTo(width * 0.26, height, width * 0.25, height - 15)
    ..close();
}