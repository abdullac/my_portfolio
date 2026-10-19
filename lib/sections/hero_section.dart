import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../core/constants/app_constants.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';
import '../core/utils/responsive.dart';
import '../core/utils/url_helper.dart';
import '../widgets/custom_button.dart';

/// High-impact, minimalist Hero Section with status badge, punchy headline,
/// concise bio, primary/secondary CTAs, social links, and desktop architecture showcase card.
class HeroSection extends StatelessWidget {
  final VoidCallback onProjectsPressed;
  final VoidCallback onContactPressed;

  const HeroSection({
    super.key,
    required this.onProjectsPressed,
    required this.onContactPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20.0 : 40.0,
        vertical: isMobile ? 48.0 : 80.0,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppConstants.maxContentWidth,
          ),
          child: isDesktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 6,
                      child: _buildHeroContent(context, isMobile: false),
                    ),
                    const SizedBox(width: 48),
                    Expanded(
                      flex: 5,
                      child: _buildShowcaseCard(context),
                    ),
                  ],
                )
              : _buildHeroContent(context, isMobile: isMobile),
        ),
      ),
    );
  }

  /// Left/Primary Hero Content
  Widget _buildHeroContent(BuildContext context, {required bool isMobile}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // 1. Status Badge
        _buildStatusBadge(),
        const SizedBox(height: 24),

        // 2. Main Headline
        _buildHeadline(context, isMobile: isMobile),
        const SizedBox(height: 20),

        // 3. Subtitle / Bio
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Text(
            AppConstants.developerTagline,
            style: isMobile
                ? AppTypography.bodyLarge.copyWith(fontSize: 15)
                : AppTypography.subtitle,
          ),
        ),
        const SizedBox(height: 36),

        // 4. CTA Buttons
        Wrap(
          spacing: 16,
          runSpacing: 14,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            CustomButton(
              text: 'View Projects',
              variant: ButtonVariant.primary,
              icon: Icons.arrow_forward_rounded,
              onPressed: onProjectsPressed,
            ),
            CustomButton(
              text: 'Contact Me',
              variant: ButtonVariant.outline,
              icon: Icons.mail_outline_rounded,
              onPressed: onContactPressed,
            ),
          ],
        ),
        const SizedBox(height: 36),

        // 5. Minimalist Social Icons Row
        _buildSocialIconsRow(),
      ],
    );
  }

  /// Status Badge: "🟢 Available for projects / Flutter Developer"
  Widget _buildStatusBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: AppColors.cardBorder,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withAlpha(20),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withAlpha(180),
                  blurRadius: 6,
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              'Available for Projects & Opportunities',
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Punchy Main Headline: "Abdulla — Flutter Developer"
  Widget _buildHeadline(BuildContext context, {required bool isMobile}) {
    return Text.rich(
      TextSpan(
        text: 'Abdulla\n',
        style: (isMobile ? AppTypography.h2 : AppTypography.h1).copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w800,
          height: 1.15,
        ),
        children: [
          WidgetSpan(
            alignment: PlaceholderAlignment.baseline,
            baseline: TextBaseline.alphabetic,
            child: ShaderMask(
              shaderCallback: (bounds) =>
                  AppColors.heroTextGradient.createShader(bounds),
              child: Text(
                'Flutter Developer',
                style: (isMobile ? AppTypography.h3 : AppTypography.h1).copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  height: 1.15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Minimalist Hoverable Social Icons
  Widget _buildSocialIconsRow() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _HeroSocialButton(
          icon: FontAwesomeIcons.github,
          tooltip: 'GitHub Profile',
          onTap: () => UrlHelper.openUrl(AppConstants.githubUrl),
        ),
        const SizedBox(width: 12),
        _HeroSocialButton(
          icon: FontAwesomeIcons.linkedin,
          tooltip: 'LinkedIn Profile',
          onTap: () => UrlHelper.openUrl(AppConstants.linkedinUrl),
        ),
        const SizedBox(width: 12),
        _HeroSocialButton(
          icon: FontAwesomeIcons.envelope,
          tooltip: 'Send Email',
          onTap: () => UrlHelper.sendEmail(AppConstants.contactEmail),
        ),
      ],
    );
  }

  /// Sleek Architecture / Code Showcase Card
  Widget _buildShowcaseCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.cardBorder, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(60),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
          BoxShadow(
            color: AppColors.primary.withAlpha(15),
            blurRadius: 20,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // macOS Window Controls
          Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Color(0xFFEF4444),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Color(0xFFF59E0B),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Color(0xFF10B981),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  'developer_profile.dart',
                  style: AppTypography.code.copyWith(
                    fontSize: 11,
                    color: AppColors.textMuted,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Code lines preview
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.background.withAlpha(160),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.cardBorder),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCodeLine('class', ' FlutterDeveloper {', isKeyword: true),
                _buildCodeLine('  final', ' name = \'Abdulla\';', isKeyword: true),
                _buildCodeLine('  final', ' role = \'Flutter Developer\';', isKeyword: true),
                _buildCodeLine('  final', ' apps = [\'Web\', \'Android\', \'iOS\', \'Desktop\'];', isKeyword: true),
                _buildCodeLine('  final', ' skills = [\'Flutter\', \'BLoC\', \'Freezed\', \'Dio\'];', isKeyword: true),
                _buildCodeLine('}', '', isKeyword: true),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Key Highlights Badges
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const [
              _FeatureBadge(label: 'Flutter & Dart', icon: Icons.flutter_dash),
              _FeatureBadge(label: 'BLoC & Freezed', icon: Icons.layers_outlined),
              _FeatureBadge(label: 'Responsive UI', icon: Icons.devices_rounded),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCodeLine(String keyword, String rest, {bool isKeyword = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Text.rich(
        TextSpan(
          text: keyword,
          style: AppTypography.code.copyWith(
            fontSize: 12,
            color: AppColors.secondary,
            fontWeight: FontWeight.w600,
          ),
          children: [
            TextSpan(
              text: rest,
              style: AppTypography.code.copyWith(
                fontSize: 12,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureBadge extends StatelessWidget {
  final String label;
  final IconData icon;

  const _FeatureBadge({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.surfaceElevated,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.primary),
          const SizedBox(width: 6),
          Text(
            label,
            style: AppTypography.bodySmall.copyWith(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroSocialButton extends StatefulWidget {
  final FaIconData icon;
  final String tooltip;
  final VoidCallback onTap;

  const _HeroSocialButton({
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  @override
  State<_HeroSocialButton> createState() => _HeroSocialButtonState();
}

class _HeroSocialButtonState extends State<_HeroSocialButton> {
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
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _isHovered
                  ? AppColors.surfaceElevated
                  : AppColors.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _isHovered ? AppColors.primary : AppColors.cardBorder,
                width: 1,
              ),
              boxShadow: _isHovered
                  ? [
                      BoxShadow(
                        color: AppColors.primary.withAlpha(40),
                        blurRadius: 10,
                      ),
                    ]
                  : null,
            ),
            child: FaIcon(
              widget.icon,
              size: 16,
              color: _isHovered ? AppColors.primary : AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
