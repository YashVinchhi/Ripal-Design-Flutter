enum ActivityType {
  file,
  progress,
  member,
  milestone,
}

class ActivityModel {
  final String id;
  final String title;
  final String? subtitle;
  final String timestamp;
  final ActivityType type;
  final int? progressPercentage;

  const ActivityModel({
    required this.id,
    required this.title,
    this.subtitle,
    required this.timestamp,
    required this.type,
    this.progressPercentage,
  });
}
