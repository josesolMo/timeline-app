import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'music_strip.dart';
import '../../../timeline/models/timeline_event.dart';

class TimelineItem extends StatelessWidget {
  final int index;
  final String date;
  final String title;
  final String description;
  final List<TimelineMedia> media;
  final TimelineMusic? music;
  final List<String> poemAssets;
  final bool imagesOnRight;
  final bool isActive;

  const TimelineItem({
    super.key,
    required this.index,
    required this.date,
    required this.title,
    required this.description,
    required this.media,
    required this.music,
    required this.poemAssets,
    required this.imagesOnRight,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final imageHeight = (constraints.maxHeight * 0.22).clamp(90.0, 160.0);
        final cardMinHeight = (constraints.maxHeight * 0.34).clamp(180.0, 260.0);
        final dateParts = _parseDate(date);
        final isFinalPage = date == '14/02/2025';

        final mediaTop = media.isNotEmpty ? media[0] : null;
        final mediaBottom = media.length > 1 ? media[1] : null;
        final finalMedia = media;

        final images = Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Transform.translate(
                offset: const Offset(6, -4),
                child: Transform.rotate(
                  angle: 0.09,
                  child: _PolaroidFrame(
                    height: imageHeight,
                    child: _MediaSlot(media: mediaTop),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Transform.translate(
                offset: const Offset(-8, 6),
                child: Transform.rotate(
                  angle: -0.11,
                  child: _PolaroidFrame(
                    height: imageHeight,
                    child: _MediaSlot(media: mediaBottom),
                  ),
                ),
              ),
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
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
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
                          height: 1.25,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        description,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.85),
                          fontSize: 13,
                          height: 1.3,
                        ),
                      ),
                      if (poemAssets.isNotEmpty) ...[
                        const SizedBox(height: 14),
                        _MiniEnvelopeButton(imageAssets: poemAssets),
                      ],
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
                if (!isFinalPage)
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
                if (!isFinalPage)
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 40),
                        _OutlinedGlowText(
                          dateParts.dayMonth,
                          fontSize: 30,
                          strokeWidth: 1.8,
                        ),
                        const SizedBox(height: 12),
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
                if (isFinalPage)
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 16,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _OutlinedGlowText(
                          dateParts.year,
                          fontSize: 70,
                          strokeWidth: 2.2,
                        ),
                        const SizedBox(height: 6),
                        _OutlinedGlowText(
                          dateParts.dayMonth,
                          fontSize: 28,
                          strokeWidth: 1.8,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 28),
                          child: Text(
                            description,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                              fontSize: 13,
                              height: 1.3,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                if (isFinalPage)
                  Positioned.fill(
                    top: constraints.maxHeight * 0.35,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Stack(
                        children: [
                          _AlignedPolaroid(
                            height: (imageHeight * 0.9).clamp(90.0, 140.0),
                            width: (imageHeight * 0.9).clamp(90.0, 140.0),
                            alignment: const Alignment(-0.85, -0.85),
                            angle: -0.08,
                            media: finalMedia.length > 0 ? finalMedia[0] : null,
                          ),
                          _AlignedPolaroid(
                            height: (imageHeight * 0.9).clamp(90.0, 140.0),
                            width: (imageHeight * 0.9).clamp(90.0, 140.0),
                            alignment: const Alignment(0.85, -0.8),
                            angle: 0.07,
                            media: finalMedia.length > 1 ? finalMedia[1] : null,
                          ),
                          _AlignedPolaroid(
                            height: (imageHeight * 0.9).clamp(90.0, 140.0),
                            width: (imageHeight * 0.9).clamp(90.0, 140.0),
                            alignment: const Alignment(-0.85, -0.1),
                            angle: 0.06,
                            media: finalMedia.length > 2 ? finalMedia[2] : null,
                          ),
                          _AlignedPolaroid(
                            height: (imageHeight * 0.9).clamp(90.0, 140.0),
                            width: (imageHeight * 0.9).clamp(90.0, 140.0),
                            alignment: const Alignment(0.85, -0.05),
                            angle: -0.05,
                            media: finalMedia.length > 3 ? finalMedia[3] : null,
                          ),
                          _AlignedPolaroid(
                            height: (imageHeight * 0.9).clamp(90.0, 140.0),
                            width: (imageHeight * 0.9).clamp(90.0, 140.0),
                            alignment: const Alignment(-0.85, 0.7),
                            angle: -0.09,
                            media: finalMedia.length > 4 ? finalMedia[4] : null,
                          ),
                          _AlignedPolaroid(
                            height: (imageHeight * 0.9).clamp(90.0, 140.0),
                            width: (imageHeight * 0.9).clamp(90.0, 140.0),
                            alignment: const Alignment(0.85, 0.65),
                            angle: 0.1,
                            media: finalMedia.length > 5 ? finalMedia[5] : null,
                          ),
                        ],
                      ),
                    ),
                  ),
                if (music != null)
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 18,
                    child: Center(
                      child: MusicStrip(
                        coverAsset: music!.coverAsset,
                        vinylAsset: 'assets/images/vinyl_record.png',
                        audioAsset: music!.audioAsset,
                        title: music!.title,
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

class _PolaroidFrame extends StatelessWidget {
  final double height;
  final double? width;
  final Widget child;

  const _PolaroidFrame({required this.height, this.width, required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width ?? height,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.35),
              blurRadius: 18,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(child: child),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

class _AlignedPolaroid extends StatelessWidget {
  final double height;
  final double width;
  final Alignment alignment;
  final double angle;
  final TimelineMedia? media;

  const _AlignedPolaroid({
    required this.height,
    required this.width,
    required this.alignment,
    required this.angle,
    required this.media,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Transform.rotate(
        angle: angle,
        child: _PolaroidFrame(
          height: height,
          width: width,
          child: _MediaSlot(media: media),
        ),
      ),
    );
  }
}

class _MediaSlot extends StatelessWidget {
  final TimelineMedia? media;

  const _MediaSlot({required this.media});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: ClipRect(
        child: media == null ? _PlaceholderMedia() : _buildMedia(),
      ),
    );
  }

  Widget _buildMedia() {
    if (media == null) {
      return _PlaceholderMedia();
    }
    switch (media!.type) {
      case TimelineMediaType.image:
        return FittedBox(
          fit: BoxFit.cover,
          clipBehavior: Clip.hardEdge,
          child: Image.asset(media!.assetPath),
        );
      case TimelineMediaType.video:
        return _VideoMedia(assetPath: media!.assetPath);
    }
  }
}

class _PlaceholderMedia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF5B2EFF), Color(0xFF1D9BF0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Icon(
          Icons.favorite,
          color: Colors.white.withOpacity(0.9),
          size: 32,
        ),
      ),
    );
  }
}

