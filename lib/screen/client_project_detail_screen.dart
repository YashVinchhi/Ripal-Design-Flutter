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
  final String? imageUrl;

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
    this.imageUrl,
  });

  static const Color _primary = Color(0xFF5A0000);

  final List<String> _galleryImages = const [
    'assets/project/behance_239114219_04.png',
    'assets/project/behance_239114219_05.png',
    'assets/project/behance_239114219_12.png',
    'assets/project/behance_239114219_13.png',
    'assets/project/behance_239114219_14.png',
  ];

  @override
  Widget build(BuildContext context) {
    final heroImage = imageUrl ?? _galleryImages.first;

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
              // ─── Hero Banner with Image ──────────────────────────────────
              _HeroBanner(
                projectName: projectName,
                type: type,
                progressLabel: progressLabel,
                imageUrl: heroImage,
              ),
              const SizedBox(height: 28),

              // ─── Project Gallery Section ──────────────────────────────────
              const _SectionLabel(label: 'PROJECT GALLERY'),
              const SizedBox(height: 12),
              SizedBox(
                height: 140,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _galleryImages.length,
                  itemBuilder: (context, index) {
                    final img = _galleryImages[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Container(
                          width: 200,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Image.asset(
                            img,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(color: Colors.grey.shade300),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 28),

              // ─── Progress Bar ─────────────────────────────────────────────
              const _SectionLabel(label: 'PROJECT PROGRESS'),
              const SizedBox(height: 12),
              _ProgressCard(progress: progress, label: progressLabel),
              const SizedBox(height: 28),

              // ─── Project Info ─────────────────────────────────────────────
              const _SectionLabel(label: 'PROJECT DETAILS'),
              const SizedBox(height: 12),
              _InfoCard(
                items: [
                  _InfoItem(icon: Icons.folder_outlined, label: 'TYPE', value: type),
                  _InfoItem(icon: Icons.schedule_outlined, label: 'TIMELINE', value: timeline),
                  _InfoItem(icon: Icons.location_on_outlined, label: 'LOCATION', value: location),
                  _InfoItem(icon: Icons.person_outline, label: 'CLIENT', value: clientName),
                  _InfoItem(icon: Icons.account_balance_wallet_outlined, label: 'BUDGET', value: budget),
                ],
              ),
              const SizedBox(height: 28),

              // ─── Status Timeline ──────────────────────────────────────────
              const _SectionLabel(label: 'MILESTONE STATUS'),
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
  final String imageUrl;

  const _HeroBanner({
    required this.projectName,
    required this.type,
    required this.progressLabel,
    required this.imageUrl,
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background Image
            if (imageUrl.startsWith('assets/'))
              Image.asset(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Image.asset('assets/project/behance_239114219_04.png', fit: BoxFit.cover),
              )
            else
              Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Image.asset('assets/project/behance_239114219_04.png', fit: BoxFit.cover),
              ),

            // Gradient Overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.85),
                  ],
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
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.white.withOpacity(0.4)),
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
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF5A0000)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: const Color(0xFFFDECE9),
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
        children: items.asMap().entries.map((entry) {
          final isLast = entry.key == items.length - 1;
          final item = entry.value;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    Icon(item.icon, size: 20, color: const Color(0xFF5A0000)),
                    const SizedBox(width: 14),
                    Text(
                      item.label,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        letterSpacing: 0.8,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      item.value,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2D2D2D),
                      ),
                    ),
                  ],
                ),
              ),
              if (!isLast) Divider(color: Colors.grey.shade100, height: 1),
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
  _InfoItem({required this.icon, required this.label, required this.value});
}

class _MilestoneTimeline extends StatelessWidget {
  final double progress;
  const _MilestoneTimeline({required this.progress});

  @override
  Widget build(BuildContext context) {
    final milestones = [
      _Milestone(title: 'Schematic Design', completed: progress >= 0.25),
      _Milestone(title: 'Design Development', completed: progress >= 0.50),
      _Milestone(title: 'Construction Documents', completed: progress >= 0.75),
      _Milestone(title: 'Project Handover', completed: progress >= 1.00),
    ];

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
        children: milestones.asMap().entries.map((entry) {
          final isLast = entry.key == milestones.length - 1;
          final m = entry.value;
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Icon(
                    m.completed ? Icons.check_circle : Icons.radio_button_unchecked,
                    size: 20,
                    color: m.completed ? const Color(0xFF5A0000) : Colors.grey.shade400,
                  ),
                  if (!isLast)
                    Container(
                      width: 2,
                      height: 24,
                      color: m.completed ? const Color(0xFF5A0000) : Colors.grey.shade200,
                    ),
                ],
              ),
              const SizedBox(width: 14),
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Text(
                  m.title,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: m.completed ? FontWeight.bold : FontWeight.normal,
                    color: m.completed ? const Color(0xFF2D2D2D) : Colors.grey.shade600,
                  ),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class _Milestone {
  final String title;
  final bool completed;
  _Milestone({required this.title, required this.completed});
}
