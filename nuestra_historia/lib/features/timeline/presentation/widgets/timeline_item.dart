import 'dart:ui';

import 'package:flutter/material.dart';

import 'music_strip.dart';

class TimelineItem extends StatelessWidget {
  final int index;
  final String date;
  final String title;
  final String description;
  final bool imagesOnRight;
  final bool isActive;

  const TimelineItem({
    super.key,
    required this.index,
    required this.date,
    required this.title,
    required this.description,
    required this.imagesOnRight,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final imageHeight = (constraints.maxHeight * 0.22).clamp(90.0, 160.0);
        final cardMinHeight = (constraints.maxHeight * 0.28).clamp(140.0, 220.0);
        final dateParts = _parseDate(date);

        final images = Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _ImagePlaceholder(height: imageHeight),
              const SizedBox(height: 12),
              _ImagePlaceholder(height: imageHeight),
            ],
          ),
        );

        final message = Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: cardMinHeight),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withOpacity(0.12),
                        Colors.white.withOpacity(0.06),
                      ],
                    ),
                    border: Border.all(color: Colors.white.withOpacity(0.18)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 18,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
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
                      const SizedBox(height: 10),
                      Text(
                        description,
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

        final left = imagesOnRight ? message : images;
        final right = imagesOnRight ? images : message;

        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 980),
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  top: 18,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _OutlinedGlowText(
                        dateParts.year,
                        fontSize: 75,
                        strokeWidth: 2.2,
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 70),
                      _OutlinedGlowText(
                        dateParts.dayMonth,
                        fontSize: 30,
                        strokeWidth: 1.8,
                      ),
                      const SizedBox(height: 18),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(child: Align(alignment: Alignment.center, child: left)),
                          const SizedBox(width: 8),
                          SizedBox(
                            width: 28,
                            child: Center(
                              child: Container(
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
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(child: Align(alignment: Alignment.center, child: right)),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 18,
                  child: Center(
                    child: MusicStrip(
                      coverAsset: 'assets/images/CAS_caratula.jpg',
                      vinylAsset: 'assets/images/vinyl_record.png',
                      audioAsset: 'assets/audio/apocalypse.mp3',
                      title: 'Apocalypse',
                      isActive: isActive,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  final double height;

  const _ImagePlaceholder({required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: const LinearGradient(
            colors: [Color(0xFF5B2EFF), Color(0xFF1D9BF0)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(color: Colors.white.withOpacity(0.2)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 16,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Center(
          child: Icon(
            Icons.favorite,
            color: Colors.white.withOpacity(0.9),
            size: 32,
          ),
        ),
      ),
    );
  }
}

class _OutlinedGlowText extends StatelessWidget {
  final String text;
  final double fontSize;
  final double strokeWidth;

  const _OutlinedGlowText(
    this.text, {
    required this.fontSize,
    required this.strokeWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w900,
            fontFamily: 'Montserrat',
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = strokeWidth + 2.6
              ..color = Colors.white.withOpacity(0.18),
            shadows: [
              Shadow(
                color: Colors.white.withOpacity(0.25),
                blurRadius: 8,
              ),
            ],
          ),
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w900,
            fontFamily: 'Montserrat',
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = strokeWidth
              ..color = Colors.white.withOpacity(0.95),
          ),
        ),
      ],
    );
  }
}

_DateParts _parseDate(String raw) {
  final parts = raw.split('/');
  if (parts.length != 3) {
    return _DateParts(dayMonth: raw, year: '');
  }
  final day = int.tryParse(parts[0]) ?? 0;
  final month = int.tryParse(parts[1]) ?? 0;
  final year = parts[2];
  final dayText = day == 0 ? parts[0] : day.toString();
  final monthText = _monthAbbrev(month);
  return _DateParts(dayMonth: '$dayText $monthText', year: year);
}

String _monthAbbrev(int month) {
  const months = [
    'Ene.',
    'Feb.',
    'Mar.',
    'Abr.',
    'May.',
    'Jun.',
    'Jul.',
    'Ago.',
    'Sep.',
    'Oct.',
    'Nov.',
    'Dic.',
  ];
  if (month < 1 || month > 12) {
    return '';
  }
  return months[month - 1];
}

class _DateParts {
  final String dayMonth;
  final String year;

  const _DateParts({required this.dayMonth, required this.year});
}
