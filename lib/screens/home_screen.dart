import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/data/portfolio_data.dart';
import 'package:portfolio/widgets/animated_section.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/portfolio_models.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final personalInfo = PortfolioData.personalInfo;
    final projects = PortfolioData.projects;
    final careerItems = PortfolioData.careerItems;
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
                    child: _buildHeroImage(context, personalInfo),
                  ),
                  Expanded(
                    flex: 3,
                    child: SingleChildScrollView(
                      primary: true,
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: "SOFTWARE\n",
                              style: GoogleFonts.urbanist().copyWith(
                                fontSize: 120,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 2,
                                color: Colors.white,
                              ),
                              children: [
                                TextSpan(
                                  text: "ENGINEER",
                                  style: TextStyle(
                                    fontSize: 120,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2,
                                    color: Colors.white.withValues(
                                      alpha: 0.35,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Text(
                            "Passionate about creating intuitive and engaging user experiences. Specialize in transforming ideas into beautifully crafted products.",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          _buildQuickStats(context, isDesktop, isTablet),

                          SizedBox(
                            height: 250,
                            child: Row(
                              spacing: 32,
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.yellow,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 100),

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

                          SizedBox(height: 100),

                          RichText(
                            text: TextSpan(
                              text: "3+ YEARS OF\n",
                              style: GoogleFonts.urbanist().copyWith(
                                fontSize: 120,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 2,
                                color: Colors.white,
                              ),
                              children: [
                                TextSpan(
                                  text: "EXPERIENCE",
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

                          SizedBox(
                            height: 24,
                          ),

                          ...careerItems.asMap().entries.map((entry) {
                            final index = entry.key;
                            final project = entry.value;
                            final isLast = index == careerItems.length - 1;
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
                                child: _buildTimelineItem(
                                  context,
                                  project,
                                  isLast,
                                ),
                              ),
                            );
                          }),

                          SizedBox(height: 100),

                          RichText(
                            text: TextSpan(
                              text: "LET'S WORK\n",
                              style: GoogleFonts.urbanist().copyWith(
                                fontSize: 120,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 2,
                                color: Colors.white,
                              ),
                              children: [
                                TextSpan(
                                  text: "TOGETHER",
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

                          SizedBox(
                            height: 24,
                          ),
                          _buildContactForm(
                            context,
                            isDesktop,
                            isTablet,
                          ),
                          SizedBox(
                            height: 240,
                          ),
                        ],
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

  Widget _buildContactForm(
    BuildContext context,
    bool isDesktop,
    bool isTablet,
  ) {
    return Container(
      padding: EdgeInsets.all(
        isDesktop
            ? 0
            : isTablet
            ? 24
            : 20,
      ),
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
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.send_rounded,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Text(
                  'Send Message',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Your Name',
                prefixIcon: const Icon(Icons.person_rounded),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Theme.of(
                  context,
                ).colorScheme.surfaceContainerHighest,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email Address',
                prefixIcon: const Icon(Icons.email_rounded),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Theme.of(
                  context,
                ).colorScheme.surfaceContainerHighest,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (!RegExp(
                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                ).hasMatch(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _messageController,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Message',
                prefixIcon: const Padding(
                  padding: EdgeInsets.only(bottom: 80),
                  child: Icon(Icons.message_rounded),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Theme.of(
                  context,
                ).colorScheme.surfaceContainerHighest,
                alignLabelWithHint: true,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your message';
                }
                return null;
              },
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: _sendMessage,
                style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  padding: const EdgeInsets.symmetric(vertical: 24),
                ),
                child: Text(
                  'Send Message',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendMessage() {
    if (_formKey.currentState!.validate()) {
      _launchEmail();

      // Clear the form
      _nameController.clear();
      _emailController.clear();
      _messageController.clear();
    }
  }

  Future<void> _launchEmail() async {
    final String name = _nameController.text;
    final String message = _messageController.text;

    const String recipientEmail = 'mallickamarjit@gmail.com';
    const String subject = 'Inquiry from Portfolio Website';

    final String body =
        '$message\n\n'
        'Regards,\n$name\n';

    final String encodedSubject = Uri.encodeComponent(subject);
    final String encodedBody = Uri.encodeComponent(body);

    final Uri emailLaunchUri = Uri.parse(
      'mailto:$recipientEmail?subject=$encodedSubject&body=$encodedBody',
    );

    try {
      if (await canLaunchUrl(emailLaunchUri)) {
        await launchUrl(emailLaunchUri);
      } else {
        _showSnackBar(
          'Could not launch email client. Please ensure you have an email app configured.',
        );
      }
    } catch (e) {
      _showSnackBar('An error occurred: $e');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Widget _buildTimelineItem(BuildContext context, CareerItem careerItem, bool isLast) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(24),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      careerItem.position,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      careerItem.company,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  careerItem.duration,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          if (careerItem.description.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text(
              careerItem.description,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                height: 1.6,
                color: Colors.white.withValues(alpha: 0.8),
              ),
            ),
          ],

          if (careerItem.achievements.isNotEmpty) ...[
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
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ...careerItem.achievements.map<Widget>((achievement) {
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
                              color: Colors.white.withValues(alpha: 0.8),
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
        ],
      ),
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
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        image: DecorationImage(
          image: AssetImage(project.imageUrl),
          fit: BoxFit.cover,
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

  Widget _buildQuickStats(BuildContext context, bool isDesktop, bool isTablet) {
    final stats = [
      {
        'number': '+3',
        'label': 'YEARS OF EXPERIENCE',
        'icon': Icons.timeline_rounded,
      },
      {
        'number': '+20',
        'label': 'PROJECTS COMPLETED',
        'icon': Icons.work_rounded,
      },

      {
        'number': '+100',
        'label': 'APP DOWNLOADS',
        'icon': Icons.download_rounded,
      },
    ];

    return Container(
      constraints: BoxConstraints(maxWidth: isDesktop ? 1200 : 900),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: isDesktop
              ? 1.1
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
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: isDesktop ? MainAxisAlignment.center : MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stat['number'] as String,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontSize: 64,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  (stat['label'] as String),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.7),
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
      constraints: BoxConstraints(maxWidth: isDesktop ? double.infinity : 900),
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
                  color: Theme.of(
                    context,
                  ).colorScheme.outline.withValues(alpha: 0.2),
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
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurface.withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.4),
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
