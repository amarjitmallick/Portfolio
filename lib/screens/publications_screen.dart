import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:portfolio/data/portfolio_data.dart';
import 'package:portfolio/data/repository/blog_repository.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/portfolio_models.dart';
import '../widgets/animated_section.dart';

class PublicationsScreen extends StatelessWidget {
  const PublicationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final personalInfo = PortfolioData.personalInfo;
    List<Publication> publications;
    final screenSize = MediaQuery.of(context).size;
    final isDesktop = screenSize.width >= 1024;
    final isTablet = screenSize.width >= 768 && screenSize.width < 1024;

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
                    child: FutureBuilder<List<dynamic>>(
                      future: BlogRepository().fetchBlogs(),
                      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
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
                            return SingleChildScrollView(
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
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemCount: publications.length,
                                        itemBuilder: (context, index) {
                                          return AnimatedSection(
                                            delay: Duration(milliseconds: 400 + (index * 200)),
                                            child: Padding(
                                              padding: const EdgeInsets.only(bottom: 24),
                                              child: _buildPublicationCard(context, publications[index]),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: "BLOGS &\n",
            style: GoogleFonts.urbanist().copyWith(
              fontSize: 120,
              fontWeight: FontWeight.w600,
              letterSpacing: 2,
              color: Colors.white,
            ),
            children: [
              TextSpan(
                text: "ARTICLES",
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
      ],
    );
  }

  Widget _buildPublicationCard(BuildContext context, Publication publication) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        spacing: 16,
        children: [
          Expanded(
            flex: 2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(publication.imageUrl),
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  spacing: 4,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      publication.title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                        height: 1.3,
                      ),
                    ),
                    Text(
                      DateFormat("MMM dd, yyyy").format(DateTime.parse(publication.year)),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  publication.description,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.8),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 20),
                if (publication.blogUrl != null) ...[
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.read_more_rounded),
                    label: const Text('Read More'),
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      backgroundColor: Colors.white,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
