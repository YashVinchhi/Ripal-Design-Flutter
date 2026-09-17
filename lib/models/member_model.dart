class MemberModel {
  final String id;
  final String name;
  final String role;
  final String email;
  final String initials;
  final bool isVerified;
  final String? phone;
  final String? department;

  const MemberModel({
    required this.id,
    required this.name,
    required this.role,
    required this.email,
    required this.initials,
    this.isVerified = false,
    this.phone,
    this.department,
  });
}
