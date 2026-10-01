import 'package:flutter/material.dart';

class ButtonPainter extends CustomPainter {
  final BuildContext context;
  final Color? color;
  final bool isEnabled;

  ButtonPainter(this.context, {this.color, this.isEnabled = true});

  @override
  void paint(Canvas canvas, Size size) {
    final theme = Theme.of(context);
    final paintColor =
        color ?? (isEnabled ? theme.primaryColor : theme.disabledColor);

    final paint = Paint()
      ..color = paintColor
      ..style = PaintingStyle.fill;

    final path = Path();

    final w = size.width;
    final h = size.height;

    const sideRadius = 12.0;

    // Start after top-left corner
    path.moveTo(sideRadius, 0);

    // Top edge - very subtle curve
    path.cubicTo(w * 0.10, -1, w * 0.90, -1, w - sideRadius, 0);

    // Top-right corner
    path.quadraticBezierTo(w, 0, w, sideRadius);

    // Right side
    path.lineTo(w, h - sideRadius);

    // Bottom-right corner
    path.quadraticBezierTo(w, h, w - sideRadius, h);

    // Bottom edge - very subtle curve
    path.cubicTo(w * 0.90, h + 1, w * 0.10, h + 1, sideRadius, h);

    // Bottom-left corner
    path.quadraticBezierTo(0, h, 0, h - sideRadius);

    // Left side
    path.lineTo(0, sideRadius);

    // Top-left corner
    path.quadraticBezierTo(0, 0, sideRadius, 0);

    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant ButtonPainter oldDelegate) {
    return oldDelegate.context != context ||
        oldDelegate.color != color ||
        oldDelegate.isEnabled != isEnabled;
  }
}
