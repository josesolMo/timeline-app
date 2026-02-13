import 'package:flutter/material.dart';

class TimelineItem extends StatelessWidget {
  final int index;
  final String title;
  final String description;
  final bool imagesOnRight;

  const TimelineItem({
    super.key,
    required this.index,
    required this.title,
    required this.description,
    required this.imagesOnRight,
  });

  @override
  Widget build(BuildContext context) {
    final images = Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            _ImagePlaceholder(),
            SizedBox(height: 10),
            _ImagePlaceholder(),
          ],
        ),
      ),
    );

    final message = Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.15)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!imagesOnRight) images,
        if (!imagesOnRight) const SizedBox(width: 8),
        Column(
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.6),
                    blurRadius: 12,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 86),
          ],
        ),
        if (imagesOnRight) const SizedBox(width: 8),
        if (!imagesOnRight) message,
        if (imagesOnRight) message,
        if (imagesOnRight) const SizedBox(width: 8),
        if (imagesOnRight) images,
      ],
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder();

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 4 / 3,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          gradient: const LinearGradient(
            colors: [Color(0xFF1E3A8A), Color(0xFF0EA5E9)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(color: Colors.white.withOpacity(0.2)),
        ),
        child: Center(
          child: Icon(
            Icons.favorite,
            color: Colors.white.withOpacity(0.85),
            size: 32,
          ),
        ),
      ),
    );
  }
}
