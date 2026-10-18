import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';
import '../core/utils/responsive.dart';
import '../widgets/section_container.dart';

/// 'About Me' & Engineering Philosophy section showcasing developer background,
/// Linux workflows, and core architectural value cards.
class AboutSection extends StatelessWidget {
  final Key? sectionKey;

  const AboutSection({super.key, this.sectionKey});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isMobile = Responsive.isMobile(context);

    return SectionContainer(
      sectionKey: sectionKey,
      sectionNumber: '01. //',
      title: 'About Me & Engineering Philosophy',
      subtitle:
          'Transforming complex requirements into fluid, resilient, and accessible cross-platform software.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Introduction Card (Background, Linux workflows & UI engineering)
          _buildIntroductionCard(context, isMobile: isMobile),
          const SizedBox(height: 36),

          // 2. Section Sub-heading for Core Principles
          Row(
            children: [
              Container(
                width: 4,
                height: 18,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 10),
              Flexible(
                child: Text(
                  'Core Engineering Principles',
                  style: AppTypography.h4.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: isMobile ? 18 : 20,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // 3. Responsive Value Cards Grid
          _buildPrinciplesGrid(context, isDesktop: isDesktop, isMobile: isMobile),
        ],
      ),
    );
  }

  /// Introduction card detailing cross-platform development, Linux, and UI engineering
  Widget _buildIntroductionCard(BuildContext context, {required bool isMobile}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? 22 : 32),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.cardBorder, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(40),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.surfaceElevated,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.cardBorder),
                ),
                child: const Icon(
                  Icons.terminal_rounded,
                  color: AppColors.primary,
                  size: 22,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cross-Platform & UI Engineer',
                      style: AppTypography.subtitle.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Focused on architecture, performance, and developer experience',
                      style: AppTypography.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'With a strong background in cross-platform development, I architect and build enterprise-ready applications using Flutter across Web, Mobile, and Desktop platforms from a unified codebase.',
            style: AppTypography.bodyLarge.copyWith(
              height: 1.65,
              fontSize: isMobile ? 14 : 16,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            'A passionate advocate of Linux workflows and terminal-driven developer environments, I emphasize deterministic tooling, modular monorepos, automated CI/CD pipelines, and pixel-perfect design system execution.',
            style: AppTypography.bodyLarge.copyWith(
              height: 1.65,
              fontSize: isMobile ? 14 : 16,
            ),
          ),
          const SizedBox(height: 24),

          // Technical Workflow Chips
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: const [
              _WorkflowChip(label: 'Linux & Bash Workflows', icon: Icons.laptop_chromebook_rounded),
              _WorkflowChip(label: 'Dart & Flutter Ecosystem', icon: Icons.flutter_dash),
              _WorkflowChip(label: 'Design Systems & UX', icon: Icons.palette_outlined),
              _WorkflowChip(label: 'Automated CI/CD', icon: Icons.alt_route_rounded),
            ],
          ),
        ],
      ),
    );
  }

  /// Responsive Value Cards Grid: Multi-column on desktop, single column on mobile
  Widget _buildPrinciplesGrid(
    BuildContext context, {
    required bool isDesktop,
    required bool isMobile,
  }) {
    final principles = const [
      (
        icon: Icons.layers_rounded,
        title: 'Clean Architecture',
        tag: 'Maintainability',
        description:
            'Strict separation across presentation, domain, and data layers to ensure codebases remain thoroughly testable, modular, and resilient to third-party framework churn.',
      ),
      (
        icon: Icons.account_tree_rounded,
        title: 'State Management & Scalability',
        tag: 'Scalability',
        description:
            'Predictable, reactive unidirectional data flows utilizing BLoC and Riverpod. Engineered to handle high-frequency streams, deep caching, and multi-tier user sessions.',
      ),
      (
        icon: Icons.speed_rounded,
        title: 'Performance & Responsive UI',
        tag: 'Performance',
        description:
            'Zero-jank 60fps rendering, tight frame budgets, WebAssembly compilation on the web, and responsive layouts that gracefully scale from compact mobile screens to ultra-wide displays.',
      ),
    ];

    if (!isDesktop) {
      return Column(
        children: [
          for (final item in principles) ...[
            _ValueCard(
              icon: item.icon,
              title: item.title,
              tag: item.tag,
              description: item.description,
            ),
            const SizedBox(height: 16),
          ],
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < principles.length; i++) ...[
          Expanded(
            child: _ValueCard(
              icon: principles[i].icon,
              title: principles[i].title,
              tag: principles[i].tag,
              description: principles[i].description,
            ),
          ),
          if (i < principles.length - 1) const SizedBox(width: 16),
        ],
      ],
    );
  }
}

class _ValueCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String tag;
  final String description;

  const _ValueCard({
    required this.icon,
    required this.title,
    required this.tag,
    required this.description,
  });

  @override
  State<_ValueCard> createState() => _ValueCardState();
}

class _ValueCardState extends State<_ValueCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        transform: _isHovered
            ? Matrix4.translationValues(0.0, -4.0, 0.0)
            : Matrix4.identity(),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isHovered
                ? AppColors.primary.withAlpha(140)
                : AppColors.cardBorder,
            width: 1,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: AppColors.primary.withAlpha(25),
                    blurRadius: 18,
                    offset: const Offset(0, 6),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withAlpha(30),
                    blurRadius: 12,
                    offset: const Offset(0, 3),
                  ),
                ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: _isHovered
                        ? AppColors.primary.withAlpha(30)
                        : AppColors.surfaceElevated,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _isHovered
                          ? AppColors.primary.withAlpha(100)
                          : AppColors.cardBorder,
                    ),
                  ),
                  child: Icon(
                    widget.icon,
                    color: AppColors.primary,
                    size: 22,
                  ),
                ),
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceElevated,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: AppColors.cardBorder),
                    ),
                    child: Text(
                      widget.tag,
                      style: AppTypography.badge.copyWith(
                        fontSize: 10,
                        color: AppColors.textMuted,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Text(
              widget.title,
              style: AppTypography.subtitleSmall.copyWith(
                fontWeight: FontWeight.w700,
                color: _isHovered ? AppColors.primary : AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.description,
              style: AppTypography.bodyMedium.copyWith(
                height: 1.55,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WorkflowChip extends StatelessWidget {
  final String label;
  final IconData icon;

  const _WorkflowChip({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: AppColors.surfaceElevated,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.primary),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              label,
              style: AppTypography.bodySmall.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
