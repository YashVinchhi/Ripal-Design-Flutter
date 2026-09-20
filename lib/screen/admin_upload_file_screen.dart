import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:ripal_design/resource/main_scaffold.dart';
import 'package:ripal_design/screen/admin_activity_screen.dart';
import 'package:ripal_design/screen/admin_create_project.dart';
import 'package:ripal_design/screen/admin_file_view_screen.dart';
import 'package:ripal_design/screen/admin_finance_screen.dart';
import 'package:ripal_design/screen/admin_leave_screen.dart';
import 'package:ripal_design/screen/admin_team_screen.dart';
import 'package:ripal_design/screen/dashboard_screen.dart';
import 'package:ripal_design/screen/settings_screen.dart';

class AdminUploadFileScreen extends StatefulWidget {
  const AdminUploadFileScreen({super.key});

  @override
  State<AdminUploadFileScreen> createState() => _AdminUploadFileScreenState();
}

class _AdminUploadFileScreenState extends State<AdminUploadFileScreen> {
  static const Color _cardPink = Color(0xFFFCEFEA);
  static const Color primaryColor = Color(0xFF5A0000);
  static const Color _titleDark = Color(0xFF2A0501);

  int _currentIndex = 0;
  final int _currentStep = 3; // Step 3: Files

  final List<Map<String, dynamic>> _syncingFiles = [
    {
      'filename': 'Modernist_Villa_Phase_01.dwg',
      'progress': 0.82,
      'progressText': '82%',
      'icon': Icons.description_outlined,
    },
    {
      'filename': 'Material_Swatches_HD.zip',
      'progress': 0.45,
      'progressText': '45%',
      'icon': Icons.image_outlined,
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
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AdminTeamScreen()));
    } else if (step == 3) {
      // Already on Files step
    } else if (step == 4) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AdminActivityScreen()));
    }
  }

  Future<void> _onSelectProjectFiles() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.any,
      );

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          for (var file in result.files) {
            _syncingFiles.add({
              'filename': file.name,
              'progress': 1.0,
              'progressText': '100%',
              'icon': _getIconForExtension(file.extension),
            });
          }
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${result.files.length} file(s) selected: ${result.files.first.name}'),
              backgroundColor: primaryColor,
              duration: const Duration(seconds: 2),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to open file manager: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  IconData _getIconForExtension(String? ext) {
    if (ext == null) return Icons.description_outlined;
    final lower = ext.toLowerCase();
    if (['jpg', 'jpeg', 'png', 'gif', 'webp', 'bmp'].contains(lower)) {
      return Icons.image_outlined;
    } else if (['pdf'].contains(lower)) {
      return Icons.picture_as_pdf_outlined;
    } else if (['zip', 'rar', '7z', 'tar', 'gz'].contains(lower)) {
      return Icons.folder_zip_outlined;
    } else if (['dwg', 'dxf', 'cad'].contains(lower)) {
      return Icons.architecture_outlined;
    }
    return Icons.description_outlined;
  }

  void _onSaveDraft() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Project files draft saved successfully!'),
        backgroundColor: primaryColor,
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _onNext() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AdminActivityScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      currentIndex: _currentIndex,
      onNavTap: _onNavTap,
      onFabPressed: _onFabPressed,
      appBarTitle: 'Upload Files',
      appBarLeading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, color: primaryColor, size: 20),
        onPressed: () => Navigator.pop(context),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Step Indicator Row
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

              // Title Block
              const Text(
                'Submit\nBlueprints',
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Add new project files to your architectural archive. Supports DWG, PDF, and high-resolution CAD exports.',
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 13,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 24),

              // Dropzone Area with Dashed Border
              GestureDetector(
                onTap: _onSelectProjectFiles,
                child: CustomPaint(
                  painter: _DashedBorderPainter(
                    color: const Color(0xFFE0C0B0),
                    strokeWidth: 1.5,
                    gap: 4.0,
                    radius: 16.0,
                  ),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFDF8F5),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: const BoxDecoration(
                            color: _cardPink,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.upload_file_outlined, color: primaryColor, size: 28),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Drop files here or\nbrowse',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: _titleDark,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            'Upload CAD files, sketches, or high-res mood boards. Max size 100MB.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                              height: 1.4,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Select Button
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: _onSelectProjectFiles,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Select Project Files',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),

                        // View Button
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const AdminFileViewScreen()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'View Project Files',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 28),

              // Active Syncing Section Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Active Syncing',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: _titleDark,
                    ),
                  ),
                  Text(
                    '${_syncingFiles.length} FILES REMAINING',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.0,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Dynamic Syncing Items List
              ..._syncingFiles.asMap().entries.map((entry) {
                final int index = entry.key;
                final fileData = entry.value;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: _buildSyncingItem(
                    index: index,
                    filename: fileData['filename'] as String,
                    progress: (fileData['progress'] as num).toDouble(),
                    progressText: fileData['progressText'] as String,
                    icon: fileData['icon'] as IconData,
                  ),
                );
              }),
              const SizedBox(height: 20),

              // Bottom Action Buttons
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton(
                  onPressed: _onSaveDraft,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: primaryColor, width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Save Draft',
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _onNext,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Next',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: 6),
                      Icon(Icons.arrow_forward, color: Colors.white, size: 18),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
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

  Widget _buildSyncingItem({
    required int index,
    required String filename,
    required double progress,
    required String progressText,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _cardPink,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFFDF8F5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: primaryColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  filename,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: _titleDark,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(3),
                        child: LinearProgressIndicator(
                          value: progress,
                          minHeight: 5,
                          backgroundColor: const Color(0xFFE8D5CE),
                          valueColor: const AlwaysStoppedAnimation<Color>(primaryColor),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      progressText,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: Icon(Icons.close, color: Colors.grey.shade600, size: 18),
            onPressed: () {
              setState(() {
                _syncingFiles.removeAt(index);
              });
            },
          ),
        ],
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gap;
  final double radius;

  _DashedBorderPainter({
    required this.color,
    this.strokeWidth = 1.5,
    this.gap = 4.0,
    this.radius = 16.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Radius.circular(radius),
      ));

    const dashWidth = 6.0;
    for (final metric in path.computeMetrics()) {
      double distance = 0.0;
      while (distance < metric.length) {
        canvas.drawPath(
          metric.extractPath(distance, distance + dashWidth),
          paint,
        );
        distance += dashWidth + gap;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.gap != gap ||
        oldDelegate.radius != radius;
  }
}
