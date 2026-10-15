import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Renders an image safely across Flutter Web and Native (Android, iOS, Desktop).
/// Prevents `Image.file is not supported on Flutter Web` assertion errors.
Widget buildProfileImage(
  String? path, {
  double? width,
  double? height,
  BoxFit fit = BoxFit.cover,
  Widget? fallback,
}) {
  final defaultFallback = fallback ??
      const Icon(
        Icons.person,
        size: 48,
        color: Color(0xFF5A0000),
      );

  if (path == null || path.trim().isEmpty) {
    return defaultFallback;
  }

  final trimmedPath = path.trim();

  if (kIsWeb) {
    if (trimmedPath.startsWith('assets/')) {
      return Image.asset(
        trimmedPath,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) => defaultFallback,
      );
    }
    return Image.network(
      trimmedPath,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) => defaultFallback,
    );
  } else {
    if (trimmedPath.startsWith('assets/')) {
      return Image.asset(
        trimmedPath,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) => defaultFallback,
      );
    }
    if (trimmedPath.startsWith('http://') || trimmedPath.startsWith('https://')) {
      return Image.network(
        trimmedPath,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) => defaultFallback,
      );
    }
    try {
      final file = File(trimmedPath);
      if (file.existsSync()) {
        return Image.file(
          file,
          width: width,
          height: height,
          fit: fit,
          errorBuilder: (context, error, stackTrace) => defaultFallback,
        );
      }
    } catch (_) {}
    return defaultFallback;
  }
}
