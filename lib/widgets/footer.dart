import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../core/constants/app_constants.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';
import '../core/utils/responsive.dart';
import '../core/utils/url_helper.dart';

/// Minimalist, elegant Footer with clean copyright line and subtle "Crafted with Flutter Web" indicator.
class Footer extends StatelessWidget {
  final VoidCallback? onBackToTop;

  const Footer({super.key, this.onBackToTop});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20.0 : 40.0,
        vertical: 36.0,
      ),
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(
          top: BorderSide(color: AppColors.cardBorder, width: 1),
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppConstants.maxContentWidth,
          ),
          child: Column(
            children: [
              // Subtle "Crafted with Flutter Web" Indicator
              _buildCraftedIndicator(),
              const SizedBox(height: 20),

              // Social Icons Row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _FooterSocialButton(
                    icon: FontAwesomeIcons.github,
                    tooltip: 'GitHub',
                    onTap: () => UrlHelper.openUrl(AppConstants.githubUrl),
                  ),
                  const SizedBox(width: 14),
                  _FooterSocialButton(
                    icon: FontAwesomeIcons.linkedin,
                    tooltip: 'LinkedIn',
                    onTap: () => UrlHelper.openUrl(AppConstants.linkedinUrl),
                  ),
                  const SizedBox(width: 14),
                  _FooterSocialButton(
                    icon: FontAwesomeIcons.envelope,
                    tooltip: 'Email',
                    onTap: () => UrlHelper.sendEmail(AppConstants.contactEmail),
                  ),
                  if (onBackToTop != null) ...[
                    const SizedBox(width: 14),
                    _FooterSocialButton(
                      icon: FontAwesomeIcons.arrowUp,
                      tooltip: 'Back to Top',
                      onTap: onBackToTop!,
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 24),

              // Clean Copyright Line
              Text(
                'Created by ${AppConstants.developerName} • All rights reserved',
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textMuted,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Subtle "Crafted with Flutter Web" indicator
  Widget _buildCraftedIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 8,
          runSpacing: 4,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.flutter_dash,
                  size: 15,
                  color: AppColors.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Crafted with Flutter Web',
                  style: AppTypography.bodySmall.copyWith(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 5,
                  height: 5,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  'Wasm Engine',
                  style: AppTypography.bodySmall.copyWith(
                    fontSize: 10,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _FooterSocialButton extends StatefulWidget {
  final FaIconData icon;
  final String tooltip;
  final VoidCallback onTap;

  const _FooterSocialButton({
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  @override
  State<_FooterSocialButton> createState() => _FooterSocialButtonState();
}

class _FooterSocialButtonState extends State<_FooterSocialButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _isHovered
                  ? AppColors.surfaceElevated
                  : AppColors.surface,
              shape: BoxShape.circle,
              border: Border.all(
                color: _isHovered ? AppColors.primary : AppColors.cardBorder,
                width: 1,
              ),
              boxShadow: _isHovered
                  ? [
                      BoxShadow(
                        color: AppColors.primary.withAlpha(45),
                        blurRadius: 10,
                      )
                    ]
                  : null,
            ),
            child: FaIcon(
              widget.icon,
              size: 14,
              color: _isHovered ? AppColors.primary : AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
