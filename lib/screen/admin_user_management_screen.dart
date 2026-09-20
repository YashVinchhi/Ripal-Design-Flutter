import 'package:flutter/material.dart';
import 'package:ripal_design/resource/main_scaffold.dart';

class AdminUserManagementScreen extends StatefulWidget {
  const AdminUserManagementScreen({super.key});

  @override
  State<AdminUserManagementScreen> createState() => _AdminUserManagementScreenState();
}

class _AdminUserManagementScreenState extends State<AdminUserManagementScreen> {
  final Color primaryColor = const Color(0xFF5A0000);
  int _currentIndex = 3; // Settings or Profile equivalent

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      appBarTitle: 'Management',
      appBarActions: [
        Container(
          margin: const EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () {},
            constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
            padding: EdgeInsets.zero,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(right: 16),
          decoration: BoxDecoration(
            color: const Color(0xFFFDE9E6),
            borderRadius: BorderRadius.circular(8),
          ),
          child: IconButton(
            icon: Icon(Icons.notifications_none_outlined, color: primaryColor),
            onPressed: () {},
            constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
            padding: EdgeInsets.zero,
          ),
        ),
      ],
      currentIndex: _currentIndex,
      onNavTap: (index) {
        if (index == 0) {
          Navigator.pop(context);
        }
      },
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              _buildStatCard(Icons.group, 'TOTAL USERS', '30', primaryColor),
              const SizedBox(height: 16),
              _buildStatCard(Icons.bolt, 'ACTIVE NOW', '42', const Color(0xFF9E4723)),
              const SizedBox(height: 16),
              _buildStatCard(Icons.trending_up, 'NEW THIS WEEK', '+12%', const Color(0xFF0F3B68), iconBgColor: const Color(0xFFE6EEF5)),
              const SizedBox(height: 24),
              
              // Filters
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildFilterChip('All Users', isActive: true),
                    const SizedBox(width: 8),
                    _buildFilterChip('Clients'),
                    const SizedBox(width: 8),
                    _buildFilterChip('Workers'),
                    const SizedBox(width: 8),
                    _buildFilterChip('Architects'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Sort by: Recently Active', style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                  const SizedBox(width: 8),
                  const Icon(Icons.filter_list, size: 20),
                ],
              ),
              const SizedBox(height: 16),

              // User List
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFF2E6E3)),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFF2EF),
                        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('USER PROFILE', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black87, letterSpacing: 1.0)),
                          const Text('ROLE', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black87, letterSpacing: 1.0)),
                        ],
                      ),
                    ),
                    _buildUserRow('Rachit Dudhaiya', 'rachit123@gmail.com', 'CLIENT', const Color(0xFFE8F0FE), const Color(0xFF1967D2)),
                    const Divider(height: 1, color: Color(0xFFF2E6E3)),
                    _buildUserRow('Yash Vinchhi', 'yash123@builders.com', 'WORKER', const Color(0xFFF5F5F5), Colors.black87),
                    const Divider(height: 1, color: Color(0xFFF2E6E3)),
                    _buildUserRow('Rajibul Sheikh', 'rajibul69@ripaldesign.com', 'ARCHITECT', const Color(0xFFFFF2EF), const Color(0xFF9E4723)),
                    const Divider(height: 1, color: Color(0xFFF2E6E3)),
                    
                    // Pagination
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Showing 1 to 4 of 1,284 users', style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                          Row(
                            children: [
                              _buildPaginationButton(Icons.chevron_left),
                              const SizedBox(width: 8),
                              _buildPaginationButton(Icons.chevron_right),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(IconData icon, String title, String value, Color valueColor, {Color? iconBgColor}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF2E6E3)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: iconBgColor ?? const Color(0xFFFFF2EF),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: primaryColor, size: 32),
          ),
          const SizedBox(width: 24),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black87, letterSpacing: 0.5)),
              const SizedBox(height: 4),
              Text(value, style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800, color: valueColor)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, {bool isActive = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: isActive ? primaryColor : const Color(0xFFFDE9E6),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isActive ? Colors.white : primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _buildUserRow(String name, String email, String role, Color badgeBgColor, Color badgeTextColor) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          CircleAvatar(radius: 24, backgroundColor: Colors.grey.shade200),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
                const SizedBox(height: 4),
                Text(email, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: badgeBgColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(role, style: TextStyle(color: badgeTextColor, fontSize: 10, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildPaginationButton(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Icon(icon, size: 16, color: Colors.grey.shade600),
    );
  }
}
