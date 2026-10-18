import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

/// Utility class for safely launching external links, mailto, and docs.
class UrlHelper {
  UrlHelper._();

  /// Launches an external URL in a new browser tab or native app.
  static Future<bool> openUrl(String url) async {
    final uri = Uri.parse(url);
    try {
      if (await canLaunchUrl(uri)) {
        return await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
          webOnlyWindowName: '_blank',
        );
      }
    } catch (e) {
      debugPrint('Error launching external URL ($url): $e');
    }
    return false;
  }

  /// Launches a mailto intent with an optional subject line.
  static Future<bool> sendEmail(String email, {String? subject}) async {
    final uri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: subject != null ? {'subject': subject} : null,
    );
    try {
      return await launchUrl(uri);
    } catch (e) {
      debugPrint('Error opening email client ($email): $e');
      return false;
    }
  }
}
