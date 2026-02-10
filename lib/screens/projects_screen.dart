import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    final personalInfo = PortfolioData.personalInfo;

    final projects = PortfolioData.projects;
    final screenSize = MediaQuery.of(context).size;
    final isDesktop = screenSize.width >= 1024;
    final isTablet = screenSize.width >= 768 && screenSize.width < 1024;
    final isMobile = screenSize.width < 768;

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: AnimatedSection(
                      delay: const Duration(milliseconds: 200),
                      child: _buildHeroImage(context, personalInfo),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(
                        isDesktop
                            ? 40
                            : isTablet
                            ? 24
                            : 16,
                      ),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: isDesktop ? double.infinity : 900,
                        ),
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
                                  child: _buildProjectCard(
                                    context,
                                    project,
                                    isDesktop,
                                    isTablet,
                                    index.isEven,
                                  ),
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
                                delay: Duration(
                                  milliseconds: 600 + (projects.length * 200),
                                ),
                                child: _buildPublicationsSection(
                                  context,
                                  isDesktop,
                                  isTablet,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroImage(BuildContext context, PersonalInfo personalInfo) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(32),
      ),
      margin: EdgeInsets.symmetric(vertical: 50, horizontal: 80),
      padding: EdgeInsets.all(40),
      constraints: const BoxConstraints(maxWidth: 300),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.asset(
                  personalInfo.profileImage,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        Icons.person,
                        size: 100,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Text(
              "Amarjit Mallick",
              style: TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.w800,
                letterSpacing: 2,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Text(
              "A Software Engineer who has developed countless innovative solutions",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
          _buildSocialLinks(context),
        ],
      ),
    );
  }

  Widget _buildSocialLinks(
    BuildContext context,
  ) {
    final socialLinks = [
      {
        'name': 'LinkedIn',
        'icon': 'assets/icons/linkedin.png',
        'url': 'https://www.linkedin.com/in/amarjit-mallick/',
      },
      {
        'name': 'GitHub',
        'icon': 'assets/icons/github.png',
        'url': 'https://github.com/amarjitmallick',
      },
      {
        'name': 'Twitter',
        'icon': 'assets/icons/twitter.png',
        'url': 'https://x.com/amarjitmallick_',
      },
    ];

    return Container(
      constraints: const BoxConstraints(maxWidth: 600),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 16,
            children: socialLinks.map((link) {
              return IconButton(
                onPressed: () {
                  launchUrl(
                    Uri.parse(link['url'] as String),
                    mode: LaunchMode.externalApplication,
                  );
                },
                icon: Image.asset(
                  link['icon'] as String,
                  width: 36,
                  height: 36,
                  fit: BoxFit.contain,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isMobile = screenSize.width < 768;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: "RECENT\n",
            style: GoogleFonts.urbanist().copyWith(
              fontSize: 120,
              fontWeight: FontWeight.w600,
              letterSpacing: 2,
              color: Colors.white,
            ),
            children: [
              TextSpan(
                text: "PROJECTS",
                style: TextStyle(
                  fontSize: 120,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  color: Colors.white.withValues(alpha: 0.35),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 8),
        Text(
          isMobile
              ? 'A showcase of my work and research contributions'
              : 'A showcase of my latest work and personal projects',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildProjectCard(
    BuildContext context,
    project,
    bool isDesktop,
    bool isTablet,
    bool isEven,
  ) {
    final imageWidget = _buildProjectImage(context, project);
    final contentWidget = _buildProjectContent(
      context,
      project,
      isDesktop,
      isTablet,
    );

    return Container(
      constraints: const BoxConstraints(maxWidth: double.infinity),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: isDesktop
              ? IntrinsicHeight(
                  child: Row(
                    children: [
                      imageWidget,
                      Expanded(child: contentWidget),
                    ],
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
      width: 250,
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

  Widget _buildProjectContent(
    BuildContext context,
    project,
    bool isDesktop,
    bool isTablet,
  ) {
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
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    backgroundColor: Colors.white,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 32,
                    ),
                  ),
                ),
              if (project.githubUrl != null)
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.code),
                  label: const Text('Source Code'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.primary,
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    ),
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

  Widget _buildPublicationsSection(
    BuildContext context,
    bool isDesktop,
    bool isTablet,
  ) {
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
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.6),
              fontStyle: FontStyle.italic,
            ),
          ),
          Text(
            publication.description,
            maxLines: 3,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.6),
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
