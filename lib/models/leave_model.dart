enum LeaveStatus {
  approved,
  pending,
  rejected,
}

class LeaveModel {
  final String id;
  final String requestDate;
  final String type; // e.g. 'Annual Leave', 'Wellness Day', 'Conference'
  final String dateRange; // e.g. 'Oct 10-15'
  final String durationText; // e.g. '2 weeks', '1 day', '2 days'
  final LeaveStatus status;

  const LeaveModel({
    required this.id,
    required this.requestDate,
    required this.type,
    required this.dateRange,
    required this.durationText,
    required this.status,
  });
}
