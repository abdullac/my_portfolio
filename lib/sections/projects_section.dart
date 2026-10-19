import 'package:flutter/material.dart';
import '../core/utils/responsive.dart';
import '../models/project_model.dart';
import '../widgets/project_card.dart';
import '../widgets/section_container.dart';

/// Featured Projects section with responsive 2-column desktop grid and 1-column mobile layout.
class ProjectsSection extends StatelessWidget {
  final Key? sectionKey;

  const ProjectsSection({super.key, this.sectionKey});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final projects = ProjectModel.featuredProjects;

    return SectionContainer(
      sectionKey: sectionKey,
      sectionNumber: '03. //',
      title: 'Featured Projects & My Works',
      subtitle:
          'Real-world applications built and deployed with Flutter across Web and Mobile platforms.',
      child: isDesktop
          ? GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 24,
                mainAxisSpacing: 24,
                childAspectRatio: 0.76,
              ),
              itemCount: projects.length,
              itemBuilder: (context, index) {
                return ProjectCard(project: projects[index]);
              },
            )
          : Column(
              children: [
                for (final project in projects) ...[
                  ProjectCard(project: project),
                  const SizedBox(height: 24),
                ],
              ],
            ),
    );
  }
}
