import 'dart:ui';
import 'package:flutter/material.dart';
import '../core/constants/app_constants.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';
import '../core/utils/responsive.dart';
import 'custom_button.dart';

/// Floating frosted-glass navigation bar with smooth section scrolling triggers,
/// responsive desktop/mobile layouts, and animated mobile slide-down menu.
class Navbar extends StatefulWidget {
  final Function(String section) onNavItemSelected;
  final VoidCallback onResumePressed;
  final String? activeSection;

  const Navbar({
    super.key,
    required this.onNavItemSelected,
    required this.onResumePressed,
    this.activeSection,
  });

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> with SingleTickerProviderStateMixin {
  late final AnimationController _menuController;
  late final Animation<double> _menuAnimation;
  bool _isMobileMenuOpen = false;

  @override
  void initState() {
    super.initState();
    _menuController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _menuAnimation = CurvedAnimation(
      parent: _menuController,
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  void dispose() {
    _menuController.dispose();
    super.dispose();
  }

  void _toggleMobileMenu() {
    setState(() {
      _isMobileMenuOpen = !_isMobileMenuOpen;
      if (_isMobileMenuOpen) {
        _menuController.forward();
      } else {
        _menuController.reverse();
      }
    });
  }

  void _handleNavClick(String section) {
    if (_isMobileMenuOpen) {
      _toggleMobileMenu();
    }
    widget.onNavItemSelected(section);
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    // On desktop, render the 3-column floating pill (Logo left, Nav center, Action right)
    // On mobile/tablet, render floating header with animated hamburger and slide-down menu
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop ? 32.0 : 16.0,
          vertical: 12.0,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: AppConstants.maxContentWidth,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(isDesktop ? 22 : 18),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.surface.withAlpha(200),
                    borderRadius: BorderRadius.circular(isDesktop ? 22 : 18),
                    border: Border.all(
                      color: AppColors.cardBorder,
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(70),
                        blurRadius: 24,
                        offset: const Offset(0, 8),
                      ),
                      BoxShadow(
                        color: AppColors.primary.withAlpha(12),
                        blurRadius: 16,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Main Header Row
                      Container(
                        height: 64,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: isDesktop
                            ? _buildDesktopRow()
                            : _buildMobileRow(),
                      ),

                      // Animated Mobile Slide-down Menu
                      if (!isDesktop) _buildMobileSlideDown(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Desktop: Logo (left), Centered Nav items (center), Action button (right)
  Widget _buildDesktopRow() {
    return Row(
      children: [
        // Left: Brand Logo & Title
        Expanded(
          flex: 3,
          child: Align(
            alignment: Alignment.centerLeft,
            child: _buildBrandLogo(),
          ),
        ),

        // Center: Navigation Links
        Expanded(
          flex: 6,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (final item in AppConstants.navItems) ...[
                _NavLink(
                  title: item,
                  isActive: widget.activeSection == item,
                  onTap: () => _handleNavClick(item),
                ),
                if (item != AppConstants.navItems.last)
                  const SizedBox(width: 8),
              ],
            ],
          ),
        ),

        // Right: "Resume / Let's Connect" Action Button
        Expanded(
          flex: 3,
          child: Align(
            alignment: Alignment.centerRight,
            child: CustomButton(
              text: 'Let\'s Connect',
              icon: Icons.send_rounded,
              variant: ButtonVariant.primary,
              height: 40,
              onPressed: widget.onResumePressed,
            ),
          ),
        ),
      ],
    );
  }

  /// Mobile: Logo (left) and Animated Hamburger Toggle (right)
  Widget _buildMobileRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: _buildBrandLogo(),
        ),
        IconButton(
          icon: AnimatedIcon(
            icon: AnimatedIcons.menu_close,
            progress: _menuAnimation,
            color: AppColors.textPrimary,
            size: 24,
          ),
          splashRadius: 22,
          tooltip: _isMobileMenuOpen ? 'Close Menu' : 'Open Menu',
          onPressed: _toggleMobileMenu,
        ),
      ],
    );
  }

  /// Minimalist Mobile Slide-Down Menu
  Widget _buildMobileSlideDown() {
    return SizeTransition(
      sizeFactor: _menuAnimation,
      alignment: Alignment.topCenter,
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: AppColors.cardBorder, width: 1),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (final item in AppConstants.navItems) ...[
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () => _handleNavClick(item),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 8.0,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: widget.activeSection == item
                                ? AppColors.primary
                                : AppColors.cardBorder,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          item,
                          style: AppTypography.subtitleSmall.copyWith(
                            color: widget.activeSection == item
                                ? AppColors.primary
                                : AppColors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
            const SizedBox(height: 12),
            CustomButton(
              text: 'Let\'s Connect',
              icon: Icons.send_rounded,
              variant: ButtonVariant.primary,
              height: 44,
              onPressed: () {
                _toggleMobileMenu();
                widget.onResumePressed();
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Minimalist Monogram Brand Logo
  Widget _buildBrandLogo() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _handleNavClick(AppConstants.navAbout),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withAlpha(60),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: const Center(
                child: Text(
                  'A',
                  style: TextStyle(
                    color: Color(0xFF0B0F17),
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Flexible(
              child: Text.rich(
                TextSpan(
                  text: AppConstants.developerName,
                  style: AppTypography.subtitleSmall.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                  children: const [
                    TextSpan(
                      text: ' .dev',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  final String title;
  final bool isActive;
  final VoidCallback onTap;

  const _NavLink({
    required this.title,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isHighlight = widget.isActive || _isHovered;

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
            color: isHighlight
                ? AppColors.surfaceElevated
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            widget.title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isHighlight
                  ? AppColors.primary
                  : AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
