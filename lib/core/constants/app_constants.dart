/// Application constants, branding, links, and layout breakpoints.
class AppConstants {
  AppConstants._();

  static const String appTitle = 'Abdulla | Flutter Developer';
  static const String developerName = 'Abdulla';
  static const String developerRole = 'Flutter Developer';
  static const String developerWelcome = 'Yes, Your Own';
  static const String developerTagline =
      'Passionate Flutter & Dart developer crafting seamless, responsive cross-platform experiences for Web, Mobile (Android & iOS), and Desktop.';

  // External Profiles & Contact (from abdullac.github.io/#/)
  static const String githubUrl = 'https://github.com/abdullac';
  static const String linkedinUrl = 'https://www.linkedin.com/in/abdulla-c-31a89b252';
  static const String twitterUrl = 'https://github.com/abdullac';
  static const String contactEmail = 'abdullacforu@gmail.com';
  static const String location = 'Malappuram, Kerala';

  // Assets
  static const String photoBig = 'assets/images/MyphotoBig.webp';
  static const String photoFace = 'assets/images/myPhotoBigFace.webp';

  // Navigation Links
  static const String navAbout = 'About';
  static const String navSkills = 'Skills';
  static const String navProjects = 'Projects';
  static const String navWorkEthics = 'Work Ethics';
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
