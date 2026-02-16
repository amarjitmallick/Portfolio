import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:portfolio/core/constants.dart';
import 'package:portfolio/data/portfolio_data.dart';
import 'package:portfolio/data/repository/blog_repository.dart';
import 'package:portfolio/widgets/animated_section.dart';
import 'package:portfolio/widgets/profile_hero.dart';
import 'package:portfolio/widgets/project_card.dart';

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
                      child: ProfileHero(
                        personalInfo: personalInfo,
                        socialLinks: socialLinks,
                      ),
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
                                delay: Duration(
                                  milliseconds: 400 + (index * 200),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    bottom: isDesktop
                                        ? 40
                                        : isTablet
                                        ? 32
                                        : 24,
                                  ),
                                  child: ProjectCard(
                                    project: project,
                                    isDesktop: isDesktop,
                                    isTablet: isTablet,
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
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
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
