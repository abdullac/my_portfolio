import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_constants.dart';
import '../core/utils/responsive.dart';

/// Reusable section wrapper offering consistent max width, padding, and section headers.
class SectionContainer extends StatelessWidget {
  final String? sectionNumber;
  final String? title;
  final String? subtitle;
  final Widget child;
  final Key? sectionKey;
  final EdgeInsetsGeometry? padding;

  const SectionContainer({
    super.key,
    this.sectionNumber,
    this.title,
    this.subtitle,
    required this.child,
    this.sectionKey,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = Responsive.isMobile(context);

    final defaultPadding = EdgeInsets.symmetric(
      horizontal: isMobile ? 20.0 : 40.0,
      vertical: isMobile ? 48.0 : 80.0,
    );

    return Container(
      key: sectionKey,
      width: double.infinity,
      alignment: Alignment.center,
      padding: padding ?? defaultPadding,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: AppConstants.maxContentWidth,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null) ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (sectionNumber != null) ...[
                    Text(
                      sectionNumber!,
                      style: theme.textTheme.labelLarge!.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(width: 12),
                  ],
                  Flexible(
                    child: Text(
                      title!,
                      style: isMobile
                          ? theme.textTheme.headlineMedium
                          : theme.textTheme.displaySmall,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      height: 1,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [AppColors.cardBorder, Colors.transparent],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 12),
                Text(
                  subtitle!,
                  style: theme.textTheme.bodyLarge,
                ),
              ],
              const SizedBox(height: 40),
            ],
            child,
          ],
        ),
      ),
    );
  }
}
