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

  /// Structured skills dataset meeting the portfolio specifications.
  static const List<SkillCategoryGroup> groups = [
    SkillCategoryGroup(
      category: SkillCategory.frontend,
      description: 'Cross-platform UI engineering and design system implementation.',
      skills: [
        SkillItem(name: 'Flutter', badge: 'Core'),
        SkillItem(name: 'Dart', badge: 'Core'),
        SkillItem(name: 'Responsive Web'),
        SkillItem(name: 'Material & Cupertino'),
      ],
    ),
    SkillCategoryGroup(
      category: SkillCategory.architecture,
      description: 'Predictable unidirectional data flows and domain decoupling.',
      skills: [
        SkillItem(name: 'Clean Architecture', badge: 'Pattern'),
        SkillItem(name: 'Riverpod'),
        SkillItem(name: 'BLoC'),
        SkillItem(name: 'Provider'),
      ],
    ),
    SkillCategoryGroup(
      category: SkillCategory.backend,
      description: 'Asynchronous network communication and local persistent storage.',
      skills: [
        SkillItem(name: 'Firebase'),
        SkillItem(name: 'REST APIs'),
        SkillItem(name: 'Hive', badge: 'NoSQL'),
        SkillItem(name: 'SQLite', badge: 'SQL'),
      ],
    ),
    SkillCategoryGroup(
      category: SkillCategory.tools,
      description: 'Developer-first workflows, version control, and automation.',
      skills: [
        SkillItem(name: 'Git/GitHub'),
        SkillItem(name: 'Linux OS', badge: 'Daily Driver'),
        SkillItem(name: 'CI/CD basics'),
      ],
    ),
  ];
}
