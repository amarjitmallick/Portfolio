import 'package:flutter/material.dart';
import 'package:portfolio/data/portfolio_data.dart';
import 'package:portfolio/widgets/animated_section.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/portfolio_models.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final personalInfo = PortfolioData.personalInfo;
    final screenSize = MediaQuery.of(context).size;
    final isDesktop = screenSize.width >= 1024;
    final isTablet = screenSize.width >= 768 && screenSize.width < 1024;

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
          child: Column(
            children: [
              AnimatedSection(
                delay: const Duration(milliseconds: 200),
                child: _buildHeroSection(context, personalInfo, isDesktop, isTablet),
              ),
              SizedBox(
                height: isDesktop
                    ? 80
                    : isTablet
                    ? 60
                    : 40,
              ),
              AnimatedSection(
                delay: const Duration(milliseconds: 400),
                child: _buildQuickStats(context, isDesktop, isTablet),
              ),
              SizedBox(
                height: isDesktop
                    ? 80
                    : isTablet
                    ? 60
                    : 40,
              ),
              AnimatedSection(
                delay: const Duration(milliseconds: 600),
                child: _buildQuickLinks(context, isDesktop, isTablet),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context, PersonalInfo personalInfo, bool isDesktop, bool isTablet) {
    return Container(
      constraints: BoxConstraints(maxWidth: isDesktop ? 1400 : 900),
      child: isDesktop
          ? Row(
              children: [
                Expanded(
                  flex: 2,
                  child: _buildHeroContent(context, personalInfo, isDesktop, isTablet),
                ),
                const SizedBox(width: 60),
                Expanded(
                  child: _buildHeroImage(context, personalInfo),
                ),
              ],
            )
          : Column(
              children: [
                _buildHeroImage(context, personalInfo),
                SizedBox(height: isTablet ? 40 : 32),
                _buildHeroContent(context, personalInfo, isDesktop, isTablet),
              ],
            ),
    );
  }

  Widget _buildHeroContent(BuildContext context, personalInfo, bool isDesktop, bool isTablet) {
    return Column(
      crossAxisAlignment: isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        Text(
          'Hi, I\'m ${personalInfo.name} 👋',
          style:
              (isDesktop
                      ? Theme.of(context).textTheme.displaySmall
                      : isTablet
                      ? Theme.of(context).textTheme.headlineLarge
                      : Theme.of(context).textTheme.headlineMedium)
                  ?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
          textAlign: isDesktop ? TextAlign.start : TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          personalInfo.title,
          style:
              (isDesktop
                      ? Theme.of(context).textTheme.headlineMedium
                      : isTablet
                      ? Theme.of(context).textTheme.headlineSmall
                      : Theme.of(context).textTheme.titleLarge)
                  ?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
          textAlign: isDesktop ? TextAlign.start : TextAlign.center,
        ),
        const SizedBox(height: 24),
        Text(
          personalInfo.bio,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            height: 1.6,
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.8),
          ),
          textAlign: isDesktop ? TextAlign.start : TextAlign.center,
          maxLines: isTablet ? 4 : null,
          overflow: isTablet ? TextOverflow.ellipsis : null,
        ),
        const SizedBox(height: 32),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: isDesktop ? WrapAlignment.start : WrapAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                launchUrl(
                  Uri.parse("https://drive.google.com/file/d/161FOXZArLz2TfrqD2zBIA2mMRTCsgwlq/view"),
                  mode: LaunchMode.externalApplication,
                );
              },
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              ),
              child: const Text('Download Resume'),
            ),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.primary,
                side: BorderSide(color: Theme.of(context).colorScheme.primary),
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              ),
              child: const Text('Contact Me'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHeroImage(BuildContext context, PersonalInfo personalInfo) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 400),
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.shadow.withValues(alpha: 0.1),
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
    );
  }

  Widget _buildQuickStats(BuildContext context, bool isDesktop, bool isTablet) {
    final stats = [
      {'number': '20+', 'label': 'Projects Completed', 'icon': Icons.work_rounded},
      {'number': '3+', 'label': 'Years Experience', 'icon': Icons.timeline_rounded},
      {'number': '100+', 'label': 'App Downloads', 'icon': Icons.download_rounded},
    ];

    return Container(
      constraints: BoxConstraints(maxWidth: isDesktop ? 1200 : 900),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: isDesktop
              ? 2
              : isTablet
              ? 1.2
              : 0.6,
          crossAxisSpacing: isDesktop ? 24 : 16,
          mainAxisSpacing: isDesktop ? 24 : 16,
        ),
        itemCount: stats.length,
        itemBuilder: (context, index) {
          final stat = stats[index];
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: isDesktop ? MainAxisAlignment.center : MainAxisAlignment.start,
              children: [
                Icon(
                  stat['icon'] as IconData,
                  size: isDesktop ? 32 : 24,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 12),
                Text(
                  stat['number'] as String,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  stat['label'] as String,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildQuickLinks(BuildContext context, bool isDesktop, bool isTablet) {
    final links = [
      {
        'title': 'View Projects',
        'subtitle': 'Explore my latest work',
        'icon': Icons.work_rounded,
        'color': Colors.blue,
      },
      {
        'title': 'Read Publications',
        'subtitle': 'Blogs and articles',
        'icon': Icons.article_rounded,
        'color': Colors.green,
      },
      {
        'title': 'Career Journey',
        'subtitle': 'My professional timeline',
        'icon': Icons.timeline_rounded,
        'color': Colors.orange,
      },
      {
        'title': 'Get in Touch',
        'subtitle': 'Let\'s work together',
        'icon': Icons.contact_mail_rounded,
        'color': Colors.purple,
      },
    ];

    return Container(
      constraints: BoxConstraints(maxWidth: isDesktop ? 1200 : 900),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: isDesktop ? 2 : 1,
          childAspectRatio: isDesktop
              ? 3.5
              : isTablet
              ? 4
              : 3.5,
          crossAxisSpacing: isDesktop ? 24 : 16,
          mainAxisSpacing: isDesktop ? 24 : 16,
        ),
        itemCount: links.length,
        itemBuilder: (context, index) {
          final link = links[index];
          return InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: (link['color'] as Color).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      link['icon'] as IconData,
                      size: 32,
                      color: link['color'] as Color,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          link['title'] as String,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          link['subtitle'] as String,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.4),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
