import 'dart:ui';

import 'package:flutter/material.dart';

class CommonGlass extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? colorBlur;
  final double radius;
  final double blur;
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
    this.colorBlur = Colors.transparent,
    this.borderWidth = 1.5,
    this.maskFilter = 1,
    this.paddingChild = 0.0,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width, // null sẽ chiếm toàn bộ không gian ngang
      height: height, // null sẽ chiếm toàn bộ không gian dọc
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Stack(
          children: [
            // Frosted blur
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: blur,
                sigmaY: blur,
              ),
              child: Container(
                color: colorBlur,
                width: double.infinity, // Chiếm toàn bộ chiều ngang
                height: double.infinity, // Chiếm toàn bộ chiều dọc
              ),
            ),

            // Gradient corner border painter
            Positioned.fill(
              child: CustomPaint(
                painter: CornerBorderPainter(
                  radius: radius,
                  borderWidth: borderWidth,
                  maskFilter: maskFilter,
                ),
              ),
            ),

            // Content
            Center(child: Padding(
              padding: EdgeInsets.all(paddingChild),
              child: child,
            )),
          ],
        ),
      ),
    );
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