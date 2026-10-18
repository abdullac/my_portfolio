import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'core/constants/app_constants.dart';
import 'core/theme/app_theme.dart';
import 'sections/about_section.dart';
import 'sections/contact_section.dart';
import 'sections/hero_section.dart';
import 'sections/projects_section.dart';
import 'sections/skills_section.dart';
import 'widgets/footer.dart';
import 'widgets/navbar.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Remove hash (#) from URL strategy for clean path-based routing in Flutter Web
  usePathUrlStrategy();
  runApp(const PortfolioApp());
}

/// Root widget of the Portfolio application configured with modern dark theme.
class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appTitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const PortfolioHomePage(),
    );
  }
}

class PortfolioHomePage extends StatefulWidget {
  const PortfolioHomePage({super.key});

  @override
  State<PortfolioHomePage> createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage> {
  final ScrollController _scrollController = ScrollController();

  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  String _activeSection = AppConstants.navAbout;

  void _scrollToSection(GlobalKey key, String sectionName) {
    setState(() => _activeSection = sectionName);
    final context = key.currentContext;
    if (context != null) {
      final renderBox = context.findRenderObject() as RenderBox?;
      if (renderBox != null) {
        final position = renderBox.localToGlobal(Offset.zero);
        final targetOffset = _scrollController.offset + position.dy - 88;
        _scrollController.animateTo(
          targetOffset.clamp(0.0, _scrollController.position.maxScrollExtent),
          duration: const Duration(milliseconds: 650),
          curve: Curves.easeInOutCubic,
        );
        return;
      }

      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 650),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _scrollToTop() {
    setState(() => _activeSection = AppConstants.navAbout);
    _scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 650),
      curve: Curves.easeInOutCubic,
    );
  }

  void _onNavItemSelected(String section) {
    switch (section) {
      case AppConstants.navAbout:
        _scrollToSection(_aboutKey, AppConstants.navAbout);
        break;
      case AppConstants.navSkills:
        _scrollToSection(_skillsKey, AppConstants.navSkills);
        break;
      case AppConstants.navProjects:
        _scrollToSection(_projectsKey, AppConstants.navProjects);
        break;
      case AppConstants.navContact:
        _scrollToSection(_contactKey, AppConstants.navContact);
        break;
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Scrollable Sections Assembly with Seamless Scroll Physics
          ScrollConfiguration(
            behavior: const MaterialScrollBehavior().copyWith(
              scrollbars: false,
              dragDevices: {
                PointerDeviceKind.mouse,
                PointerDeviceKind.touch,
                PointerDeviceKind.trackpad,
                PointerDeviceKind.stylus,
              },
            ),
            child: SingleChildScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              child: Column(
                children: [
                  // Top Spacer for the Floating Navbar
                  const SizedBox(height: 88),

                  // 1. Hero Section
                  HeroSection(
                    onProjectsPressed: () => _scrollToSection(
                      _projectsKey,
                      AppConstants.navProjects,
                    ),
                    onContactPressed: () => _scrollToSection(
                      _contactKey,
                      AppConstants.navContact,
                    ),
                  ),

                  // 2. About & Philosophy Section
                  AboutSection(sectionKey: _aboutKey),

                  // 3. Categorized Skills Matrix Section
                  SkillsSection(sectionKey: _skillsKey),

                  // 4. Featured Projects Section
                  ProjectsSection(sectionKey: _projectsKey),

                  // 5. Contact Section
                  ContactSection(sectionKey: _contactKey),

                  // 6. Minimalist Footer
                  Footer(onBackToTop: _scrollToTop),
                ],
              ),
            ),
          ),

          // Floating Frosted-Glass Navbar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Navbar(
              activeSection: _activeSection,
              onNavItemSelected: _onNavItemSelected,
              onResumePressed: () => _scrollToSection(
                _contactKey,
                AppConstants.navContact,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
