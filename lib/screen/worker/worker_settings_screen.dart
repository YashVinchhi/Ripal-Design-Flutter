import 'package:flutter/material.dart';
import 'package:ripal_design/screen/settings_screen.dart';

export 'package:ripal_design/screen/settings_screen.dart';

/// Worker Settings Screen delegates to the unified [SettingsScreen]
/// with the worker role pre-configured.
class WorkerSettingsScreen extends StatelessWidget {
  const WorkerSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SettingsScreen(initialRole: 'worker');
  }
}
