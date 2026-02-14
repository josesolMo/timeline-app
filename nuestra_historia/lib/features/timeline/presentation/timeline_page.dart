import 'package:flutter/material.dart';

import '../data/timeline_events.dart';
import 'widgets/timeline_item.dart';
import '../../../widgets/starry_background.dart';

class TimelinePage extends StatefulWidget {
  const TimelinePage({super.key});

  @override
  State<TimelinePage> createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> {
  late final PageController _controller;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double _progress() {
    if (!(_controller.hasClients)) {
      return 0;
    }
    final page = _controller.page ?? _controller.initialPage.toDouble();
    final timelinePage = (page - 1).clamp(0.0, timelineEvents.length.toDouble());
    final maxIndex = (timelineEvents.length - 1).clamp(1, 9999);
    return (timelinePage / maxIndex).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final centerX = constraints.maxWidth / 2;
          return AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              final progress = _progress();
              return Stack(
                children: [
                  StarryBackground(progress: progress),
                  SafeArea(
                    child: PageView.builder(
                      controller: _controller,
                      scrollDirection: Axis.vertical,
                      reverse: true,
                      itemCount: timelineEvents.length + 1,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return _IntroPage(
                            onOpen: () {
                              _controller.animateToPage(
                                1,
                                duration: const Duration(milliseconds: 450),
                                curve: Curves.easeOutCubic,
                              );
                            },
                          );
                        }
                        final eventIndex = timelineEvents.length - index;
                        final event = timelineEvents[eventIndex];
                        return SizedBox.expand(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: TimelineItem(
                                index: eventIndex,
                                date: event.date,
                                title: event.title,
                                description: event.description,
                                imagesOnRight: eventIndex.isEven,
                                isActive: index == _currentPage && index > 0,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  if (_currentPage != 0)
                    Positioned(
                      left: centerX - 1,
                      top: 0,
                      bottom: 0,
                      child: Container(
                        width: 2,
                        color: Colors.white.withOpacity(0.25 + (0.35 * progress)),
                      ),
                    ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class _IntroPage extends StatefulWidget {
  final VoidCallback onOpen;

  const _IntroPage({required this.onOpen});

  @override
  State<_IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<_IntroPage>
  with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final AnimationController _openController;
  bool _opening = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
      lowerBound: 0.98,
      upperBound: 1.04,
    )..repeat(reverse: true);
    _openController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _openController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox.expand(
          child: AnimatedBuilder(
            animation: _openController,
            builder: (context, _) {
              final t = _openController.value;
              final offset = constraints.maxHeight * t;
              return ClipRect(
                child: Transform.translate(
                  offset: Offset(0, offset),
                  child: Container(
                    color: const Color(0xFFFF9E66),
                    child: Center(
                      child: GestureDetector(
                        onTap: () async {
                          if (_opening) return;
                          setState(() {
                            _opening = true;
                          });
                          widget.onOpen();
                          await _openController.forward();
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Transform.translate(
                              offset: Offset(0, -20 * t),
                              child: Opacity(
                                opacity: 1 - t,
                                child: ScaleTransition(
                                  scale: _controller,
                                  child: const _EnvelopeCard(),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Toca el sobre',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.95),
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'para comenzar',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.85),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _EnvelopeCard extends StatelessWidget {
  const _EnvelopeCard();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _EnvelopePainter(),
      child: const SizedBox(
        width: 180,
        height: 120,
      ),
    );
  }
}

class _EnvelopePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final basePaint = Paint()
      ..color = const Color(0xFFF6A8C1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final fillPaint = Paint()
      ..color = const Color(0xFFFFD6E6)
      ..style = PaintingStyle.fill;

    final sealPaint = Paint()
      ..color = const Color(0xFFE5528C)
      ..style = PaintingStyle.fill;

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawRect(rect, fillPaint);
    canvas.drawRect(rect, basePaint);

    final flapPath = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width / 2, size.height * 0.55)
      ..lineTo(size.width, 0);
    canvas.drawPath(
      flapPath,
      basePaint,
    );

    final bottomPath = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width / 2, size.height * 0.45)
      ..lineTo(size.width, size.height);
    canvas.drawPath(bottomPath, basePaint);

    final heartCenter = Offset(size.width / 2, size.height * 0.5);
    final heartSize = size.width * 0.11;
    final heartPath = Path()
      ..moveTo(heartCenter.dx, heartCenter.dy + heartSize * 0.75)
      ..cubicTo(
        heartCenter.dx - heartSize * 0.95,
        heartCenter.dy + heartSize * 0.25,
        heartCenter.dx - heartSize * 0.85,
        heartCenter.dy - heartSize * 0.8,
        heartCenter.dx,
        heartCenter.dy - heartSize * 0.2,
      )
      ..cubicTo(
        heartCenter.dx + heartSize * 0.85,
        heartCenter.dy - heartSize * 0.8,
        heartCenter.dx + heartSize * 0.95,
        heartCenter.dy + heartSize * 0.25,
        heartCenter.dx,
        heartCenter.dy + heartSize * 0.75,
      );
    canvas.drawPath(heartPath, sealPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
