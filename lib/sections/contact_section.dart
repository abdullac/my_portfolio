import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../core/constants/app_constants.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';
import '../core/utils/responsive.dart';
import '../core/utils/url_helper.dart';
import '../widgets/section_container.dart';

/// Contact section featuring a direct call-to-action, clickable email card with
/// one-click copy, direct mailto action, and quick links to LinkedIn and GitHub.
class ContactSection extends StatefulWidget {
  final Key? sectionKey;

  const ContactSection({super.key, this.sectionKey});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  bool _isCopied = false;

  Future<void> _copyEmailToClipboard() async {
    await Clipboard.setData(const ClipboardData(text: AppConstants.contactEmail));
    setState(() => _isCopied = true);

    if (mounted) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: const [
              Icon(Icons.check_circle_rounded, color: AppColors.primary, size: 18),
              SizedBox(width: 10),
              Text(
                'Email copied to clipboard!',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          backgroundColor: AppColors.surfaceElevated,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: AppColors.primary, width: 1),
          ),
        ),
      );
    }

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _isCopied = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return SectionContainer(
      sectionKey: widget.sectionKey,
      sectionNumber: '04. //',
      title: 'Get In Touch',
      subtitle:
          'Ready to engineer robust, high-performance web or mobile applications?',
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 820),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Direct Call-To-Action Title
              ShaderMask(
                shaderCallback: (bounds) =>
                    AppColors.heroTextGradient.createShader(bounds),
                child: Text(
                  'Let\'s connect and build something together.',
                  style: isMobile
                      ? AppTypography.h3.copyWith(color: Colors.white)
                      : AppTypography.h2.copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 16),

              // Sub-description
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 620),
                child: Text(
                  'Whether you have a question about cross-platform architecture, an interesting project opportunity, or want to discuss modern Flutter engineering, my inbox is always open.',
                  style: AppTypography.bodyLarge.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.6,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 40),

              // Clickable Email Card with One-Click Copy & Direct Mailto
              _buildEmailCard(context, isMobile: isMobile),
              const SizedBox(height: 28),

              // Quick Links to LinkedIn and GitHub
              _buildQuickLinksRow(context, isMobile: isMobile),
            ],
          ),
        ),
      ),
    );
  }

  /// Clickable Email Card with One-Click Copy and Direct mailto: Action
  Widget _buildEmailCard(BuildContext context, {required bool isMobile}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 32,
        vertical: isMobile ? 22 : 28,
      ),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.cardBorder, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(45),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
          BoxShadow(
            color: AppColors.primary.withAlpha(12),
            blurRadius: 24,
          ),
        ],
      ),
      child: isMobile
          ? Column(
              children: [
                _buildEmailInfo(),
                const SizedBox(height: 20),
                _buildEmailActionsRow(isMobile: true),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: _buildEmailInfo()),
                const SizedBox(width: 20),
                _buildEmailActionsRow(isMobile: false),
              ],
            ),
    );
  }

  Widget _buildEmailInfo() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.surfaceElevated,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.primary.withAlpha(60)),
          ),
          child: const Icon(
            Icons.alternate_email_rounded,
            color: AppColors.primary,
            size: 24,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Direct Contact Email',
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textMuted,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 3),
              SelectableText(
                AppConstants.contactEmail,
                style: AppTypography.subtitleSmall.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEmailActionsRow({required bool isMobile}) {
    return Wrap(
      spacing: 12,
      runSpacing: 10,
      alignment: WrapAlignment.center,
      children: [
        // One-Click Copy Button
        _CardActionButton(
          label: _isCopied ? 'Copied!' : 'Copy',
          icon: _isCopied ? Icons.check_rounded : Icons.copy_rounded,
          isPrimary: false,
          isSuccess: _isCopied,
          onTap: _copyEmailToClipboard,
        ),

        // Direct mailto: Action
        _CardActionButton(
          label: 'Send Email',
          icon: Icons.send_rounded,
          isPrimary: true,
          onTap: () => UrlHelper.sendEmail(
            AppConstants.contactEmail,
            subject: 'Project Inquiry / Collaboration',
          ),
        ),
      ],
    );
  }

  /// Quick Links to LinkedIn and GitHub
  Widget _buildQuickLinksRow(BuildContext context, {required bool isMobile}) {
    final links = [
      (
        label: 'LinkedIn Profile',
        sublabel: 'Connect & Network',
        faIcon: FontAwesomeIcons.linkedin,
        url: AppConstants.linkedinUrl,
      ),
      (
        label: 'GitHub Repositories',
        sublabel: 'Explore Source Code',
        faIcon: FontAwesomeIcons.github,
        url: AppConstants.githubUrl,
      ),
    ];

    if (isMobile) {
      return Column(
        children: [
          for (final link in links) ...[
            _QuickLinkCard(
              label: link.label,
              sublabel: link.sublabel,
              faIcon: link.faIcon,
              onTap: () => UrlHelper.openUrl(link.url),
            ),
            const SizedBox(height: 12),
          ],
        ],
      );
    }

    return Row(
      children: [
        for (int i = 0; i < links.length; i++) ...[
          Expanded(
            child: _QuickLinkCard(
              label: links[i].label,
              sublabel: links[i].sublabel,
              faIcon: links[i].faIcon,
              onTap: () => UrlHelper.openUrl(links[i].url),
            ),
          ),
          if (i < links.length - 1) const SizedBox(width: 16),
        ],
      ],
    );
  }
}

