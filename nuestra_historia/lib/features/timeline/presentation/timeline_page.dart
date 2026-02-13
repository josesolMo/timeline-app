import 'package:flutter/material.dart';

import '../data/timeline_events.dart';
import 'widgets/timeline_item.dart';
import '../../../widgets/starry_background.dart';

class TimelinePage extends StatelessWidget {
  const TimelinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final centerX = constraints.maxWidth / 2;
          return Stack(
            children: [
              const StarryBackground(),
              SafeArea(
                child: PageView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: timelineEvents.length,
                  itemBuilder: (context, index) {
                    final event = timelineEvents[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TimelineItem(
                        index: index,
                        title: event.title,
                        description: event.description,
                        imagesOnRight: index.isEven,
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
                  color: Colors.white.withOpacity(0.25),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
