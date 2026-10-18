/// Application constants, branding, links, and layout breakpoints.
class AppConstants {
  AppConstants._();

  static const String appTitle = 'Portfolio | Senior Flutter Web Architect';
  static const String developerName = 'Abdulla';
  static const String developerRole = 'Senior Flutter & Full-Stack Web Architect';
  static const String developerTagline =
      'Engineering mission-critical web & mobile architectures with clean code, 60fps WebAssembly performance, and fluid responsive design.';

  // External Profiles
  static const String githubUrl = 'https://github.com';
  static const String linkedinUrl = 'https://linkedin.com';
  static const String twitterUrl = 'https://x.com';
  static const String contactEmail = 'contact@portfolio.dev';

  // Navigation Links
  static const String navAbout = 'About';
  static const String navSkills = 'Skills';
  static const String navProjects = 'Projects';
  static const String navContact = 'Contact';

  static const List<String> navItems = [
    navAbout,
    navSkills,
    navProjects,
    navContact,
  ];

  // Layout Constraints
  static const double maxContentWidth = 1200.0;
  static const double desktopBreakpoint = 1024.0;
  static const double tabletBreakpoint = 768.0;
}
