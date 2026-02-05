import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:portfolio/data/portfolio_data.dart';
import 'package:portfolio/data/repository/blog_repository.dart';
import 'package:portfolio/widgets/animated_section.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/portfolio_models.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final projects = PortfolioData.projects;
    final screenSize = MediaQuery.of(context).size;
    final isDesktop = screenSize.width >= 1024;
    final isTablet = screenSize.width >= 768 && screenSize.width < 1024;
    final isMobile = screenSize.width < 768;

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(
          isDesktop
              ? 40
              : isTablet
              ? 24
              : 16,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: isDesktop ? 1400 : 900),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedSection(
                  delay: const Duration(milliseconds: 200),
                  child: _buildHeader(context),
                ),
                SizedBox(
                  height: isDesktop
                      ? 50
                      : isTablet
                      ? 32
                      : 24,
                ),
                ...projects.asMap().entries.map((entry) {
                  final index = entry.key;
                  final project = entry.value;
                  return AnimatedSection(
                    delay: Duration(milliseconds: 400 + (index * 200)),
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: isDesktop
                            ? 40
                            : isTablet
                            ? 32
                            : 24,
                      ),
                      child: _buildProjectCard(context, project, isDesktop, isTablet, index.isEven),
                    ),
                  );
                }),
                if (isMobile) ...[
                  SizedBox(
                    height: isDesktop
                        ? 80
                        : isTablet
                        ? 60
                        : 40,
                  ),
                  AnimatedSection(
                    delay: Duration(milliseconds: 600 + (projects.length * 200)),
                    child: _buildPublicationsSection(context, isDesktop, isTablet),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isMobile = screenSize.width < 768;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isMobile ? 'Projects & Publications' : 'My Projects',
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          isMobile
              ? 'A showcase of my work and research contributions'
              : 'A showcase of my latest work and personal projects',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildProjectCard(BuildContext context, project, bool isDesktop, bool isTablet, bool isEven) {
    final imageWidget = _buildProjectImage(context, project);
    final contentWidget = _buildProjectContent(context, project, isDesktop, isTablet);

    return Container(
      constraints: const BoxConstraints(maxWidth: 1200),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.shadow.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: isDesktop
              ? IntrinsicHeight(
                  child: Row(
                    children: isEven
                        ? [
                            Expanded(flex: 2, child: imageWidget),
                            Expanded(flex: 3, child: contentWidget),
                          ]
                        : [
                            Expanded(flex: 3, child: contentWidget),
                            Expanded(flex: 2, child: imageWidget),
                          ],
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    imageWidget,
                    contentWidget,
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildProjectImage(BuildContext context, project) {
    return Container(
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        image: DecorationImage(
          image: AssetImage(project.imageUrl),
          fit: BoxFit.fitHeight,
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.primary.withValues(alpha: 0.8),
            Theme.of(context).colorScheme.secondary.withValues(alpha: 0.6),
          ],
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withValues(alpha: 0.3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProjectContent(BuildContext context, project, bool isDesktop, bool isTablet) {
    return Container(
      padding: EdgeInsets.all(
        isDesktop
            ? 40
            : isTablet
            ? 32
            : 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            project.title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          SizedBox(height: isDesktop ? 16 : 12),
          Text(
            project.description,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              height: 1.6,
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.8),
            ),
          ),
          SizedBox(height: isDesktop ? 20 : 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: project.technologies.map<Widget>((tech) {
              return Chip(
                label: Text(
                  tech,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: isDesktop ? 24 : 20),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              if (project.demoUrl != null)
                TextButton.icon(
                  onPressed: () {
                    launchUrl(
                      Uri.parse(project.demoUrl),
                      mode: LaunchMode.externalApplication,
                    );
                  },
                  icon: const Icon(Icons.android_rounded),
                  label: const Text(
                    'Check Application',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  ),
                ),
              if (project.githubUrl != null)
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.code),
                  label: const Text('Source Code'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.primary,
                    side: BorderSide(color: Theme.of(context).colorScheme.primary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPublicationsSection(BuildContext context, bool isDesktop, bool isTablet) {
    List<Publication> publications;
    return FutureBuilder<List<dynamic>>(
      future: BlogRepository().fetchBlogs(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData) {
          if (snapshot.data != null && snapshot.data!.isNotEmpty) {
            publications = snapshot.data!.map((blog) {
              return Publication(
                title: blog["node"]["title"],
                description: blog["node"]["brief"],
                blogUrl: blog["node"]["url"],
                imageUrl: blog["node"]["coverImage"]["url"],
                year: blog["node"]["publishedAt"],
              );
            }).toList();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.article,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Publications',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                ...publications.asMap().entries.map((entry) {
                  final index = entry.key;
                  final publication = entry.value;
                  return AnimatedSection(
                    delay: Duration(milliseconds: 200 * index),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: isTablet ? 24 : 20),
                      child: _buildPublicationCard(context, publication),
                    ),
                  );
                }),
              ],
            );
          } else {
            return Center(
              child: Text("No Blogs to show"),
            );
          }
        } else {
          return Center(
            child: Text("Something went wrong"),
          );
        }
      },
    );
  }

  Widget _buildPublicationCard(BuildContext context, Publication publication) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        spacing: 8,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(publication.imageUrl),
          ),
          Text(
            publication.title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            DateFormat("MMM dd, yyyy").format(DateTime.parse(publication.year)),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
              fontStyle: FontStyle.italic,
            ),
          ),
          Text(
            publication.description,
            maxLines: 3,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
              fontStyle: FontStyle.italic,
            ),
          ),

          if (publication.blogUrl != null) ...[
            SizedBox(
              height: 10,
            ),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.read_more_rounded),
              label: const Text('Read More'),
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
