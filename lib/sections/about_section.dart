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
      title: 'About Me & Work Ethics',
      subtitle:
          'Passionate Flutter developer building responsive, multi-platform applications with dedication.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Introduction Card with Real Photo & Authentic Story
          _buildIntroductionCard(context, isMobile: isMobile, isDesktop: isDesktop),
          const SizedBox(height: 36),

          // 2. Section Sub-heading for Work Ethics
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
                  'My Work Ethics',
                  style: AppTypography.h4.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: isMobile ? 18 : 20,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // 3. Responsive Work Ethics Cards Grid
          _buildWorkEthicsGrid(context, isDesktop: isDesktop, isMobile: isMobile),
        ],
      ),
    );
  }

  /// Introduction card with Abdulla's real photo and authentic bio
  Widget _buildIntroductionCard(
    BuildContext context, {
    required bool isMobile,
    required bool isDesktop,
  }) {
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
      child: isDesktop
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProfilePhoto(),
                const SizedBox(width: 32),
                Expanded(child: _buildIntroDetails(isMobile: false)),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: _buildProfilePhoto(isMobile: true)),
                const SizedBox(height: 24),
                _buildIntroDetails(isMobile: isMobile),
              ],
            ),
    );
  }

  Widget _buildProfilePhoto({bool isMobile = false}) {
    return Container(
      width: isMobile ? 140 : 180,
      height: isMobile ? 180 : 230,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.cardBorder, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withAlpha(30),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          'assets/images/MyphotoBig.webp',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(
            color: AppColors.surfaceElevated,
            child: const Center(
              child: Icon(Icons.person_rounded, size: 48, color: AppColors.primary),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIntroDetails({required bool isMobile}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.surfaceElevated,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.cardBorder),
              ),
              child: const Icon(
                Icons.flutter_dash,
                color: AppColors.primary,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Abdulla — Flutter Developer',
                    style: AppTypography.subtitle.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Malappuram, Kerala',
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        Text(
          'My journey into software engineering began with a genuine curiosity about how digital tools empower people to solve everyday challenges. Inspired by the impact of well-crafted technology, I set out to build software that performs seamlessly across devices.',
          style: AppTypography.bodyLarge.copyWith(
            height: 1.65,
            fontSize: isMobile ? 14 : 16,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Today, I develop responsive cross-platform applications for Web, Android, iOS, Windows, Linux, and macOS using Flutter & Dart. I focus on clean code, intuitive user experiences, and robust state management, constantly expanding my skills to build practical, impactful software.',
          style: AppTypography.bodyLarge.copyWith(
            height: 1.65,
            fontSize: isMobile ? 14 : 16,
          ),
        ),
        const SizedBox(height: 22),

        // Technical Workflow Chips
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: const [
            _WorkflowChip(label: 'Web & Mobile', icon: Icons.devices_rounded),
            _WorkflowChip(label: 'Android, Linux, Windows, iOS, Mac', icon: Icons.laptop_chromebook_rounded),
            _WorkflowChip(label: 'Flutter & Dart Ecosystem', icon: Icons.flutter_dash),
            _WorkflowChip(label: 'BLoC & Freezed', icon: Icons.layers_outlined),
          ],
        ),
      ],
    );
  }

  /// Responsive Work Ethics Grid: 3 columns on desktop, 2 on tablet, 1 on mobile
  Widget _buildWorkEthicsGrid(
    BuildContext context, {
    required bool isDesktop,
    required bool isMobile,
  }) {
    final ethics = const [
      (
        icon: Icons.verified_rounded,
        title: 'Aim for Excellence',
        tag: 'Quality',
        description: 'Striving to deliver every project with precision, clean code, and exceptional quality.',
      ),
      (
        icon: Icons.timelapse_rounded,
        title: 'Ownership & Dedication',
        tag: 'Commitment',
        description: 'Taking full ownership of project deliverables with deep commitment and meticulous attention to detail.',
      ),
      (
        icon: Icons.sentiment_satisfied_alt_rounded,
        title: 'Collaborative Spirit',
        tag: 'Teamwork',
        description: 'Maintaining a humble, friendly, and respectful approach in teamwork and communication.',
      ),
      (
        icon: Icons.lightbulb_rounded,
        title: 'Solution-Oriented Mindset',
        tag: 'Mindset',
        description: 'Approaching challenging technical problems with curiosity, optimism, and persistent problem-solving.',
      ),
      (
        icon: Icons.shield_rounded,
        title: 'Resilience Under Pressure',
        tag: 'Resilience',
        description: 'Staying calm, composed, and productive under pressure to consistently achieve project milestones.',
      ),
      (
        icon: Icons.auto_stories_rounded,
        title: 'Continuous Growth',
        tag: 'Growth',
        description: 'Continuously mastering modern technologies and best practices to build better digital experiences.',
      ),
    ];

    if (isMobile) {
      return Column(
        children: [
          for (final item in ethics) ...[
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

    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = isDesktop ? 3 : 2;
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            mainAxisExtent: 230,
          ),
          itemCount: ethics.length,
          itemBuilder: (context, index) {
            final item = ethics[index];
            return _ValueCard(
              icon: item.icon,
              title: item.title,
              tag: item.tag,
              description: item.description,
            );
          },
        );
      },
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
        padding: const EdgeInsets.all(22),
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
            const SizedBox(height: 16),
            Text(
              widget.title,
              style: AppTypography.subtitleSmall.copyWith(
                fontWeight: FontWeight.w700,
                color: _isHovered ? AppColors.primary : AppColors.textPrimary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Text(
              widget.description,
              style: AppTypography.bodyMedium.copyWith(
                height: 1.5,
                color: AppColors.textSecondary,
              ),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
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
