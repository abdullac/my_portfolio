/// Data model representing a portfolio project showcase item.
class ProjectModel {
  final String id;
  final String title;
  final String description;
  final List<String> technologies;
  final String? liveUrl;
  final String? githubUrl;
  final String? imagePath;
  final bool isFeatured;
  final String? badge;

  const ProjectModel({
    required this.id,
    required this.title,
    required this.description,
    required this.technologies,
    this.liveUrl,
    this.githubUrl,
    this.imagePath,
    this.isFeatured = false,
    this.badge,
  });

  /// Real featured projects created and deployed by Abdulla.
  static const List<ProjectModel> featuredProjects = [
    ProjectModel(
      id: 'netflipz-netflix-clone',
      title: 'Netflipz (Netflix Clone)',
      description:
          'A responsive Netflix clone engineered with Flutter Web & Mobile, featuring an animated transparent app bar, dynamic bottom navigation, search filters, Fast Laughs reels, and coming-soon previews.',
      technologies: ['Flutter Web', 'Flutter Mobile', 'BLoC', 'Freezed', 'Dio', 'REST API'],
      liveUrl: 'https://abdullac.github.io/-NetClpix-NetFlix-Clone-Web-Flutter/',
      githubUrl: 'https://github.com/abdullac/-NetClpix-NetFlix-Clone-Web-Flutter',
      imagePath: 'assets/projects/netflipzhome.webp',
      isFeatured: true,
      badge: 'Featured Project',
    ),
    ProjectModel(
      id: 'cafe-menu-web-app',
      title: 'Cafe Menu & Ordering App',
      description:
          'An interactive digital menu application developed with Flutter Web & Mobile, enabling seamless food category browsing, rich item previews, and an intuitive ordering interface.',
      technologies: ['Flutter Web', 'Dart', 'Responsive UI', 'State Management'],
      liveUrl: 'https://abdullac.github.io/cafe-menu-flutter-web-app/',
      githubUrl: 'https://github.com/abdullac/cafe-menu-flutter-web-app',
      isFeatured: true,
      badge: 'Live Web App',
    ),
    ProjectModel(
      id: 'devtube-youtube-app',
      title: 'DevTube (YouTube Web App)',
      description:
          'A video streaming web application inspired by YouTube, engineered with Flutter Web featuring responsive video feeds, custom media cards, and channel navigation.',
      technologies: ['Flutter Web', 'Dart', 'Video Integration', 'Responsive UI'],
      liveUrl: 'https://abdullac.github.io/devtube-flutter-web-app/',
      githubUrl: 'https://github.com/abdullac/devtube-flutter-web-app',
      isFeatured: true,
      badge: 'Live Web App',
    ),
    ProjectModel(
      id: 'customer-feedback-system',
      title: 'Customer Feedback System',
      description:
          'A cross-platform feedback management application built with Flutter to capture customer ratings, reviews, and satisfaction analytics in real time.',
      technologies: ['Flutter Web', 'Dart', 'Google Sheets API', 'Form Validation'],
      liveUrl: 'https://abdullac.github.io/costomer-feedback-system/',
      githubUrl: 'https://github.com/abdullac/costomer-feedback-system',
      isFeatured: true,
      badge: 'Live Web App',
    ),
  ];
}
