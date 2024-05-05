import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class DashedBorderContainer extends StatelessWidget {
  final Widget child;
  final Color color;
  final double width;
  final double height;
  final double strokeWidth;
  final double gap;
  final double dashLength;
  final BorderRadius? borderRadius;

  const DashedBorderContainer({
    required this.child,
    this.color = Colors.black,
    this.width = 1.0,
    this.height = 1.0,
    this.strokeWidth = 1.0,
    this.gap = 5.0,
    this.dashLength = 5.0,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.transparent, // Color de fondo del contenedor
            width: strokeWidth,
          ),
        ),
        child: CustomPaint(
          size: Size(width, height),
          painter: DashedBorderPainter(
            color: color,
            strokeWidth: strokeWidth,
            gap: gap,
            dashLength: dashLength,
          ),
          child: child,
        ),
      ),
    );
  }
}

class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gap;
  final double dashLength;
  final BorderRadius? borderRadius;

  DashedBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.gap,
    required this.dashLength,
    this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final double halfStrokeWidth = strokeWidth / 2;

    final double topLeftRadiusX = borderRadius?.topLeft.x ?? 0;
    final double topLeftRadiusY = borderRadius?.topLeft.y ?? 0;
    final double topRightRadiusX = borderRadius?.topRight.x ?? 0;
    final double topRightRadiusY = borderRadius?.topRight.y ?? 0;
    final double bottomLeftRadiusX = borderRadius?.bottomLeft.x ?? 0;
    final double bottomLeftRadiusY = borderRadius?.bottomLeft.y ?? 0;
    final double bottomRightRadiusX = borderRadius?.bottomRight.x ?? 0;
    final double bottomRightRadiusY = borderRadius?.bottomRight.y ?? 0;

    // Dibujar las líneas segmentadas en la parte superior
    double startX = 0;
    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, halfStrokeWidth),
        Offset(startX + dashLength, halfStrokeWidth),
        paint,
      );
      startX += dashLength + gap;
    }

    // Dibujar las líneas segmentadas en la parte inferior
    startX = 0;
    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, size.height - halfStrokeWidth),
        Offset(startX + dashLength, size.height - halfStrokeWidth),
        paint,
      );
      startX += dashLength + gap;
    }

    // Dibujar las líneas segmentadas en el lado izquierdo
    double startY = 0;
    while (startY < size.height) {
      canvas.drawLine(
        Offset(halfStrokeWidth, startY),
        Offset(halfStrokeWidth, startY + dashLength),
        paint,
      );
      startY += dashLength + gap;
    }

    // Dibujar las líneas segmentadas en el lado derecho
    startY = 0;
    while (startY < size.height) {
      canvas.drawLine(
        Offset(size.width - halfStrokeWidth, startY),
        Offset(size.width - halfStrokeWidth, startY + dashLength),
        paint,
      );
      startY += dashLength + gap;
    }

    // Dibujar las líneas segmentadas en los bordes redondeados
    canvas.drawArc(
      Rect.fromLTWH(0, 0, topLeftRadiusX * 2, topLeftRadiusY * 2),
      -pi,
      -pi / 2,
      false,
      paint,
    );
    canvas.drawArc(
      Rect.fromLTWH(size.width - topRightRadiusX * 2, 0, topRightRadiusX * 2,
          topRightRadiusY * 2),
      -pi / 2,
      -pi / 2,
      false,
      paint,
    );
    canvas.drawArc(
      Rect.fromLTWH(
          size.width - bottomRightRadiusX * 2,
          size.height - bottomRightRadiusY * 2,
          bottomRightRadiusX * 2,
          bottomRightRadiusY * 2),
      0,
      -pi / 2,
      false,
      paint,
    );
    canvas.drawArc(
      Rect.fromLTWH(0, size.height - bottomLeftRadiusY * 2,
          bottomLeftRadiusX * 2, bottomLeftRadiusY * 2),
      -pi * 3 / 2,
      -pi / 2,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
