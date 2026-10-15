import 'package:flutter/material.dart';

class AppNotificationIcon extends StatelessWidget {
  final Color color;
  final double size;

  const AppNotificationIcon({
    super.key,
    Color? color,
    Color? iconColor,
    this.size = 24.0,
  }) : color = color ?? iconColor ?? const Color(0xFF5A0000);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.notifications_none_outlined, color: color, size: size),
      tooltip: 'Notifications',
      onPressed: () => showNotificationsModal(context),
    );
  }

  static void showNotificationsModal(BuildContext context) {
    const primaryColor = Color(0xFF5A0000);
    const titleDark = Color(0xFF2A0501);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFFFFF7F2),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.65,
          maxChildSize: 0.85,
          minChildSize: 0.4,
          expand: false,
          builder: (context, scrollController) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Notifications',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: titleDark,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFBECEB),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              '3 New',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('All notifications marked as read'),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        },
                        child: const Text(
                          'Mark All Read',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(color: Color(0xFFF2DED7), height: 20),
                  Expanded(
                    child: ListView(
                      controller: scrollController,
                      children: [
                        _buildNotificationTile(
                          icon: Icons.architecture,
                          title: 'Project Milestone Updated',
                          subtitle: 'Skyline Plaza structural framework reached 75% completion.',
                          time: '10m ago',
                          isNew: true,
                        ),
                        const SizedBox(height: 12),
                        _buildNotificationTile(
                          icon: Icons.event_available,
                          title: 'Leave Request Approved',
                          subtitle: 'Your leave request for Annual Leave has been approved by management.',
                          time: '2h ago',
                          isNew: true,
                        ),
                        const SizedBox(height: 12),
                        _buildNotificationTile(
                          icon: Icons.cloud_upload_outlined,
                          title: 'New Blueprint Uploaded',
                          subtitle: 'Modernist_Villa_Phase_01.dwg synced to the project repository.',
                          time: 'Yesterday',
                          isNew: false,
                        ),
                        const SizedBox(height: 12),
                        _buildNotificationTile(
                          icon: Icons.assignment_turned_in_outlined,
                          title: 'Welcome to Ripal Design',
                          subtitle: 'Your workspace and team profile are active and ready.',
                          time: '3d ago',
                          isNew: false,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  static Widget _buildNotificationTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required String time,
    required bool isNew,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isNew ? const Color(0xFFE2C4BD) : const Color(0xFFF2DED7),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFFBECEB),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.notifications_active_outlined,
              color: Color(0xFF5A0000),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2A0501),
                      ),
                    ),
                    Text(
                      time,
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade700,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
