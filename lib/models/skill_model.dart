import 'package:flutter/material.dart';

/// Categories for organizing engineering skills.
enum SkillCategory {
  frontend('Frontend & Framework', Icons.devices_rounded),
  architecture('State Management & Architecture', Icons.architecture_rounded),
  backend('Backend & Database', Icons.dns_rounded),
  tools('Tools & Environment', Icons.terminal_rounded);

  final String label;
  final IconData icon;
  const SkillCategory(this.label, this.icon);
}

/// Individual skill item representation.
class SkillItem {
  final String name;
  final String? badge;

  const SkillItem({
    required this.name,
    this.badge,
  });
}

/// Grouped category containing its skills and descriptions.
class SkillCategoryGroup {
  final SkillCategory category;
  final String description;
  final List<SkillItem> skills;

  const SkillCategoryGroup({
    required this.category,
    required this.description,
    required this.skills,
  });

  /// Structured skills dataset matching Abdulla's actual technical capabilities.
  static const List<SkillCategoryGroup> groups = [
    SkillCategoryGroup(
      category: SkillCategory.frontend,
      description: 'Cross-platform UI development for Web, Android, iOS, and Desktop.',
      skills: [
        SkillItem(name: 'Flutter', badge: 'Core'),
        SkillItem(name: 'Dart', badge: 'Core'),
        SkillItem(name: 'Responsive UI'),
        SkillItem(name: 'HTML5'),
        SkillItem(name: 'CSS3'),
        SkillItem(name: 'JavaScript'),
        SkillItem(name: 'Bootstrap'),
        SkillItem(name: 'jQuery'),
      ],
    ),
    SkillCategoryGroup(
      category: SkillCategory.architecture,
      description: 'State management, code generation, and reactive architecture.',
      skills: [
        SkillItem(name: 'BLoC', badge: 'State'),
        SkillItem(name: 'Freezed', badge: 'Immutable'),
        SkillItem(name: 'Injectable', badge: 'DI'),
        SkillItem(name: 'Clean Code'),
      ],
    ),
    SkillCategoryGroup(
      category: SkillCategory.backend,
      description: 'API communication, network requests, and data serialization.',
      skills: [
        SkillItem(name: 'Dio', badge: 'Networking'),
        SkillItem(name: 'JSON Serialization'),
        SkillItem(name: 'REST APIs'),
        SkillItem(name: 'HTTP Client'),
      ],
    ),
    SkillCategoryGroup(
      category: SkillCategory.tools,
      description: 'Version control, programming environments, and operating systems.',
      skills: [
        SkillItem(name: 'Git & GitHub'),
        SkillItem(name: 'Java'),
        SkillItem(name: 'Linux OS'),
        SkillItem(name: 'Cross-Platform Build'),
      ],
    ),
  ];
}
