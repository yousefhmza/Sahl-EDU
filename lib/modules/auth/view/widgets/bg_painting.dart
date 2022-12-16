import 'package:flutter/material.dart';

import '../../../../core/resources/resources.dart';

class BGPainting extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double height = size.height;
    final double width = size.width;
    final Paint paint = Paint()..color = AppColors.primaryDark.withOpacity(0.03);
    final Path path = Path();

    path.moveTo(0, 0);
    path.lineTo(0, height * 0.45);
    path.quadraticBezierTo(width * 0.6, height * 0.8, width * 0.6, height * 0.45);
    path.quadraticBezierTo(width * 0.65, height * 0.02, width, height * 0.25);
    path.lineTo(width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => oldDelegate != this;
}
