import 'package:flutter/material.dart';
import 'package:ripal_design/resource/setting_tile.dart';

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
    return SettingTile(
      icon: icon,
      title: title,
      subtitle: subtitle,
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: Colors.white,
        activeTrackColor: const Color(0xFF9E4723),
        inactiveThumbColor: Colors.grey.shade400,
        inactiveTrackColor: Colors.grey.shade200,
        trackOutlineColor: MaterialStateProperty.all(Colors.transparent),
      ),
      onTap: () => onChanged(!value),
    );
  }
}
