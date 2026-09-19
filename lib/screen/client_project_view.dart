import 'package:flutter/material.dart';
import 'package:ripal_design/resource/project_card.dart';
import 'package:ripal_design/resource/client_scaffold.dart';
import 'package:ripal_design/screen/client_contactus.dart';
import 'package:ripal_design/screen/client_settings.dart';

class ClientProjectView extends StatefulWidget {
  const ClientProjectView({super.key});

  @override
  State<ClientProjectView> createState() => _ClientProjectViewState();
}

class _ClientProjectViewState extends State<ClientProjectView> {
  final Color titleColor = const Color(0xFF5A0000);
  final Color primaryColor = const Color(0xFF9E4723);

  int _currentIndex = 1;
  String _selectedFilter = 'ALL PROJECTS';
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  final List<String> _filters = [
    'ALL PROJECTS',
    'RESIDENTIAL',
    'COMMERCIAL',
    'INTERIOR',
  ];

  // Each project has a 'height' to create the staggered Pinterest masonry effect.
  final List<Map<String, dynamic>> _projects = [
    {
      'name': 'Verdian Heights',
      'category': 'RESIDENTIAL',
      'year': '2023',
      'height': 220.0,
    },
    {
      'name': 'The Quartz Pavilion',
      'category': 'COMMERCIAL',
      'year': '2023',
      'height': 170.0,
    },
    {
      'name': 'Terracotta Studio',
      'category': 'INTERIOR',
      'year': '2023',
      'height': 180.0,
    },
    {
      'name': 'Echo Cabin',
      'category': 'RESIDENTIAL',
      'year': '2023',
      'height': 240.0,
    },
    {
      'name': 'Skyline Loft',
      'category': 'RESIDENTIAL',
      'year': '2023',
      'height': 190.0,
    },
    {
      'name': 'The Curve Museum',
      'category': 'COMMERCIAL',
      'year': '2023',
      'height': 210.0,
    },
    {
      'name': 'Amber Courtyard',
      'category': 'INTERIOR',
      'year': '2023',
      'height': 160.0,
    },
    {
      'name': 'Black Glass Tower',
      'category': 'COMMERCIAL',
      'year': '2023',
      'height': 230.0,
    },
  ];

  List<Map<String, dynamic>> get _filteredProjects {
    return _projects.where((p) {
      final matchesFilter =
          _selectedFilter == 'ALL PROJECTS' || p['category'] == _selectedFilter;
      final matchesSearch =
          _searchQuery.isEmpty ||
          (p['name'] as String).toLowerCase().contains(
            _searchQuery.toLowerCase(),
          );
      return matchesFilter && matchesSearch;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredProjects;

    return ClientScaffold(
      currentIndex: _currentIndex,
      onFabPressed: () {},
      onNavTap: (index) {
        if (index == _currentIndex) return;
        if (index == 0) {
          Navigator.pop(context); // Go back to Dashboard
          return;
        }
        if (index == 2) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ClientContactus()),
          );
          return;
        }
        if (index == 3) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ClientSettings()),
          );
          return;
        }
        setState(() => _currentIndex = index);
      },
      body: SafeArea(
        child: Column(
          children: [
            // ─── Search Bar ─────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
              child: TextField(
                controller: _searchController,
                onChanged: (val) => setState(() => _searchQuery = val),
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'Search projects...',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 14,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey.shade500,
                    size: 20,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: primaryColor, width: 1.5),
                  ),
                ),
              ),
            ),

            // ─── Filter Chips ────────────────────────────
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  ..._filters.map((f) => _buildFilterChip(f)),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Text(
                      '${filtered.length}',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // ─── Pinterest 2-Column Masonry Grid ──────
            Expanded(
              child: filtered.isEmpty
                  ? Center(
                      child: Text(
                        'No projects found.',
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 14,
                        ),
                      ),
                    )
                  : _buildMasonryGrid(filtered),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds a 2-column Pinterest-style masonry grid without external packages.
  Widget _buildMasonryGrid(List<Map<String, dynamic>> items) {
    // Split items into left (even indices) and right (odd indices) columns.
    final leftItems = <Map<String, dynamic>>[];
    final rightItems = <Map<String, dynamic>>[];
    for (int i = 0; i < items.length; i++) {
      if (i % 2 == 0) {
        leftItems.add(items[i]);
      } else {
        rightItems.add(items[i]);
      }
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left column
          Expanded(
            child: Column(
              children: leftItems
                  .map(
                    (p) => Padding(
                      padding: const EdgeInsets.only(bottom: 12, right: 6),
                      child: ProjectCard(
                        name: p['name'] as String,
                        category: p['category'] as String,
                        year: p['year'] as String,
                        height: (p['height'] as num?)?.toDouble() ?? 200.0,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          // Right column
          Expanded(
            child: Column(
              children: [
                // Offset the right column slightly for the Pinterest stagger feel
                const SizedBox(height: 28),
                ...rightItems.map(
                  (p) => Padding(
                    padding: const EdgeInsets.only(bottom: 12, left: 6),
                    child: ProjectCard(
                      name: p['name'] as String,
                      category: p['category'] as String,
                      year: p['year'] as String,
                      height: p['height'] as double,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final bool isSelected = _selectedFilter == label;
    return GestureDetector(
      onTap: () => setState(() => _selectedFilter = label),
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? titleColor : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? titleColor : Colors.grey.shade300,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey.shade700,
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}