class _VideoMedia extends StatefulWidget {
  final String assetPath;

  const _VideoMedia({required this.assetPath});

  @override
  State<_VideoMedia> createState() => _VideoMediaState();
}

class _VideoMediaState extends State<_VideoMedia> {
  late final VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.assetPath)
      ..setLooping(true)
      ..setVolume(0)
      ..initialize().then((_) {
        if (mounted) {
          setState(() {});
        }
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return _PlaceholderMedia();
    }
    return FittedBox(
      fit: BoxFit.cover,
      clipBehavior: Clip.hardEdge,
      child: SizedBox(
        width: _controller.value.size.width,
        height: _controller.value.size.height,
        child: VideoPlayer(_controller),
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

class _MiniEnvelopeButton extends StatefulWidget {
  final List<String> imageAssets;

  const _MiniEnvelopeButton({required this.imageAssets});

  @override
  State<_MiniEnvelopeButton> createState() => _MiniEnvelopeButtonState();
}

class _MiniEnvelopeButtonState extends State<_MiniEnvelopeButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
      lowerBound: 0.96,
      upperBound: 1.04,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _openPoem(BuildContext context) async {
    await showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        final controller = PageController();
        final notifier = ValueNotifier<int>(0);
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          backgroundColor: Colors.black.withOpacity(0.6),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: PageView.builder(
                    controller: controller,
                    itemCount: widget.imageAssets.length,
                    onPageChanged: (index) => notifier.value = index,
                    itemBuilder: (context, index) {
                      return Image.asset(
                        widget.imageAssets[index],
                        fit: BoxFit.contain,
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                left: 6,
                top: 0,
                bottom: 0,
                child: ValueListenableBuilder<int>(
                  valueListenable: notifier,
                  builder: (context, page, _) {
                    return IconButton(
                      onPressed: page == 0
                          ? null
                          : () => controller.previousPage(
                                duration: const Duration(milliseconds: 250),
                                curve: Curves.easeOut,
                              ),
                      icon: const Icon(Icons.chevron_left),
                      color: Colors.white,
                    );
                  },
                ),
              ),
              Positioned(
                right: 6,
                top: 0,
                bottom: 0,
                child: ValueListenableBuilder<int>(
                  valueListenable: notifier,
                  builder: (context, page, _) {
                    return IconButton(
                      onPressed: page == widget.imageAssets.length - 1
                          ? null
                          : () => controller.nextPage(
                                duration: const Duration(milliseconds: 250),
                                curve: Curves.easeOut,
                              ),
                      icon: const Icon(Icons.chevron_right),
                      color: Colors.white,
                    );
                  },
                ),
              ),
              Positioned(
                right: 6,
                top: 6,
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                  color: Colors.white,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _openPoem(context),
      child: ScaleTransition(
        scale: _controller,
        child: CustomPaint(
          painter: _MiniEnvelopePainter(),
          child: const SizedBox(width: 52, height: 36),
        ),
      ),
    );
  }
}

class _MiniEnvelopePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final basePaint = Paint()
      ..color = const Color(0xFFF6A8C1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6;

    final fillPaint = Paint()
      ..color = const Color(0xFFFFD6E6)
      ..style = PaintingStyle.fill;

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawRect(rect, fillPaint);
    canvas.drawRect(rect, basePaint);

    final flapPath = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width / 2, size.height * 0.6)
      ..lineTo(size.width, 0);
    canvas.drawPath(flapPath, basePaint);

    final bottomPath = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width / 2, size.height * 0.45)
      ..lineTo(size.width, size.height);
    canvas.drawPath(bottomPath, basePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

_DateParts _parseDate(String raw) {
  final trimmed = raw.trim();
  final tokens = trimmed.split(RegExp(r'\s+'));
  if (tokens.length >= 2 && RegExp(r'^\d{4}$').hasMatch(tokens.last)) {
    final year = tokens.last;
    final dayMonth = tokens.sublist(0, tokens.length - 1).join(' ');
    if (RegExp(r'[A-Za-zÁÉÍÓÚáéíóúÑñ]').hasMatch(dayMonth)) {
      return _DateParts(dayMonth: dayMonth, year: year);
    }
  }
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
