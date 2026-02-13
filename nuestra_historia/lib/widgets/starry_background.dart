import 'package:flutter/material.dart';

class StarryBackground extends StatelessWidget {
  const StarryBackground({super.key});

  static const _stars = <Offset>[
    Offset(0.1, 0.2),
    Offset(0.2, 0.7),
    Offset(0.3, 0.4),
    Offset(0.4, 0.15),
    Offset(0.5, 0.6),
    Offset(0.6, 0.3),
    Offset(0.7, 0.8),
    Offset(0.8, 0.25),
    Offset(0.9, 0.5),
    Offset(0.15, 0.85),
    Offset(0.35, 0.65),
    Offset(0.55, 0.1),
    Offset(0.75, 0.45),
    Offset(0.85, 0.75),
  ];

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _StarryPainter(_stars),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Color(0xFF0B0D2A),
              Color(0xFF141B3D),
              Color(0xFF1C2B5A),
            ],
          ),
        ),
      ),
    );
  }
}

class _StarryPainter extends CustomPainter {
  final List<Offset> stars;

  _StarryPainter(this.stars);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(0.8);
    for (final star in stars) {
      final position = Offset(star.dx * size.width, star.dy * size.height);
      canvas.drawCircle(position, 1.6, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
