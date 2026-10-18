import 'package:flutter/material.dart';

enum DeviceType { mobile, tablet, desktop }

/// Clean responsive layout helper with standard breakpoints:
/// - Mobile: < 768px
/// - Tablet: 768px - 1024px
/// - Desktop: > 1024px
class Responsive extends StatelessWidget {
  static const double mobileBreakpoint = 768.0;
  static const double desktopBreakpoint = 1024.0;

  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const Responsive({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

  /// Check if current screen is Mobile (< 768px)
  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < mobileBreakpoint;

  /// Check if current screen is Tablet (768px - 1024px)
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return width >= mobileBreakpoint && width <= desktopBreakpoint;
  }

  /// Check if current screen is Desktop (> 1024px)
  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width > desktopBreakpoint;

  /// Get current DeviceType enum
  static DeviceType deviceTypeOf(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width > desktopBreakpoint) {
      return DeviceType.desktop;
    } else if (width >= mobileBreakpoint) {
      return DeviceType.tablet;
    } else {
      return DeviceType.mobile;
    }
  }

  /// Convenience method for retrieving responsive values based on current screen size.
  static T value<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    required T desktop,
  }) {
    final width = MediaQuery.sizeOf(context).width;
    if (width > desktopBreakpoint) {
      return desktop;
    } else if (width >= mobileBreakpoint) {
      return tablet ?? desktop;
    } else {
      return mobile;
    }
  }

  /// Screen width helper
  static double screenWidth(BuildContext context) =>
      MediaQuery.sizeOf(context).width;

  /// Screen height helper
  static double screenHeight(BuildContext context) =>
      MediaQuery.sizeOf(context).height;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    if (width > desktopBreakpoint) {
      return desktop;
    } else if (width >= mobileBreakpoint) {
      return tablet ?? desktop;
    } else {
      return mobile;
    }
  }
}
