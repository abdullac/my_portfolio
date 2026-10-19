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
          'Responsive Netflix Clone built with Flutter Web and Mobile featuring animated transparent App Bar, 3-tier visibility Bottom Navigation Bar, custom image cards, search views, fast laughs, and coming soon items.',
      technologies: ['Flutter Web', 'Flutter Mobile', 'BLoC', 'Freezed', 'Dio', 'REST API'],
      liveUrl: 'https://abdullac.github.io/-NetClpix-NetFlix-Clone-Web-Flutter/',
      githubUrl: 'https://github.com/abdullac/-NetClpix-NetFlix-Clone-Web-Flutter',
      imagePath: 'assets/projects/netflipzhome.webp',
      isFeatured: true,
      badge: 'Featured in /#/',
    ),
    ProjectModel(
      id: 'cafe-menu-web-app',
      title: 'Cafe Menu & Ordering App',
      description:
          'Interactive restaurant and cafe menu application built with Flutter Web and Mobile, allowing customers to browse digital menus, categories, and item details with responsive UI.',
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
          'Video streaming web application inspired by YouTube built with Flutter Web, featuring responsive layout, video card grids, and channel navigation.',
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
          'Cross-platform feedback collection application developed with Flutter for capturing customer ratings, reviews, and satisfaction metrics seamlessly.',
      technologies: ['Flutter Web', 'Dart', 'Google Sheets API', 'Form Validation'],
      liveUrl: 'https://abdullac.github.io/costomer-feedback-system/',
      githubUrl: 'https://github.com/abdullac/costomer-feedback-system',
      isFeatured: true,
      badge: 'Live Web App',
    ),
  ];
}
