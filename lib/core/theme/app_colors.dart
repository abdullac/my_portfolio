import 'package:flutter/material.dart';

/// Minimalist, sleek modern color system tailored for dark obsidian developer interfaces.
class AppColors {
  AppColors._();

  // Background
  static const Color background = Color(0xFF0B0F17); // Deep slate / obsidian

  // Card & Surfaces
  static const Color surface = Color(0xFF161F30); // Elevated dark slate
  static const Color surfaceElevated = Color(0xFF1E293B); // Higher elevation slate
  static const Color card = Color(0xFF161F30); // Card surface

  // Borders
  static const Color cardBorder = Color(0x14FFFFFF); // Low opacity white border (rgba 255, 255, 255, 0.08)
  static const Color cardBorderHover = Color(0x3310B981); // Emerald glow border on hover
  static const Color borderLight = Color(0x1FFFFFFF); // 12% opacity white border

  // Accent Primary (Emerald / Teal)
  static const Color primary = Color(0xFF10B981); // Elegant Emerald
  static const Color primaryDark = Color(0xFF059669); // Deep Emerald
  static const Color primaryLight = Color(0xFF34D399); // Light Mint
  static const Color primaryVariant = Color(0xFF14B8A6); // Radiant Teal
  static const Color accent = Color(0xFF10B981); // Emerald accent alias

  // Accent Secondary (Electric Indigo)
  static const Color secondary = Color(0xFF6366F1); // Electric Indigo
  static const Color secondaryLight = Color(0xFF818CF8); // Soft Indigo

  // Text Hierarchy
  static const Color textPrimary = Color(0xFFF8FAFC); // High contrast off-white for titles & headers
  static const Color textSecondary = Color(0xFF94A3B8); // Muted slate for body
  static const Color textMuted = Color(0xFF64748B); // Slate muted for captions & subtle labels

  // Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);

  // Curated Minimalist Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryVariant],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient indigoGradient = LinearGradient(
    colors: [secondary, Color(0xFF8B5CF6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient heroTextGradient = LinearGradient(
    colors: [Color(0xFFFFFFFF), Color(0xFFF8FAFC), Color(0xFF10B981)],
    stops: [0.0, 0.5, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGlowGradient = LinearGradient(
    colors: [Color(0x1410B981), Color(0x056366F1)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
