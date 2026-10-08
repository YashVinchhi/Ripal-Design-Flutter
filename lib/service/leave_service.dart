import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LeaveRecord {
  final String id;
  final String applicantName;
  final String applicantRole;
  final String leaveType;
  final String dateRange;
  final String duration;
  String status; // 'APPROVED', 'PENDING', 'REJECTED'
  final String appliedDate;
  final String reason;

  LeaveRecord({
    required this.id,
    required this.applicantName,
    required this.applicantRole,
    required this.leaveType,
    required this.dateRange,
    required this.duration,
    required this.status,
    required this.appliedDate,
    required this.reason,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'applicantName': applicantName,
    'applicantRole': applicantRole,
    'leaveType': leaveType,
    'dateRange': dateRange,
    'duration': duration,
    'status': status,
    'appliedDate': appliedDate,
    'reason': reason,
  };

  factory LeaveRecord.fromJson(Map<String, dynamic> json) => LeaveRecord(
    id: json['id'] as String? ?? '',
    applicantName: json['applicantName'] as String? ?? '',
    applicantRole: json['applicantRole'] as String? ?? '',
    leaveType: json['leaveType'] as String? ?? 'Annual Leave',
    dateRange: json['dateRange'] as String? ?? '',
    duration: json['duration'] as String? ?? '',
    status: json['status'] as String? ?? 'PENDING',
    appliedDate: json['appliedDate'] as String? ?? '',
    reason: json['reason'] as String? ?? '',
  );

  Color get statusBg {
    switch (status) {
      case 'APPROVED':
        return const Color(0xFFE5F7ED);
      case 'REJECTED':
        return const Color(0xFFFDE8E8);
      case 'PENDING':
      default:
        return const Color(0xFFFEF3D6);
    }
  }

  Color get statusColor {
    switch (status) {
      case 'APPROVED':
        return const Color(0xFF28854D);
      case 'REJECTED':
        return const Color(0xFFC53030);
      case 'PENDING':
      default:
        return const Color(0xFFB57D18);
    }
  }

  IconData get icon {
    if (leaveType.toLowerCase().contains('wellness')) {
      return Icons.spa_outlined;
    } else if (leaveType.toLowerCase().contains('conference')) {
      return Icons.event_note_outlined;
    }
    return Icons.calendar_today_outlined;
  }
}

class LeaveService {
  static const String _storageKey = 'app_leave_records_v2';
  static final ValueNotifier<int> leaveUpdateNotifier = ValueNotifier<int>(0);

  static final List<LeaveRecord> _defaultRecords = [
    LeaveRecord(
      id: 'leave_1',
      applicantName: 'Rachit Dudhaiya',
      applicantRole: 'Project Manager',
      leaveType: 'Annual Leave',
      dateRange: 'Oct 12 - Oct 15',
      duration: '4 days',
      status: 'PENDING',
      appliedDate: 'OCT 01, 2024',
      reason: 'Annual Family Vacation',
    ),
    LeaveRecord(
      id: 'leave_2',
      applicantName: 'Yash Vinchhi',
      applicantRole: 'Lead Architect',
      leaveType: 'Wellness Day',
      dateRange: 'Oct 18',
      duration: '1 day',
      status: 'PENDING',
      appliedDate: 'OCT 02, 2024',
      reason: 'Wellness Day Off',
    ),
    LeaveRecord(
      id: 'leave_3',
      applicantName: 'Rajibul Sheikh',
      applicantRole: 'Designer',
      leaveType: 'Annual Leave',
      dateRange: 'Oct 20 - Oct 27',
      duration: '8 days',
      status: 'PENDING',
      appliedDate: 'OCT 03, 2024',
      reason: 'Personal Project',
    ),
    LeaveRecord(
      id: 'leave_4',
      applicantName: 'Niku',
      applicantRole: 'Site Worker',
      leaveType: 'Annual Leave',
      dateRange: 'Oct 10-15',
      duration: '2 weeks',
      status: 'APPROVED',
      appliedDate: 'SEP 04, 2024',
      reason: 'Annual Vacation',
    ),
    LeaveRecord(
      id: 'leave_5',
      applicantName: 'Niku',
      applicantRole: 'Site Worker',
      leaveType: 'Wellness Day',
      dateRange: 'Aug 15',
      duration: '1 day',
      status: 'APPROVED',
      appliedDate: 'AUG 12, 2024',
      reason: 'Wellness Rest Day',
    ),
    LeaveRecord(
      id: 'leave_6',
      applicantName: 'Niku',
      applicantRole: 'Site Worker',
      leaveType: 'Annual Leave',
      dateRange: 'Jul 22-23',
      duration: '2 days',
      status: 'PENDING',
      appliedDate: 'JUL 20, 2024',
      reason: 'Family Event',
    ),
    LeaveRecord(
      id: 'leave_7',
      applicantName: 'Niku',
      applicantRole: 'Site Worker',
      leaveType: 'Conference',
      dateRange: 'May 18-20',
      duration: '3 days',
      status: 'REJECTED',
      appliedDate: 'MAY 15, 2024',
      reason: 'Annual Industry Conference',
    ),
    LeaveRecord(
      id: 'leave_8',
      applicantName: 'Niku',
      applicantRole: 'Site Worker',
      leaveType: 'Annual Leave',
      dateRange: 'Apr 10-15',
      duration: '4 days',
      status: 'APPROVED',
      appliedDate: 'APR 02, 2024',
      reason: 'Spring Break Vacation',
    ),
  ];

  static Future<List<LeaveRecord>> getLeaves() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_storageKey);
    if (raw == null || raw.isEmpty) {
      await _saveList(_defaultRecords);
      return List.from(_defaultRecords);
    }
    try {
      final List decoded = jsonDecode(raw);
      return decoded.map((e) => LeaveRecord.fromJson(e as Map<String, dynamic>)).toList();
    } catch (_) {
      return List.from(_defaultRecords);
    }
  }

  static Future<List<LeaveRecord>> getWorkerLeaves() async {
    final all = await getLeaves();
    return all.where((l) => l.applicantName.toLowerCase() == 'niku' || l.applicantRole.toLowerCase().contains('worker')).toList();
  }

  static Future<void> addLeave(LeaveRecord record) async {
    final list = await getLeaves();
    list.insert(0, record);
    await _saveList(list);
    leaveUpdateNotifier.value++;
  }

  static Future<void> updateStatus(String id, String newStatus) async {
    final list = await getLeaves();
    final index = list.indexWhere((l) => l.id == id);
    if (index != -1) {
      list[index].status = newStatus;
      await _saveList(list);
      leaveUpdateNotifier.value++;
    }
  }

  static Future<int> getPendingCount() async {
    final list = await getLeaves();
    return list.where((l) => l.status == 'PENDING').length;
  }

  static Future<int> getWorkerPendingCount() async {
    final list = await getWorkerLeaves();
    return list.where((l) => l.status == 'PENDING').length;
  }

  static Future<void> _saveList(List<LeaveRecord> list) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(list.map((e) => e.toJson()).toList());
    await prefs.setString(_storageKey, encoded);
  }
}
