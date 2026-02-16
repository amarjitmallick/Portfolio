import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/models/portfolio_models.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectCard extends StatelessWidget {
  final ProjectModel project;
  final bool isDesktop;
  final bool isTablet;

  const ProjectCard({
    super.key,
    required this.project,
    this.isDesktop = true,
    this.isTablet = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: () {
        launchUrl(
          Uri.parse(project.demoUrl!),
          mode: LaunchMode.externalApplication,
        );
      },
      child: Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
          boxShadow: [
            BoxShadow(
              color: Theme.of(
                context,
              ).colorScheme.shadow.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: isDesktop
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProjectImage(context),
                  Expanded(child: _buildProjectContent(context)),
                  FaIcon(FontAwesomeIcons.arrowUpRightFromSquare),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildProjectImage(context),
                  _buildProjectContent(context),
                ],
              ),
      ),
    );
  }

  Widget _buildProjectImage(BuildContext context) {
    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage(project.imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildProjectContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            project.title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: isDesktop ? 16 : 12),
          Text(
            project.description,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              height: 1.6,
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.8),
            ),
          ),
          SizedBox(height: isDesktop ? 20 : 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: project.technologies.map<Widget>((tech) {
              return Text(
                tech,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.w500,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
