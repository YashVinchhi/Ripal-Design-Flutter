import 'package:flutter/material.dart';
import 'package:ripal_design/resource/main_scaffold.dart';
import 'package:ripal_design/screen/admin_activity_screen.dart';
import 'package:ripal_design/screen/admin_create_project.dart';
import 'package:ripal_design/screen/admin_finance_screen.dart';
import 'package:ripal_design/screen/admin_leave_screen.dart';
import 'package:ripal_design/screen/admin_upload_file_screen.dart';
import 'package:ripal_design/screen/dashboard_screen.dart';
import 'package:ripal_design/screen/settings_screen.dart';

class AdminTeamScreen extends StatefulWidget {
  final String projectName;

  const AdminTeamScreen({
    super.key,
    this.projectName = 'Test Project',
  });

  @override
  State<AdminTeamScreen> createState() => _AdminTeamScreenState();
}

class _AdminTeamScreenState extends State<AdminTeamScreen> {
  static const Color primaryColor = Color(0xFF5A0000);
  static const Color _titleDark = Color(0xFF2A0501);
  static const Color _cardPink = Color(0xFFFCEFEA);

  int _currentIndex = 0;
  final int _currentStep = 2; // Step 2: Team

  String _searchQuery = '';

  final List<Map<String, String>> _teamMembers = [
    {
      'initials': 'DD',
      'name': 'Deep Dudhaiya',
      'role': 'worker',
      'email': 'apixgamer40@gmail.com',
    },
    {
      'initials': 'RS',
      'name': 'Rajibul Sheikh',
      'role': 'worker',
      'email': 'rajibulsheikh098@gmail.com',
    },
    {
      'initials': 'YV',
      'name': 'Yash Vinchhi',
      'role': 'worker',
      'email': 'behappywithyash@gmail.com',
    },
  ];

  final List<Map<String, dynamic>> _availableCrew = [
    {
      'initials': 'DD',
      'name': 'Deep Dudhaiya',
      'role': 'worker',
      'email': 'apixgamer40@gmail.com',
      'assigned': true,
    },
    {
      'initials': 'RS',
      'name': 'Rajibul Sheikh',
      'role': 'worker',
      'email': 'rajibulsheikh098@gmail.com',
      'assigned': true,
    },
    {
      'initials': 'YV',
      'name': 'Yash Vinchhi',
      'role': 'worker',
      'email': 'yash123@gmail.com',
      'assigned': true,
    },
    {
      'initials': 'RP',
      'name': 'Ripal Patel',
      'role': 'lead architect',
      'email': 'ripal.patel@design.com',
      'assigned': false,
    },
    {
      'initials': 'JS',
      'name': 'John Smith',
      'role': 'site engineer',
      'email': 'john.smith@design.com',
      'assigned': false,
    },
  ];

