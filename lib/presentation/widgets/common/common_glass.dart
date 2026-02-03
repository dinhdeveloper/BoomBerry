import 'dart:ui';

import 'package:flutter/material.dart';

class CommonGlass extends StatelessWidget {
  final double? width;
  final double? height;
  final double radius;
  final double blur;
  final Color? colorBlur;
  final double borderWidth;
  final double maskFilter;
  final Widget child;
  final double paddingChild;

  const CommonGlass({
    super.key,
    this.width,
    this.height,
    this.radius = 10,
    this.blur = 20,
    this.colorBlur = Colors.white54,
    this.borderWidth = 1.5,
    this.maskFilter = 1,
    this.paddingChild = 0.0,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final glass = ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Stack(
        children: [
          /// NỀN GLASS → PHẢI FILL
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: colorBlur,
                borderRadius: BorderRadius.circular(radius),
                border: Border.all(
                  color: Colors.white.withOpacity(0.15),
                  width: borderWidth,
                ),
              ),
            ),
          ),

          /// Border
          Positioned.fill(
            child: CustomPaint(
              painter: CornerBorderPainter(
                radius: radius,
                borderWidth: borderWidth,
                maskFilter: maskFilter,
              ),
            ),
          ),

          /// Content
          Padding(
            padding: EdgeInsets.all(paddingChild),
            child: child,
          ),
        ],
      )
    );

    // ⭐ QUAN TRỌNG
    if (height != null || width != null) {
      return SizedBox(
        width: width,
        height: height,
        child: glass,
      );
    }

    // Không set height → min theo content
    return glass;
  }
}



class CornerBorderPainter extends CustomPainter {
  final double radius;
  final double borderWidth;
  final double maskFilter;

  CornerBorderPainter({
    required this.radius,
    required this.borderWidth,
    required this.maskFilter,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(radius));

    final path = Path()..addRRect(rrect);

    final baseShader = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Colors.white,
        Colors.white.withOpacity(0.1),
        Colors.white.withOpacity(0.1),
        Colors.white,
      ],
      stops: const [0.0, 0.30, 0.70, 1.0],
    ).createShader(rect);

    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth
      ..shader = baseShader
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, maskFilter);

    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(CornerBorderPainter oldDelegate) {
    return oldDelegate.radius != radius ||
        oldDelegate.borderWidth != borderWidth;
  }
}