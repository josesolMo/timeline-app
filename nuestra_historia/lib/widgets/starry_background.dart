import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class StarryBackground extends StatefulWidget {
  final double progress;

  const StarryBackground({super.key, required this.progress});

  @override
  State<StarryBackground> createState() => _StarryBackgroundState();
}

class _StarryBackgroundState extends State<StarryBackground>
    with SingleTickerProviderStateMixin {
  late final Ticker _ticker;
  double _timeSeconds = 0;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker((elapsed) {
      setState(() {
        _timeSeconds = elapsed.inMilliseconds / 1000.0;
      });
    })..start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gradient = LinearGradient.lerp(
      const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF4A0B4F),
          Color(0xFF7A2FA0),
          Color(0xFFFF9E66),
        ],
      ),
      const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF04122F),
          Color(0xFF0B1E4B),
          Color(0xFF0E2D6A),
        ],
      ),
      widget.progress.clamp(0.0, 1.0),
    );

    return Stack(
      fit: StackFit.expand,
      children: [
        DecoratedBox(decoration: BoxDecoration(gradient: gradient)),
        CustomPaint(
          painter: _StarryPainter(
            widget.progress,
            _timeSeconds,
          ),
        ),
      ],
    );
  }
}

class _StarryPainter extends CustomPainter {
  final double progress;
  final double timeSeconds;

  _StarryPainter(this.progress, this.timeSeconds);

  static final List<_Star> _stars = _generateStars();
  static const List<_Cloud> _clouds = [
    _Cloud(Offset(0.2, 0.18), 170),
    _Cloud(Offset(0.62, 0.3), 120),
    _Cloud(Offset(0.35, 0.5), 190),
    _Cloud(Offset(0.78, 0.62), 140),
    _Cloud(Offset(0.28, 0.78), 160),
  ];

  static List<_Star> _generateStars() {
    final random = Random(42);
    return List.generate(110, (index) {
      return _Star(
        Offset(random.nextDouble(), random.nextDouble()),
        0.7 + random.nextDouble() * 1.4,
        0.6 + random.nextDouble() * 0.4,
        random.nextDouble() * 2 * pi,
      );
    });
  }

  @override
  void paint(Canvas canvas, Size size) {
    final clamped = progress.clamp(0.0, 1.0);
    final visibleCount = (18 + (80 * clamped)).round();
    final starPaint = Paint();
    final rayPaint = Paint()
      ..strokeWidth = 1.2
      ..strokeCap = StrokeCap.round;

    for (var i = 0; i < visibleCount; i++) {
      final star = _stars[i];
      final position = Offset(star.position.dx * size.width, star.position.dy * size.height);
      final shimmer = 0.6 + 0.4 * sin((timeSeconds * 1.2 * pi) + star.phase);
      final opacity = (0.45 + (0.55 * clamped)) * star.twinkle * shimmer;
      starPaint.color = Colors.white.withOpacity(opacity);
      canvas.drawCircle(position, star.radius, starPaint);

      if (clamped > 0.2) {
        final rayAlpha = (opacity * 0.6).clamp(0.0, 0.6);
        rayPaint.color = Colors.white.withOpacity(rayAlpha);
        final ray = star.radius * (1.6 + shimmer * 1.8);
        canvas.drawLine(
          Offset(position.dx - ray, position.dy),
          Offset(position.dx + ray, position.dy),
          rayPaint,
        );
        canvas.drawLine(
          Offset(position.dx, position.dy - ray),
          Offset(position.dx, position.dy + ray),
          rayPaint,
        );
      }
    }

    if (clamped < 0.6) {
      final baseOpacity = (1 - (clamped / 0.6)).clamp(0.0, 1.0);
      final visibilityScale = clamped < 0.2 ? 1.0 : 0.45;
      final cloudOpacity = baseOpacity * 0.6 * visibilityScale;
      final cloudPaint = Paint()
        ..color = const Color(0xFFFFD6C2).withOpacity(cloudOpacity)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);

      final t = timeSeconds * 0.18;
      final drift = sin(t * 2 * pi) * 12;
      final drift2 = cos(t * 2 * pi) * 10;

      for (var i = 0; i < _clouds.length; i++) {
        final cloud = _clouds[i];
        final offsetX = (i.isEven ? drift : -drift2) * (0.6 + (i % 3) * 0.2);
        final offsetY = (i % 2 == 0 ? drift2 : -drift) * 0.1;
        final center = Offset(
          size.width * cloud.position.dx + offsetX,
          size.height * cloud.position.dy + offsetY,
        );
        _drawCloud(canvas, center, cloud.width, cloudPaint);
      }

      final backPaint = Paint()
        ..color = const Color(0xFFFFE2D1).withOpacity(cloudOpacity * 0.7)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 14);
      for (var i = 0; i < _clouds.length; i += 2) {
        final cloud = _clouds[i];
        final center = Offset(
          size.width * cloud.position.dx - drift2 * 0.6,
          size.height * cloud.position.dy - 18,
        );
        _drawCloud(canvas, center, cloud.width * 1.15, backPaint);
      }
    }
  }

  void _drawCloud(Canvas canvas, Offset center, double width, Paint paint) {
    final height = width * 0.5;
    final left = center.dx - width / 2;
    final top = center.dy - height / 2;
    final rect = Rect.fromLTWH(left, top + height * 0.2, width, height * 0.6);
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(height));
    canvas.drawRRect(rrect, paint);

    final base = height * 0.38;
    canvas.drawCircle(Offset(left + width * 0.18, top + height * 0.45), base * 1.05, paint);
    canvas.drawCircle(Offset(left + width * 0.34, top + height * 0.3), base * 1.25, paint);
    canvas.drawCircle(Offset(left + width * 0.52, top + height * 0.25), base * 1.4, paint);
    canvas.drawCircle(Offset(left + width * 0.7, top + height * 0.35), base * 1.15, paint);
    canvas.drawCircle(Offset(left + width * 0.84, top + height * 0.48), base * 0.95, paint);

    canvas.drawCircle(Offset(left + width * 0.26, top + height * 0.6), base * 0.8, paint);
    canvas.drawCircle(Offset(left + width * 0.58, top + height * 0.62), base * 0.75, paint);
  }

  @override
  bool shouldRepaint(covariant _StarryPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.timeSeconds != timeSeconds;
  }
}

class _Star {
  final Offset position;
  final double radius;
  final double twinkle;
  final double phase;

  const _Star(this.position, this.radius, this.twinkle, this.phase);
}

class _Cloud {
  final Offset position;
  final double width;

  const _Cloud(this.position, this.width);
}
