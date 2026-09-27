import 'package:flutter/material.dart';

import '../../core/app_colors.dart';

/// Sky-to-navy gradient with lattice tower silhouettes, used behind the splash.
class TowerBackdrop extends StatelessWidget {
  const TowerBackdrop({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final h = constraints.maxHeight;
        final w = constraints.maxWidth;

        return Stack(
          fit: StackFit.expand,
          children: [
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFB9D3EE), Color(0xFFE9F1FA), Color(0xFFDDE8F5)],
                  stops: [0, 0.35, 0.6],
                ),
              ),
            ),
            Positioned(
              right: -w * 0.2,
              bottom: h * 0.18,
              width: w * 0.46,
              height: h * 0.78,
              child: CustomPaint(
                painter: _TowerPainter(color: AppColors.navy.withValues(alpha: 0.45)),
              ),
            ),
            Positioned(
              left: -w * 0.06,
              bottom: h * 0.22,
              width: w * 0.3,
              height: h * 0.42,
              child: CustomPaint(
                painter: _TowerPainter(color: AppColors.navy.withValues(alpha: 0.22)),
              ),
            ),
            // Navy fade that the role panel and button sit on.
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.navy.withValues(alpha: 0),
                    AppColors.navy.withValues(alpha: 0.55),
                    AppColors.navy,
                  ],
                  stops: const [0.45, 0.68, 1],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _TowerPainter extends CustomPainter {
  _TowerPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final stroke = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.012
      ..strokeCap = StrokeCap.round;
    final fill = Paint()..color = color;

    final cx = size.width / 2;
    final mastTop = 0.0;
    final towerTop = size.height * 0.14;
    final bottom = size.height;
    final baseHalf = size.width * 0.28;
    final topHalf = size.width * 0.05;

    double halfAt(double y) =>
        topHalf + (baseHalf - topHalf) * ((y - towerTop) / (bottom - towerTop));

    // Legs
    canvas.drawLine(Offset(cx - topHalf, towerTop), Offset(cx - baseHalf, bottom), stroke);
    canvas.drawLine(Offset(cx + topHalf, towerTop), Offset(cx + baseHalf, bottom), stroke);

    // Cross bracing
    const segments = 9;
    final bracing = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.006;
    for (var i = 0; i < segments; i++) {
      final y1 = towerTop + (bottom - towerTop) * i / segments;
      final y2 = towerTop + (bottom - towerTop) * (i + 1) / segments;
      final h1 = halfAt(y1);
      final h2 = halfAt(y2);
      canvas.drawLine(Offset(cx - h1, y1), Offset(cx + h2, y2), bracing);
      canvas.drawLine(Offset(cx + h1, y1), Offset(cx - h2, y2), bracing);
      canvas.drawLine(Offset(cx - h2, y2), Offset(cx + h2, y2), bracing);
    }

    // Mast
    canvas.drawLine(Offset(cx, mastTop), Offset(cx, towerTop), stroke);

    // Antenna panels
    final panelW = size.width * 0.05;
    final panelH = size.height * 0.07;
    for (final y in [towerTop * 0.55, towerTop + size.height * 0.06]) {
      for (final dx in [-1.0, 1.0]) {
        final x = cx + dx * (halfAt(y).clamp(topHalf, baseHalf) + panelW * 0.9);
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromCenter(center: Offset(x, y), width: panelW, height: panelH),
            Radius.circular(panelW * 0.3),
          ),
          fill,
        );
      }
    }

    // Microwave dishes
    final dishR = size.width * 0.055;
    for (final (dx, yf) in [(-1.0, 0.28), (1.0, 0.36), (-1.0, 0.44)]) {
      final y = size.height * yf;
      final x = cx + dx * (halfAt(y) + dishR * 0.9);
      canvas.drawCircle(Offset(x, y), dishR, fill);
    }
  }

  @override
  bool shouldRepaint(_TowerPainter oldDelegate) => oldDelegate.color != color;
}
