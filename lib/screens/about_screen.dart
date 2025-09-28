import 'package:flutter/material.dart';
import 'package:portfolio/data/portfolio_data.dart';
import 'package:portfolio/widgets/animated_section.dart';

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
                AnimatedSection(
                  delay: const Duration(milliseconds: 400),
                  child: _buildAboutContent(context, personalInfo, isDesktop, isTablet),
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
                  child: _buildSkillsSection(context, skills, isDesktop, isTablet),
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
                    child: _buildCareerSection(context, careerItems, isDesktop, isTablet),
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
          isMobile ? 'About & Career' : 'About Me & Skills',
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          isMobile
              ? 'Get to know me, my skills, and professional journey'
              : 'Get to know me better and explore my technical expertise',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildAboutContent(BuildContext context, personalInfo, bool isDesktop, bool isTablet) {
    return Container(
      child: isDesktop
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: _buildAboutText(context, personalInfo),
                ),
                const SizedBox(width: 40),
                Expanded(
                  child: _buildPersonalInfo(context, personalInfo),
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

  Widget _buildAboutText(BuildContext context, personalInfo) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.person_outline_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Text(
                'About Me',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
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

  Widget _buildPersonalInfo(BuildContext context, personalInfo) {
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
          _buildInfoItem(context, Icons.person_rounded, 'Name', personalInfo.name),
          _buildInfoItem(context, Icons.work_rounded, 'Title', personalInfo.title),
          _buildInfoItem(context, Icons.email_rounded, 'Email', personalInfo.email),
          _buildInfoItem(context, Icons.location_on_rounded, 'Location', personalInfo.location),
        ],
      ),
    );
  }

  Widget _buildInfoItem(BuildContext context, IconData icon, String label, String value) {
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
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
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

  Widget _buildSkillsSection(BuildContext context, List skills, bool isDesktop, bool isTablet) {
    final groupedSkills = <String, List>{};
    for (final skill in skills) {
      groupedSkills.putIfAbsent(skill.category, () => []).add(skill);
    }

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.code_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Text(
                'Technical Skills',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          ...groupedSkills.entries.map((entry) {
            return AnimatedSection(
              delay: Duration(milliseconds: 200 * groupedSkills.keys.toList().indexOf(entry.key)),
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: isDesktop
                      ? 40
                      : isTablet
                      ? 32
                      : 24,
                ),
                child: _buildSkillCategory(context, entry.key, entry.value, isDesktop, isTablet),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildSkillCategory(
    BuildContext context,
    String category,
    List categorySkills,
    bool isDesktop,
    bool isTablet,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          category,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        SizedBox(height: isDesktop ? 20 : 16),
        SizedBox(
          height: 50,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: categorySkills.length,
            itemBuilder: (context, index) {
              final skill = categorySkills[index];
              return _buildSkillItem(context, skill);
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                width: 10,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSkillItem(BuildContext context, skill) {
    return Chip(
      label: Text(
        skill.name,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildCareerSection(BuildContext context, List careerItems, bool isDesktop, bool isTablet) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.timeline,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 8),
            Text(
              'Career Journey',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        ...careerItems.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          return AnimatedSection(
            delay: Duration(milliseconds: 200 * index),
            child: Padding(
              padding: EdgeInsets.only(bottom: isTablet ? 24 : 20),
              child: _buildCareerItem(context, item),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildCareerItem(BuildContext context, item) {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  item.position,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.company,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.duration,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  item.description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 16,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Key Achievements',
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ...item.achievements.map<Widget>((achievement) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 6),
                              width: 4,
                              height: 4,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                achievement,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  height: 1.5,
                                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.8),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