class _CardActionButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final bool isPrimary;
  final bool isSuccess;
  final VoidCallback onTap;

  const _CardActionButton({
    required this.label,
    required this.icon,
    required this.isPrimary,
    this.isSuccess = false,
    required this.onTap,
  });

  @override
  State<_CardActionButton> createState() => _CardActionButtonState();
}

class _CardActionButtonState extends State<_CardActionButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color border;
    Color text;

    if (widget.isSuccess) {
      bg = AppColors.primary.withAlpha(40);
      border = AppColors.primary;
      text = AppColors.primary;
    } else if (widget.isPrimary) {
      bg = _isHovered ? AppColors.primaryLight : AppColors.primary;
      border = AppColors.primary;
      text = const Color(0xFF0B0F17);
    } else {
      bg = _isHovered ? AppColors.surfaceElevated : Colors.transparent;
      border = _isHovered ? AppColors.primary : AppColors.cardBorder;
      text = _isHovered ? AppColors.primary : AppColors.textPrimary;
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: border, width: 1),
            boxShadow: (widget.isPrimary && _isHovered)
                ? [
                    BoxShadow(
                      color: AppColors.primary.withAlpha(60),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon, size: 15, color: text),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: text,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickLinkCard extends StatefulWidget {
  final String label;
  final String sublabel;
  final FaIconData faIcon;
  final VoidCallback onTap;

  const _QuickLinkCard({
    required this.label,
    required this.sublabel,
    required this.faIcon,
    required this.onTap,
  });

  @override
  State<_QuickLinkCard> createState() => _QuickLinkCardState();
}

class _QuickLinkCardState extends State<_QuickLinkCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          transform: _isHovered
              ? Matrix4.translationValues(0.0, -3.0, 0.0)
              : Matrix4.identity(),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _isHovered ? AppColors.primary.withAlpha(120) : AppColors.cardBorder,
              width: 1,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: AppColors.primary.withAlpha(25),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : null,
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _isHovered
                      ? AppColors.primary.withAlpha(30)
                      : AppColors.surfaceElevated,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _isHovered ? AppColors.primary.withAlpha(80) : AppColors.cardBorder,
                  ),
                ),
                child: FaIcon(
                  widget.faIcon,
                  size: 20,
                  color: _isHovered ? AppColors.primary : AppColors.textPrimary,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.label,
                      style: AppTypography.subtitleSmall.copyWith(
                        fontWeight: FontWeight.w700,
                        color: _isHovered ? AppColors.primary : AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.sublabel,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textMuted,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_rounded,
                size: 16,
                color: _isHovered ? AppColors.primary : AppColors.textMuted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
