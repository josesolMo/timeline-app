class TimelineEvent {
  final String date;
  final String title;
  final String description;
  final List<TimelineMedia> media;
  final TimelineMusic? music;

  const TimelineEvent(
    this.date,
    this.title,
    this.description, {
    this.media = const [],
    this.music,
  });
}

enum TimelineMediaType { image, video }

class TimelineMedia {
  final TimelineMediaType type;
  final String assetPath;

  const TimelineMedia._(this.type, this.assetPath);

  const TimelineMedia.image(String assetPath) : this._(TimelineMediaType.image, assetPath);
  const TimelineMedia.video(String assetPath) : this._(TimelineMediaType.video, assetPath);
}

class TimelineMusic {
  final String coverAsset;
  final String audioAsset;
  final String title;

  const TimelineMusic({
    required this.coverAsset,
    required this.audioAsset,
    required this.title,
  });
}
