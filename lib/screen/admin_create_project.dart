import 'package:flutter/material.dart';
import 'package:ripal_design/resource/main_scaffold.dart';

class AdminCreateProject extends StatefulWidget {
  const AdminCreateProject({super.key});

  @override
  State<AdminCreateProject> createState() => _AdminCreateProjectState();
}

class _AdminCreateProjectState extends State<AdminCreateProject> {
  final Color primaryColor = const Color(0xFF5A0000);
  
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
              // Steps indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStep(1, 'DETAILS', isActive: true),
                  _buildStepDivider(),
                  _buildStep(2, 'Team'),
                  _buildStepDivider(),
                  _buildStep(3, 'Files'),
                  _buildStepDivider(),
                  _buildStep(4, 'Activity'),
                ],
              ),
              const SizedBox(height: 40),

              Text('Project Vision', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: primaryColor)),
              const SizedBox(height: 8),
              Text(
                'Define the foundational identity and\narchitectural sector for this commission.',
                style: TextStyle(fontSize: 14, color: Colors.grey.shade700, height: 1.4),
              ),
              const SizedBox(height: 32),

              _buildTextField('PROJECT NAME', 'Enter Project Name'),
              const SizedBox(height: 20),
              
              _buildDropdownField('SECTOR / TYPOLOGY', 'Residential Luxe'),
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
              const SizedBox(height: 40),

              // Buttons
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF5A0000)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Save Draft', style: TextStyle(color: Color(0xFF5A0000), fontWeight: FontWeight.bold, fontSize: 16)),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Next', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
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

  Widget _buildStep(int number, String title, {bool isActive = false}) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: isActive ? primaryColor : const Color(0xFFF2E6E3),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              number.toString(),
              style: TextStyle(
                color: isActive ? Colors.white : Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: isActive ? primaryColor : Colors.black87,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildStepDivider() {
    return Expanded(
      child: Container(
        height: 1,
        color: const Color(0xFFF2E6E3),
        margin: const EdgeInsets.symmetric(horizontal: 8),
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
            fillColor: const Color(0xFFFFF7F2), // same as background or white depending on the design
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

  Widget _buildDropdownField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black87, letterSpacing: 0.5)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFE5CCC9)),
            borderRadius: BorderRadius.circular(4),
            color: const Color(0xFFFFF7F2),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(value, style: const TextStyle(fontSize: 16, color: Colors.black87)),
              const Icon(Icons.keyboard_arrow_down, color: Colors.black54),
            ],
          ),
        ),
      ],
    );
  }
}
