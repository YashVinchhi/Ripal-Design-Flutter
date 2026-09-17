class ProjectMilestone {
  final String title;
  final String description;
  final String status; // 'Active' or 'Completed'

  const ProjectMilestone({
    required this.title,
    required this.description,
    required this.status,
  });
}

class ProjectModel {
  final String id;
  final String title;
  final String phase;
  final double progress; // 0.0 to 1.0
  final String statusBadge; // 'ACTIVE', 'REVIEW', 'UNDER CONSTRUCTION'
  final String? location;
  final String? client;
  final String? budget;
  final String? timeline;
  final String? type;
  final List<ProjectMilestone> milestones;

  const ProjectModel({
    required this.id,
    required this.title,
    required this.phase,
    required this.progress,
    required this.statusBadge,
    this.location,
    this.client,
    this.budget,
    this.timeline,
    this.type,
    this.milestones = const [],
  });
}
