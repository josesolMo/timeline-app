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
                          return const _IntroPage();
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

class _IntroPage extends StatelessWidget {
  const _IntroPage();

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Desliza hacia arriba',
              style: TextStyle(
                color: Colors.white.withOpacity(0.85),
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'para iniciar nuestra historia',
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
