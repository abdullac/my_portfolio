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

  /// Curated featured projects demonstrating modern cross-platform engineering.
  static const List<ProjectModel> featuredProjects = [
    ProjectModel(
      id: 'cloud-desk-ide',
      title: 'CloudDesk Web IDE',
      description:
          'High-throughput web workspace running on Flutter WebAssembly with collaborative multi-user editing, real-time state orchestration, and offline persistence.',
      technologies: ['Flutter Web', 'Wasm', 'Firebase', 'Clean Architecture'],
      liveUrl: 'https://flutter.dev',
      githubUrl: 'https://github.com',
      imagePath: 'assets/projects/cloud_desk.png',
      isFeatured: true,
      badge: 'WebAssembly / Wasm',
    ),
    ProjectModel(
      id: 'pulse-stream-fintech',
      title: 'PulseStream FinTech',
      description:
          'Real-time financial analytics dashboard displaying 60fps streaming tickers, interactive charting, and responsive glassmorphic interfaces.',
      technologies: ['Flutter', 'Riverpod', 'REST APIs', 'WebSockets'],
      liveUrl: 'https://flutter.dev',
      githubUrl: 'https://github.com',
      imagePath: 'assets/projects/pulse_stream.png',
      isFeatured: true,
      badge: 'Production Grade',
    ),
    ProjectModel(
      id: 'omni-store-ecommerce',
      title: 'OmniStore Retail App',
      description:
          'Enterprise retail experience with offline-first database synchronization, fluid page transitions, and cross-platform native iOS & Android parity.',
      technologies: ['Flutter', 'BLoC', 'Firebase', 'SQLite'],
      liveUrl: 'https://flutter.dev',
      githubUrl: 'https://github.com',
      imagePath: 'assets/projects/omni_store.png',
      isFeatured: true,
      badge: 'Mobile Parity',
    ),
    ProjectModel(
      id: 'dev-pulse-monitor',
      title: 'DevPulse CI/CD Monitor',
      description:
          'Minimalist desktop and web dashboard monitoring GitHub Actions, container health, and Linux server performance metrics in real time.',
      technologies: ['Flutter', 'Riverpod', 'Git/GitHub', 'Linux OS'],
      liveUrl: 'https://flutter.dev',
      githubUrl: 'https://github.com',
      imagePath: 'assets/projects/dev_pulse.png',
      isFeatured: true,
      badge: 'Linux Workflow',
    ),
  ];
}
