import 'package:flutter/material.dart';

/// A read-only project detail screen for the client role.
/// No admin navigation links, no admin actions.
class ClientProjectDetailScreen extends StatelessWidget {
  final String projectName;
  final String clientName;
  final String budget;
  final String timeline;
  final String type;
  final String location;
  final double progress;
  final String progressLabel;

  const ClientProjectDetailScreen({
    super.key,
    this.projectName = 'Project',
    this.clientName = 'Client',
    this.budget = '—',
    this.timeline = '—',
    this.type = '—',
    this.location = '—',
    this.progress = 0.5,
    this.progressLabel = '50% Completed',
  });

  static const Color _primary = Color(0xFF5A0000);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF7F2),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: _primary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          projectName.toUpperCase(),
          style: const TextStyle(
            color: _primary,
            fontWeight: FontWeight.bold,
            fontSize: 16,
            letterSpacing: 0.5,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ─── Hero Banner ──────────────────────────────────────────────
              _HeroBanner(
                projectName: projectName,
                type: type,
                progressLabel: progressLabel,
              ),
              const SizedBox(height: 28),

              // ─── Progress Bar ─────────────────────────────────────────────
              _SectionLabel(label: 'PROJECT PROGRESS'),
              const SizedBox(height: 12),
              _ProgressCard(progress: progress, label: progressLabel),
              const SizedBox(height: 28),

              // ─── Project Info ─────────────────────────────────────────────
              _SectionLabel(label: 'PROJECT DETAILS'),
              const SizedBox(height: 12),
              _InfoCard(
                items: [
                  _InfoItem(icon: Icons.folder_outlined, label: 'TYPE', value: type),
                  _InfoItem(icon: Icons.schedule_outlined, label: 'TIMELINE', value: timeline),
                  _InfoItem(icon: Icons.location_on_outlined, label: 'LOCATION', value: location),
                  _InfoItem(icon: Icons.person_outline, label: 'CLIENT', value: clientName),
                ],
              ),
              const SizedBox(height: 28),

              // ─── Status Timeline ──────────────────────────────────────────
              _SectionLabel(label: 'MILESTONE STATUS'),
              const SizedBox(height: 12),
              _MilestoneTimeline(progress: progress),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Sub-widgets ──────────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.4,
        color: Colors.grey,
      ),
    );
  }
}

class _HeroBanner extends StatelessWidget {
  final String projectName;
  final String type;
  final String progressLabel;

  const _HeroBanner({
    required this.projectName,
    required this.type,
    required this.progressLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFF2A0501),
      ),
      child: Stack(
        children: [
          // Subtle pattern
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CustomPaint(painter: _GridPatternPainter()),
            ),
          ),
          // Gradient
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0x885A0000),
                    Color(0xCC2A0501),
                  ],
                ),
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.white.withOpacity(0.3)),
                  ),
                  child: Text(
                    type.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  projectName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.check_circle_outline, color: Colors.white70, size: 14),
                    const SizedBox(width: 6),
                    Text(
                      progressLabel,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgressCard extends StatelessWidget {
  final double progress;
  final String label;
  const _ProgressCard({required this.progress, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Overall Completion',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF2D2D2D)),
              ),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5A0000),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 10,
              backgroundColor: const Color(0xFFFADCDC),
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF5A0000)),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final List<_InfoItem> items;
  const _InfoCard({required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: items.asMap().entries.map((entry) {
          final i = entry.key;
          final item = entry.value;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFCEFEA),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(item.icon, color: const Color(0xFF5A0000), size: 18),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.label,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            item.value,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF2D2D2D),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (i < items.length - 1)
                const Divider(height: 1, thickness: 1, color: Color(0xFFF5F5F5), indent: 20, endIndent: 20),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class _InfoItem {
  final IconData icon;
  final String label;
  final String value;
  const _InfoItem({required this.icon, required this.label, required this.value});
}

class _MilestoneTimeline extends StatelessWidget {
  final double progress;
  const _MilestoneTimeline({required this.progress});

  static const _milestones = [
    ('PLANNING', 'Site survey, concept, permits'),
    ('DESIGN', 'Schematics & detailed drawings'),
    ('CONSTRUCTION', 'Foundation, structure, MEP'),
    ('FINISHING', 'Interiors, landscape, handover'),
  ];

  @override
  Widget build(BuildContext context) {
    final completedSteps = (progress * 4).ceil();
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        children: _milestones.asMap().entries.map((entry) {
          final i = entry.key;
          final milestone = entry.value;
          final isDone = i < completedSteps - 1;
          final isCurrent = i == completedSteps - 1;

          Color dotColor;
          IconData dotIcon;
          Color textColor;
          if (isDone) {
            dotColor = const Color(0xFF5A0000);
            dotIcon = Icons.check;
            textColor = const Color(0xFF5A0000);
          } else if (isCurrent) {
            dotColor = const Color(0xFF9E4723);
            dotIcon = Icons.timelapse;
            textColor = const Color(0xFF9E4723);
          } else {
            dotColor = Colors.grey.shade300;
            dotIcon = Icons.circle_outlined;
            textColor = Colors.grey.shade500;
          }

          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: dotColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(dotIcon, color: Colors.white, size: 16),
                    ),
                    if (i < _milestones.length - 1)
                      Container(
                        width: 2,
                        height: 28,
                        color: isDone ? const Color(0xFF5A0000) : Colors.grey.shade200,
                      ),
                  ],
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          milestone.$1,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          milestone.$2,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade500,
                          ),
                        ),
                        if (isCurrent)
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFCEFEA),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                'IN PROGRESS',
                                style: TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF9E4723),
                                  letterSpacing: 0.8,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

/// Subtle grid background pattern for the hero banner.
class _GridPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..strokeWidth = 1;
    const step = 28.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(_GridPatternPainter oldDelegate) => false;
}
