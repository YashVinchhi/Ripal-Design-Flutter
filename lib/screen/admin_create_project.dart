import 'package:flutter/material.dart';
import 'package:ripal_design/resource/main_scaffold.dart';
import 'package:ripal_design/screen/admin_activity_screen.dart';
import 'package:ripal_design/screen/admin_team_screen.dart';
import 'package:ripal_design/screen/admin_upload_file_screen.dart';

class AdminCreateProject extends StatefulWidget {
  const AdminCreateProject({super.key});

  @override
  State<AdminCreateProject> createState() => _AdminCreateProjectState();
}

class _AdminCreateProjectState extends State<AdminCreateProject> {
  final Color primaryColor = const Color(0xFF5A0000);

  final int _currentStep = 1;

  final List<String> _sectorOptions = [
    'Residential Luxe',
    'Commercial Design',
    'Hospitality & Leisure',
    'Industrial & Logistics',
    'Institutional & Public',
    'Landscape & Urbanism',
  ];
  String? _selectedSector = 'Residential Luxe';

  void _onStepTap(int step) {
    if (step == 1) {
      // Already on Details
    } else if (step == 2) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminTeamScreen()));
    } else if (step == 3) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminUploadFileScreen()));
    } else if (step == 4) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminActivityScreen()));
    }
  }

  void _onSaveDraft() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Project draft saved successfully!'),
        backgroundColor: primaryColor,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _onNext() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminTeamScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      appBarTitle: 'New Project',
      appBarLeading: IconButton(
        icon: const Icon(Icons.close, color: Colors.black87),
        onPressed: () => Navigator.pop(context),
      ),
      currentIndex: 0,
      onNavTap: (index) {},
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Steps indicator (1, 2, 3, 4)
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
              const SizedBox(height: 40),

              // Step 1 Details Form
              _buildStep1Details(),

              const SizedBox(height: 40),

              // Save Draft & Next Buttons
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: _onSaveDraft,
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: primaryColor),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text('Save Draft', style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold, fontSize: 16)),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _onNext,
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
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 20,
                      ),
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

  Widget _buildStep1Details() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Project Vision', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: primaryColor)),
        const SizedBox(height: 8),
        Text(
          'Define the foundational identity and\narchitectural sector for this commission.',
          style: TextStyle(fontSize: 14, color: Colors.grey.shade700, height: 1.4),
        ),
        const SizedBox(height: 32),

        _buildTextField('PROJECT NAME', 'Enter Project Name'),
        const SizedBox(height: 20),

        _buildDropdownField('SECTOR / TYPOLOGY'),
        const SizedBox(height: 20),

        _buildTextField('ESTIMATED TIMELINE', 'Enter TimeLine'),
        const SizedBox(height: 20),

        _buildTextField('PROJECT DESCRIPTION', 'Briefly describe the architectural intent,\nmaterial palette, and spatial philosophy...', maxLines: 4),
        const SizedBox(height: 20),

        _buildTextField('TARGET BUGET RANGE', 'Enter Target Buget'),
        const SizedBox(height: 40),

        const Text('Owner / Client', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
        const SizedBox(height: 20),

        _buildTextField('Owner Name', 'Enter Owner Name', labelColor: Colors.black87),
        const SizedBox(height: 20),

        _buildTextField('Owner Email', 'Enter Owner Email', labelColor: Colors.black87),
        const SizedBox(height: 20),

        _buildTextField('Owner phone no.', 'Enter Owner Contact', labelColor: Colors.black87),
      ],
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

  Widget _buildTextField(String label, String hint, {int maxLines = 1, Color labelColor = Colors.black87}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: labelColor, letterSpacing: 0.5)),
        const SizedBox(height: 8),
        TextField(
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey.shade500),
            filled: true,
            fillColor: const Color(0xFFFFF7F2),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
              borderSide: BorderSide(color: primaryColor),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _selectedSector,
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black54),
          style: const TextStyle(fontSize: 16, color: Colors.black87),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFFFF7F2),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
              borderSide: BorderSide(color: primaryColor),
            ),
          ),
          items: _sectorOptions.map((sector) {
            return DropdownMenuItem<String>(
              value: sector,
              child: Text(sector),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedSector = value;
            });
          },
        ),
      ],
    );
  }
}
