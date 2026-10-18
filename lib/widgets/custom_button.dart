import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

enum ButtonVariant { primary, secondary, outline }

/// A modern interactive button with hover animations, gradient fills, and icon support.
class CustomButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final ButtonVariant variant;
  final double? width;
  final double height;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.variant = ButtonVariant.primary,
    this.width,
    this.height = 48.0,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Styling according to variant
    BoxDecoration decoration;
    TextStyle textStyle;
    Color iconColor;

    switch (widget.variant) {
      case ButtonVariant.primary:
        decoration = BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(12),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: AppColors.primary.withAlpha(90),
                    blurRadius: 20,
                    offset: const Offset(0, 6),
                  ),
                ]
              : [
                  BoxShadow(
                    color: AppColors.primary.withAlpha(45),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
        );
        textStyle = theme.textTheme.labelLarge!.copyWith(
          color: const Color(0xFF0B0F17),
          fontWeight: FontWeight.w700,
        );
        iconColor = const Color(0xFF0B0F17);
        break;

      case ButtonVariant.secondary:
        decoration = BoxDecoration(
          color: _isHovered
              ? AppColors.surfaceElevated
              : AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _isHovered
                ? AppColors.primary.withAlpha(128)
                : AppColors.cardBorder,
            width: 1,
          ),
        );
        textStyle = theme.textTheme.labelLarge!.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
        );
        iconColor = AppColors.primary;
        break;

      case ButtonVariant.outline:
        decoration = BoxDecoration(
          color: _isHovered
              ? AppColors.primary.withAlpha(25)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _isHovered ? AppColors.primary : AppColors.cardBorder,
            width: 1.5,
          ),
        );
        textStyle = theme.textTheme.labelLarge!.copyWith(
          color: _isHovered ? AppColors.primary : AppColors.textPrimary,
          fontWeight: FontWeight.w600,
        );
        iconColor = _isHovered ? AppColors.primary : AppColors.textPrimary;
        break;
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          transform: _isHovered
              ? Matrix4.translationValues(0.0, -2.0, 0.0)
              : Matrix4.identity(),
          width: widget.width,
          height: widget.height,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          decoration: decoration,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.icon != null) ...[
                Icon(widget.icon, size: 18, color: iconColor),
                const SizedBox(width: 8),
              ],
              Text(widget.text, style: textStyle),
            ],
          ),
        ),
      ),
    );
  }
}
