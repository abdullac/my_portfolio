import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';
import '../core/utils/responsive.dart';
import '../models/skill_model.dart';
import '../widgets/section_container.dart';

/// Categorized skills matrix displaying distinct category card containers
/// with elevated, interactive pill/chip badges.
class SkillsSection extends StatelessWidget {
  final Key? sectionKey;

  const SkillsSection({super.key, this.sectionKey});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return SectionContainer(
      sectionKey: sectionKey,
      sectionNumber: '02. //',
      title: 'Skills & Technical Capabilities',
      subtitle:
          'Structured competencies across frontend frameworks, architecture patterns, backend services, and tooling.',
      child: isDesktop
          ? GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                mainAxisExtent: 275,
              ),
              itemCount: SkillCategoryGroup.groups.length,
              itemBuilder: (context, index) {
                return _CategoryCard(group: SkillCategoryGroup.groups[index]);
              },
            )
          : Column(
              children: [
                for (final group in SkillCategoryGroup.groups) ...[
                  _CategoryCard(group: group),
                  const SizedBox(height: 20),
                ],
              ],
            ),
    );
  }
}

/// Distinct card container for a single skill category
class _CategoryCard extends StatefulWidget {
  final SkillCategoryGroup group;

  const _CategoryCard({required this.group});

  @override
  State<_CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<_CategoryCard> {
  bool _isCardHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isCardHovered = true),
      onExit: (_) => setState(() => _isCardHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: _isCardHovered
                ? AppColors.primary.withAlpha(120)
                : AppColors.cardBorder,
            width: 1,
          ),
          boxShadow: _isCardHovered
              ? [
                  BoxShadow(
                    color: AppColors.primary.withAlpha(25),
                    blurRadius: 20,
                    offset: const Offset(0, 6),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withAlpha(30),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category Header (Icon, Title, Description)
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: _isCardHovered
                        ? AppColors.primary.withAlpha(25)
                        : AppColors.surfaceElevated,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _isCardHovered
                          ? AppColors.primary.withAlpha(80)
                          : AppColors.cardBorder,
                    ),
                  ),
                  child: Icon(
                    widget.group.category.icon,
                    size: 20,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.group.category.label,
                        style: AppTypography.subtitleSmall.copyWith(
                          fontWeight: FontWeight.w700,
                          color: _isCardHovered
                              ? AppColors.primary
                              : AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        widget.group.description,
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textMuted,
                          fontSize: 11,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),

            // Subtle Divider
            Container(
              height: 1,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.cardBorder, Colors.transparent],
                ),
              ),
            ),
            const SizedBox(height: 18),

            // Skill Badges Pill Wrap
            Align(
              alignment: Alignment.topLeft,
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: widget.group.skills.map((skill) {
                  return _SkillPillBadge(skill: skill);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Elevated pill/chip badge with subtle border glow and hover lift
class _SkillPillBadge extends StatefulWidget {
  final SkillItem skill;

  const _SkillPillBadge({required this.skill});

  @override
  State<_SkillPillBadge> createState() => _SkillPillBadgeState();
}

class _SkillPillBadgeState extends State<_SkillPillBadge> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isHighlighted = _isHovered;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOutCubic,
        transform: isHighlighted
            ? Matrix4.translationValues(0.0, -2.5, 0.0)
            : Matrix4.identity(),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isHighlighted
              ? AppColors.surfaceElevated
              : AppColors.background.withAlpha(200),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isHighlighted
                ? AppColors.primary
                : AppColors.cardBorder,
            width: 1,
          ),
          boxShadow: isHighlighted
              ? [
                  BoxShadow(
                    color: AppColors.primary.withAlpha(55),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Glowing Indicator Dot
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: isHighlighted
                    ? AppColors.primary
                    : AppColors.primary.withAlpha(160),
                shape: BoxShape.circle,
                boxShadow: isHighlighted
                    ? [
                        BoxShadow(
                          color: AppColors.primary.withAlpha(200),
                          blurRadius: 6,
                        ),
                      ]
                    : null,
              ),
            ),
            const SizedBox(width: 8),

            // Skill Name
            Flexible(
              child: Text(
                widget.skill.name,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isHighlighted
                      ? AppColors.textPrimary
                      : AppColors.textSecondary,
                  letterSpacing: 0.2,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),

            // Optional Small Tag Badge (e.g. Core, Pattern, Daily Driver)
            if (widget.skill.badge != null) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: isHighlighted
                      ? AppColors.primary.withAlpha(35)
                      : AppColors.surfaceElevated,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  widget.skill.badge!,
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    color: isHighlighted
                        ? AppColors.primary
                        : AppColors.textMuted,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
