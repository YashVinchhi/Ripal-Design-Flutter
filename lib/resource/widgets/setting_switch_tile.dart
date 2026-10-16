import 'package:flutter/material.dart';
import 'package:ripal_design/resource/widgets/setting_tile.dart';

class SettingSwitchTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const SettingSwitchTile({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SettingTile(
      icon: icon,
      title: title,
      subtitle: subtitle,
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeThumbColor: Colors.white,
        activeTrackColor: isDark ? const Color(0xFFE07A5F) : const Color(0xFF9E4723),
        inactiveThumbColor: isDark ? Colors.grey.shade500 : Colors.grey.shade400,
        inactiveTrackColor: isDark ? const Color(0xFF333333) : Colors.grey.shade200,
        trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
      ),
      onTap: () => onChanged(!value),
    );
  }
}