  void _onNavTap(int index) {
    if (index == 0) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const DashboardScreen()));
      return;
    }
    if (index == 1) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AdminLeaveScreen()));
      return;
    }
    if (index == 2) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AdminFinanceScreen()));
      return;
    }
    if (index == 3) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SettingsScreen()));
      return;
    }
    setState(() => _currentIndex = index);
  }

  void _onFabPressed() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminCreateProject()));
  }

  void _onStepTap(int step) {
    if (step == 1) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AdminCreateProject()));
    } else if (step == 2) {
      // Already on Team step
    } else if (step == 3) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminUploadFileScreen()));
    } else if (step == 4) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminActivityScreen()));
    }
  }

  void _showAddMemberModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFFFFF7F2),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return DraggableScrollableSheet(
              expand: false,
              initialChildSize: 0.8,
              maxChildSize: 0.9,
              builder: (context, scrollController) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.arrow_back, color: Colors.black87),
                                onPressed: () => Navigator.pop(context),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'PROJECT DETAILS',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                      letterSpacing: 1.0,
                                    ),
                                  ),
                                  Text(
                                    'Test 1',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: _titleDark,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                            ),
                            child: const Text('Save', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      const Text(
                        'Execution Crew',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: _titleDark,
                        ),
                      ),
                      const SizedBox(height: 16),

                      Expanded(
                        child: ListView.builder(
                          controller: scrollController,
                          itemCount: _availableCrew.length,
                          itemBuilder: (context, index) {
                            final member = _availableCrew[index];
                            final bool isAssigned = member['assigned'] as bool;

                            return Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: const Color(0xFFE5CCC9)),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 44,
                                    height: 44,
                                    decoration: BoxDecoration(
                                      color: _cardPink,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                      child: Text(
                                        member['initials'] as String,
                                        style: const TextStyle(
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          member['name'] as String,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: _titleDark,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          member['role'] as String,
                                          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                                        ),
                                        Text(
                                          member['email'] as String,
                                          style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
                                        ),
                                      ],
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      setModalState(() {
                                        member['assigned'] = !isAssigned;
                                      });
                                      setState(() {
                                        if (!isAssigned) {
                                          _teamMembers.add({
                                            'initials': member['initials'] as String,
                                            'name': member['name'] as String,
                                            'role': member['role'] as String,
                                            'email': member['email'] as String,
                                          });
                                        } else {
                                          _teamMembers.removeWhere((m) => m['name'] == member['name']);
                                        }
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: isAssigned ? Colors.grey.shade400 : primaryColor,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                    ),
                                    child: Text(
                                      isAssigned ? 'Assigned' : 'Assign',
                                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  void _showAddManuallyModal() {
    final nameController = TextEditingController();
    final roleController = TextEditingController();
    final contactController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFFFFF7F2),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.black87),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Add Team Member',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: _titleDark,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                _buildModalTextField('NAME', 'Enter Worker Name', nameController),
                const SizedBox(height: 16),

                _buildModalTextField('ROLE', 'Enter Role', roleController),
                const SizedBox(height: 16),

                _buildModalTextField('CONTACT', 'Enter contact details', contactController),
                const SizedBox(height: 32),

                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFFE5CCC9)),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: const Text('Cancel', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (nameController.text.trim().isNotEmpty) {
                            final initials = nameController.text.trim().split(' ').map((e) => e.isNotEmpty ? e[0] : '').take(2).join().toUpperCase();
                            setState(() {
                              _teamMembers.add({
                                'initials': initials.isEmpty ? 'TM' : initials,
                                'name': nameController.text.trim(),
                                'role': roleController.text.trim().isEmpty ? 'worker' : roleController.text.trim(),
                                'email': contactController.text.trim().isEmpty ? 'no-email@design.com' : contactController.text.trim(),
                              });
                            });
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${nameController.text.trim()} added to team!'),
                                backgroundColor: primaryColor,
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: const Text('Add Member', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildModalTextField(String label, String hint, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black87, letterSpacing: 0.8),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: Color(0xFFE5CCC9)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: Color(0xFFE5CCC9)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: primaryColor),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredMembers = _teamMembers.where((m) {
      final name = m['name']!.toLowerCase();
      final role = m['role']!.toLowerCase();
      final email = m['email']!.toLowerCase();
      final q = _searchQuery.toLowerCase();
      return name.contains(q) || role.contains(q) || email.contains(q);
    }).toList();

    return MainScaffold(
      currentIndex: _currentIndex,
      onNavTap: _onNavTap,
      onFabPressed: _onFabPressed,
      appBarTitle: widget.projectName,
      appBarLeading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black87),
        onPressed: () => Navigator.pop(context),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Workflow Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.folder_outlined, color: primaryColor, size: 16),
                      const SizedBox(width: 6),
                      Text(
                        'PROJECT WORKFLOW',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade700,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF0EA),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE0C0B0)),
                    ),
                    child: const Text(
                      'PROGRESS 50%',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              Text(
                widget.projectName,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: _titleDark,
                ),
              ),
              const SizedBox(height: 20),

              // Step Indicator Row (Pixel-perfect)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStep(1, 'DETAILS'),
                  _buildStepDivider(1),
                  _buildStep(2, 'Team'),
                  _buildStepDivider(2),
                  _buildStep(3, 'Files'),
                  _buildStepDivider(3),
                  _buildStep(4, 'Activity'),
                ],
              ),
              const SizedBox(height: 28),

              // Search Bar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFE5CCC9)),
                ),
                child: TextField(
                  onChanged: (val) {
                    setState(() {
                      _searchQuery = val;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search by name, department...',
                    hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14),
                    prefixIcon: Icon(Icons.search, color: Colors.grey.shade500, size: 20),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Section Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Add Team Member',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: _titleDark,
                    ),
                  ),
                  Row(
                    children: const [
                      Icon(Icons.filter_list, size: 14, color: primaryColor),
                      SizedBox(width: 4),
                      Text(
                        'FILTERS',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Team Members List
              ...filteredMembers.map((member) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFE5CCC9)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: _cardPink,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            member['initials']!,
                            style: const TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              member['name']!,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: _titleDark,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              member['role']!,
                              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                            ),
                            Text(
                              member['email']!,
                              style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 16),

              // Action Buttons (Add Member & Add Manually)
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: _showAddMemberModal,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFE5CCC9)),
                    backgroundColor: const Color(0xFFFFF7F2),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    'Add Member',
                    style: TextStyle(
                      color: _titleDark,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: _showAddManuallyModal,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFE5CCC9)),
                    backgroundColor: const Color(0xFFFFF7F2),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    'Add Manually',
                    style: TextStyle(
                      color: _titleDark,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Bottom Save Draft & Next Buttons
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Team selection saved as draft!'),
                        backgroundColor: primaryColor,
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: primaryColor),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'Save Draft',
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AdminUploadFileScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Next',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStep(int number, String title) {
    final bool isActive = _currentStep == number;
    final bool isCompleted = _currentStep > number;

    return GestureDetector(
      onTap: () => _onStepTap(number),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isActive
                  ? primaryColor
                  : (isCompleted ? primaryColor.withOpacity(0.8) : const Color(0xFFF2E6E3)),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: isCompleted
                  ? const Icon(Icons.check, color: Colors.white, size: 20)
                  : Text(
                      number.toString(),
                      style: TextStyle(
                        color: isActive || isCompleted ? Colors.white : Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title.toUpperCase(),
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: isActive ? primaryColor : Colors.black87,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepDivider(int afterStep) {
    final bool isCompleted = _currentStep > afterStep;
    return Expanded(
      child: Container(
        height: 2,
        color: isCompleted ? primaryColor : const Color(0xFFF2E6E3),
        margin: const EdgeInsets.symmetric(horizontal: 4),
      ),
    );
  }
}
