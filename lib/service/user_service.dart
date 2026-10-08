import 'package:shared_preferences/shared_preferences.dart';

class UserProfile {
  final String name;
  final String email;
  final String role;
  final String phone;
  final String address;
  final String city;
  final String state;
  final String pinCode;
  final String? avatarPath;

  UserProfile({
    required this.name,
    required this.email,
    required this.role,
    this.phone = '9876543210',
    this.address = '101 Design Studio Tower, Off Ring Road',
    this.city = 'Rajkot',
    this.state = 'Gujarat',
    this.pinCode = '360005',
    this.avatarPath,
  });
}

class UserService {
  static Future<UserProfile> getCurrentProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final role = (prefs.getString('role') ?? 'admin').trim().toLowerCase();
    final defaultName = _getDefaultName(role);
    final defaultEmail = _getDefaultEmail(role);

    return UserProfile(
      name: prefs.getString('userName') ?? defaultName,
      email: prefs.getString('userEmail') ?? defaultEmail,
      role: role,
      phone: prefs.getString('userPhone') ?? '9876543210',
      address: prefs.getString('userAddress') ?? '101 Design Studio Tower, Off Ring Road',
      city: prefs.getString('userCity') ?? 'Rajkot',
      state: prefs.getString('userState') ?? 'Gujarat',
      pinCode: prefs.getString('userPinCode') ?? '360005',
      avatarPath: prefs.getString('userAvatarPath'),
    );
  }

  static String _getDefaultName(String role) {
    switch (role) {
      case 'client':
        return 'Rohan';
      case 'worker':
        return 'Niku';
      case 'employee':
        return 'Rachit';
      case 'admin':
      default:
        return 'Yash';
    }
  }

  static String _getDefaultEmail(String role) {
    switch (role) {
      case 'client':
        return 'rohan@gmail.com';
      case 'worker':
        return 'niku@gmail.com';
      case 'employee':
        return 'rachit@gmail.com';
      case 'admin':
      default:
        return 'yash@gmail.com';
    }
  }

  static Future<void> saveProfile({
    required String name,
    required String email,
    required String phone,
    required String address,
    required String city,
    required String state,
    required String pinCode,
    String? avatarPath,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', name);
    await prefs.setString('userEmail', email);
    await prefs.setString('userPhone', phone);
    await prefs.setString('userAddress', address);
    await prefs.setString('userCity', city);
    await prefs.setString('userState', state);
    await prefs.setString('userPinCode', pinCode);
    if (avatarPath != null) {
      await prefs.setString('userAvatarPath', avatarPath);
    }
  }

  static Future<String> getCurrentPassword() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString('userPassword');
    if (saved != null && saved.isNotEmpty) return saved;
    final email = prefs.getString('userEmail') ?? '';
    if (email == 'admin@gmail.com') return 'admin123';
    return 'zxcv';
  }

  static Future<UserProfile> getCurrentUser() => getCurrentProfile();

  static Future<void> updateProfile({
    required String name,
    required String email,
    required String phone,
    required String address,
    required String city,
    required String state,
    required String pinCode,
    String? avatarPath,
  }) => saveProfile(
    name: name,
    email: email,
    phone: phone,
    address: address,
    city: city,
    state: state,
    pinCode: pinCode,
    avatarPath: avatarPath,
  );

  static Future<void> updateAvatar(String avatarPath) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userAvatarPath', avatarPath);
  }

  static Future<String> getRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('role') ?? 'admin';
  }

  static Future<void> updatePassword(String newPassword) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userPassword', newPassword);
  }
}
