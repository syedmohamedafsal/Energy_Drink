import 'package:flutter/material.dart';

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 6.0, dashSpace = 4.0, startX = 0.0;
    final paint = Paint()
      ..color = Colors.black26
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
