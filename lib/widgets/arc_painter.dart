import 'package:flutter/material.dart';

class ArcPainter extends CustomPainter {
  final Color arcColor;

  ArcPainter({required this.arcColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = arcColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14.0
      ..strokeCap = StrokeCap.round;

    final path = Path();
    path.moveTo(-size.width * 0.2, size.height * 0.3);
    path.quadraticBezierTo(
      size.width * 0.5, size.height * 0.85, 
      size.width * 1.2, size.height * 0.3
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant ArcPainter oldDelegate) {
    return oldDelegate.arcColor != arcColor;
  }
}
