import 'package:flutter/material.dart';
import 'package:portfolio/data/portfolio_data.dart';
import 'package:portfolio/models/portfolio_models.dart';
import 'package:portfolio/widgets/animated_section.dart';
import 'package:portfolio/widgets/profile_hero.dart';
import 'package:portfolio/widgets/section_header.dart';
import 'package:portfolio/widgets/skills_section.dart';
import 'package:portfolio/widgets/timeline_card.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final personalInfo = PortfolioData.personalInfo;
    final skills = PortfolioData.skills;
    final careerItems = PortfolioData.careerItems;
    final screenSize = MediaQuery.of(context).size;
    final isDesktop = screenSize.width >= 1024;
    final isTablet = screenSize.width >= 768 && screenSize.width < 1024;
    final isMobile = screenSize.width < 768;

    final socialLinks = [
      const SocialLink(
        name: 'LinkedIn',
        icon: 'assets/icons/linkedin_icon.svg',
        url: 'https://www.linkedin.com/in/amarjit-mallick/',
      ),
      const SocialLink(
        name: 'GitHub',
        icon: 'assets/icons/github_icon.svg',
        url: 'https://github.com/amarjitmallick',
      ),
      const SocialLink(
        name: 'Twitter',
        icon: 'assets/icons/x_icon.svg',
        url: 'https://x.com/amarjitmallick_',
      ),
    ];

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
                      primary: true,
                      padding: EdgeInsets.all(
                        isDesktop
                            ? 40
                            : isTablet
                            ? 24
                            : 16,
                      ),
                      child: Center(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: isDesktop ? double.infinity : 900,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AnimatedSection(
                                delay: const Duration(milliseconds: 200),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SectionHeader(
                                      title: "ABOUT ME",
                                      subtitle: "& SKILLS",
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      isMobile
                                          ? 'Get to know me, my skills, and professional journey'
                                          : 'Get to know me better and explore my technical expertise',
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: isDesktop
                                    ? 50
                                    : isTablet
                                    ? 32
                                    : 24,
                              ),
                              AnimatedSection(
                                delay: const Duration(milliseconds: 400),
                                child: _buildAboutContent(
                                  context,
                                  personalInfo,
                                  isDesktop,
                                  isTablet,
                                ),
                              ),
                              SizedBox(
                                height: isDesktop
                                    ? 50
                                    : isTablet
                                    ? 60
                                    : 40,
                              ),
                              AnimatedSection(
                                delay: const Duration(milliseconds: 600),
                                child: SkillsSection(skills: skills),
                              ),
                              SizedBox(
                                height: isDesktop
                                    ? 80
                                    : isTablet
                                    ? 60
                                    : 40,
                              ),
                              if (isMobile) ...[
                                SizedBox(
                                  height: isDesktop
                                      ? 80
                                      : isTablet
                                      ? 60
                                      : 40,
                                ),
                                AnimatedSection(
                                  delay: const Duration(milliseconds: 800),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.timeline,
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.primary,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            'Career Journey',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineMedium
                                                ?.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 24),
                                      ...careerItems.asMap().entries.map((
                                        entry,
                                      ) {
                                        final index = entry.key;
                                        final item = entry.value;
                                        return AnimatedSection(
                                          delay: Duration(
                                            milliseconds: 200 * index,
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                              bottom: isTablet ? 24 : 20,
                                            ),
                                            child: TimelineCard(
                                              careerItem: item,
                                            ),
                                          ),
                                        );
                                      }),
                                    ],
                                  ),
                                ),
                              ],
                            ],
                          ),
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

  Widget _buildAboutContent(
    BuildContext context,
    PersonalInfo personalInfo,
    bool isDesktop,
    bool isTablet,
  ) {
    return Container(
      child: isDesktop
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _buildAboutText(context, personalInfo),
                ),
              ],
            )
          : Column(
              children: [
                _buildAboutText(context, personalInfo),
                SizedBox(height: isTablet ? 40 : 32),
                _buildPersonalInfo(context, personalInfo),
              ],
            ),
    );
  }

  Widget _buildAboutText(BuildContext context, PersonalInfo personalInfo) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About Me',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 32,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            personalInfo.bio,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              height: 1.6,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'My journey began with a Bachelors degree in Mathematics followed by a Masters degree in Computer Applications, and since then I\'ve worked with startups and established companies, helping them bring their ideas to life through technology. I believe in writing clean, maintainable code and staying up-to-date with the latest industry trends.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              height: 1.6,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'When I\'m not coding, you can find me contributing to open-source projects, writing technical articles, or exploring new technologies that can solve real-world problems.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalInfo(BuildContext context, PersonalInfo personalInfo) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Text(
                'Personal Info',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildInfoItem(
            context,
            Icons.person_rounded,
            'Name',
            personalInfo.name,
          ),
          _buildInfoItem(
            context,
            Icons.work_rounded,
            'Title',
            personalInfo.title,
          ),
          _buildInfoItem(
            context,
            Icons.email_rounded,
            'Email',
            personalInfo.email,
          ),
          _buildInfoItem(
            context,
            Icons.location_on_rounded,
            'Location',
            personalInfo.location,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
