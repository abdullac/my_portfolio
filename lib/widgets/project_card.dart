import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';
import '../models/project_model.dart';

/// Reusable interactive project showcase card with 16:9 preview,
/// tech badges, action links, and hover elevation lift.
class ProjectCard extends StatefulWidget {
  final ProjectModel project;

  const ProjectCard({super.key, required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
          webOnlyWindowName: '_blank',
        );
      }
    } catch (e) {
      debugPrint('Error launching project link ($url): $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        transform: _isHovered
            ? Matrix4.translationValues(0.0, -4.0, 0.0)
            : Matrix4.identity(),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: _isHovered
                ? AppColors.primary.withAlpha(140)
                : AppColors.cardBorder,
            width: 1,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: AppColors.primary.withAlpha(35),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                  BoxShadow(
                    color: Colors.black.withAlpha(80),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withAlpha(40),
                    blurRadius: 14,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // 1. 16:9 Aspect Ratio Preview Container
            _build16x9Preview(),

            // 2. Project Details (Header, Description, Tech Stack, Actions)
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Badge + Title
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.project.title,
                          style: AppTypography.subtitle.copyWith(
                            fontWeight: FontWeight.w700,
                            color: _isHovered
                                ? AppColors.primary
                                : AppColors.textPrimary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (widget.project.badge != null) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withAlpha(25),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: AppColors.primary.withAlpha(80),
                            ),
                          ),
                          child: Text(
                            widget.project.badge!,
                            style: AppTypography.badge.copyWith(
                              fontSize: 10,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Description
                  Text(
                    widget.project.description,
                    style: AppTypography.bodyMedium.copyWith(
                      height: 1.55,
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 20),

                  // Tech-Stack Badges
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: widget.project.technologies.map((tech) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceElevated,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.cardBorder),
                        ),
                        child: Text(
                          tech,
                          style: AppTypography.bodySmall.copyWith(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),

                  // Divider
                  Container(
                    height: 1,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.cardBorder, Colors.transparent],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Action Links ("Live Demo" and "Source Code")
                  Wrap(
                    spacing: 12,
                    runSpacing: 8,
                    children: [
                      if (widget.project.liveUrl != null)
                        _ActionLinkButton(
                          label: 'Live Demo',
                          icon: Icons.open_in_new_rounded,
                          isPrimary: true,
                          onTap: () => _launchUrl(widget.project.liveUrl!),
                        ),
                      if (widget.project.githubUrl != null)
                        _ActionLinkButton(
                          label: 'Source Code',
                          faIcon: FontAwesomeIcons.github,
                          isPrimary: false,
                          onTap: () => _launchUrl(widget.project.githubUrl!),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Modern 16:9 Aspect Ratio Preview Container
  Widget _build16x9Preview() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(17)),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.surfaceElevated,
                AppColors.card,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Subtle Grid Background Pattern
              CustomPaint(
                painter: _GridPatternPainter(),
              ),

              // Ambient Center Glow
              Center(
                child: Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppColors.primary.withAlpha(_isHovered ? 40 : 20),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),

              // Mockup Center Display
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: _isHovered
                              ? AppColors.primary.withAlpha(120)
                              : AppColors.cardBorder,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(50),
                            blurRadius: 16,
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.devices_rounded,
                        size: 32,
                        color: _isHovered ? AppColors.primary : AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.project.title,
                      style: AppTypography.code.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              // Status Chip in Preview Corner
              Positioned(
                top: 14,
                right: 14,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.background.withAlpha(200),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.cardBorder),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Interactive Demo',
                        style: AppTypography.bodySmall.copyWith(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Action Link Button with Hover Feedback
class _ActionLinkButton extends StatefulWidget {
  final String label;
  final IconData? icon;
  final FaIconData? faIcon;
  final bool isPrimary;
  final VoidCallback onTap;

  const _ActionLinkButton({
    required this.label,
    this.icon,
    this.faIcon,
    required this.isPrimary,
    required this.onTap,
  });

  @override
  State<_ActionLinkButton> createState() => _ActionLinkButtonState();
}

class _ActionLinkButtonState extends State<_ActionLinkButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isHighlight = _isHovered;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: widget.isPrimary
                ? (isHighlight ? AppColors.primary : AppColors.primary.withAlpha(30))
                : (isHighlight ? AppColors.surfaceElevated : Colors.transparent),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: widget.isPrimary
                  ? AppColors.primary
                  : (isHighlight ? AppColors.primary : AppColors.cardBorder),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon != null)
                Icon(
                  widget.icon,
                  size: 14,
                  color: widget.isPrimary
                      ? (isHighlight ? const Color(0xFF0B0F17) : AppColors.primary)
                      : (isHighlight ? AppColors.primary : AppColors.textSecondary),
                )
              else if (widget.faIcon != null)
                FaIcon(
                  widget.faIcon,
                  size: 13,
                  color: widget.isPrimary
                      ? (isHighlight ? const Color(0xFF0B0F17) : AppColors.primary)
                      : (isHighlight ? AppColors.primary : AppColors.textSecondary),
                ),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: widget.isPrimary
                      ? (isHighlight ? const Color(0xFF0B0F17) : AppColors.primary)
                      : (isHighlight ? AppColors.primary : AppColors.textPrimary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Subtle grid pattern for 16:9 preview container
class _GridPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0x08FFFFFF)
      ..strokeWidth = 1.0;

    const step = 28.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
