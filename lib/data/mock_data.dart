import '../models/project_model.dart';
import '../models/member_model.dart';
import '../models/leave_model.dart';
import '../models/activity_model.dart';

class MockData {
  static const ProjectModel obsidianHouse = ProjectModel(
    id: 'obsidian-house',
    title: 'The Obsidian House',
    phase: 'Phase 3: Structural Framing',
    progress: 0.75,
    statusBadge: 'UNDER CONSTRUCTION',
    location: 'Malibu, CA — Pacific Coast Highway',
    client: 'Vanguard Properties',
    budget: '₹12,50,000',
    timeline: 'Oct 2023 - Dec 2024',
    type: 'Residential Luxury',
    milestones: [
      ProjectMilestone(
        title: 'Interior Fit',
        description:
            'Installation of custom marble surfaces and smart home integration systems.',
        status: 'Active',
      ),
      ProjectMilestone(
        title: 'Structural Framing',
        description:
            'Final inspection of the primary cantilevered steel support structure.',
        status: 'Completed',
      ),
      ProjectMilestone(
        title: 'Planning & Permits',
        description:
            'All environmental impact assessments approved by the coastal commission.',
        status: 'Completed',
      ),
    ],
  );

  static const List<ProjectModel> assignedProjects = [
    ProjectModel(
      id: 'skyline-plaza',
      title: 'Skyline Plaza',
      phase: 'Phase 3: Structural Framework',
      progress: 0.75,
      statusBadge: 'ACTIVE',
      location: 'Downtown Financial District',
      client: 'Skyline Enterprises',
      budget: '₹45,00,000',
      timeline: 'Jan 2024 - Mar 2025',
      type: 'Commercial High-Rise',
    ),
    ProjectModel(
      id: 'azure-bay',
      title: 'Azure Bay',
      phase: 'Phase 2: Interior Layouts',
      progress: 0.42,
      statusBadge: 'REVIEW',
      location: 'Coastal Boulevard Marina',
      client: 'Azure Bay Real Estate',
      budget: '₹28,00,000',
      timeline: 'Mar 2024 - Dec 2024',
      type: 'Waterfront Living',
    ),
    obsidianHouse,
  ];

  static const List<MemberModel> executionCrew = [
    MemberModel(
      id: 'dd1',
      name: 'Deep Dudhaiya',
      role: 'worker',
      email: 'apixgamer40@gmail.com',
      initials: 'DD',
      phone: '+91 98765 43210',
      department: 'Site Execution',
    ),
    MemberModel(
      id: 'rs1',
      name: 'Rajibul Sheikh',
      role: 'worker',
      email: 'rajibulsheikh098@gmail.com',
      initials: 'RS',
      isVerified: true,
      phone: '+91 98123 45678',
      department: 'Architecture & Planning',
    ),
    MemberModel(
      id: 'yv1',
      name: 'Yash Vinchhi',
      role: 'worker',
      email: 'behappywithyash@gmail.com',
      initials: 'YV',
      isVerified: true,
      phone: '+91 97234 56789',
      department: 'Structural Engineering',
    ),
    MemberModel(
      id: 'dd2',
      name: 'Deep Dudhaiya',
      role: 'worker',
      email: 'apixgamer40@gmail.com',
      initials: 'DD',
      phone: '+91 98765 43210',
      department: 'Site Execution',
    ),
    MemberModel(
      id: 'rs2',
      name: 'Rajibul Sheikh',
      role: 'worker',
      email: 'rajibulsheikh098@gmail.com',
      initials: 'RS',
      isVerified: true,
      phone: '+91 98123 45678',
      department: 'Architecture & Planning',
    ),
    MemberModel(
      id: 'yv2',
      name: 'Yash Vinchhi',
      role: 'worker',
      email: 'behappywithyash@gmail.com',
      initials: 'YV',
      isVerified: true,
      phone: '+91 97234 56789',
      department: 'Structural Engineering',
    ),
  ];

  static const List<LeaveModel> leaveHistory = [
    LeaveModel(
      id: 'l1',
      requestDate: 'SEP 04, 2024',
      type: 'Annual Leave',
      dateRange: 'Oct 10-15',
      durationText: '2 weeks',
      status: LeaveStatus.approved,
    ),
    LeaveModel(
      id: 'l2',
      requestDate: 'AUG 12, 2024',
      type: 'Wellness Day',
      dateRange: 'Aug 15',
      durationText: '1 day',
      status: LeaveStatus.approved,
    ),
    LeaveModel(
      id: 'l3',
      requestDate: 'JUL 20, 2024',
      type: 'Annual Leave',
      dateRange: 'Jul 22-23',
      durationText: '2 days',
      status: LeaveStatus.pending,
    ),
    LeaveModel(
      id: 'l4',
      requestDate: 'MAY 15, 2024',
      type: 'Conference',
      dateRange: 'May 18-20',
      durationText: '3 days',
      status: LeaveStatus.rejected,
    ),
    LeaveModel(
      id: 'l5',
      requestDate: 'APR 02, 2024',
      type: 'Annual Leave',
      dateRange: 'Apr 10-15',
      durationText: '4 days',
      status: LeaveStatus.approved,
    ),
  ];

  static const List<ActivityModel> siteActivities = [
    ActivityModel(
      id: 'a1',
      title: 'Panorama.png',
      timestamp: 'Jun 01, 2026 • 10:42 AM',
      type: ActivityType.file,
    ),
    ActivityModel(
      id: 'a2',
      title: 'Admin progress updated:',
      subtitle: 'Auto-calculated to 30%',
      timestamp: 'May 02, 2026 • 03:15 PM',
      type: ActivityType.progress,
      progressPercentage: 30,
    ),
    ActivityModel(
      id: 'a3',
      title: 'Admin added team member',
      subtitle: 'Yash Vinchhi',
      timestamp: 'May 02, 2026 • 09:00 AM',
      type: ActivityType.member,
    ),
    ActivityModel(
      id: 'a4',
      title: 'Admin created milestone:',
      subtitle: 'Planning complete',
      timestamp: 'Apr 28, 2026 • 11:20 AM',
      type: ActivityType.milestone,
    ),
    ActivityModel(
      id: 'a5',
      title: 'Admin uploaded file',
      subtitle: 'Exterior_Render_Final.jpg',
      timestamp: 'Apr 25, 2026 • 04:55 PM',
      type: ActivityType.file,
    ),
  ];
}
