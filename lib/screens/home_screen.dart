import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/core/constants.dart';
import 'package:portfolio/data/portfolio_data.dart';
import 'package:portfolio/models/portfolio_models.dart';
import 'package:portfolio/widgets/animated_section.dart';
import 'package:portfolio/widgets/contact_form.dart';
import 'package:portfolio/widgets/profile_hero.dart';
import 'package:portfolio/widgets/project_card.dart';
import 'package:portfolio/widgets/section_header.dart';
import 'package:portfolio/widgets/stat_card.dart';
import 'package:portfolio/widgets/timeline_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final personalInfo = PortfolioData.personalInfo;
    final projects = PortfolioData.projects;
    final careerItems = PortfolioData.careerItems;
    final screenSize = MediaQuery.of(context).size;
    final isDesktop = screenSize.width >= 1024;
    final isTablet = screenSize.width >= 768 && screenSize.width < 1024;

    final stats = [
      const StatItem(number: '3+', label: 'Years Experience'),
      const StatItem(number: '10+', label: 'Projects Completed'),
      const StatItem(number: '5+', label: 'Happy Clients'),
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
                      padding: EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 30,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AnimatedSection(
                            delay: const Duration(milliseconds: 300),
                            child: const SectionHeader(
                              title: "SOFTWARE",
                              subtitle: "ENGINEER",
                            ),
                          ),

                          AnimatedSection(
                            delay: const Duration(milliseconds: 400),
                            child: const Text(
                              "Passionate about creating intuitive and engaging user experiences. Specialize in transforming ideas into beautifully crafted products.",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                          AnimatedSection(
                            delay: const Duration(milliseconds: 500),
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 40),
                              child: Row(
                                spacing: 20,
                                children: stats
                                    .map(
                                      (stat) => StatCard(
                                        stat: stat,
                                        isDesktop: isDesktop,
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ),

                          AnimatedSection(
                            delay: const Duration(milliseconds: 600),
                            child: SizedBox(
                              height: 250,
                              child: Row(
                                spacing: 32,
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        //TODO: Navigate to Projects Section
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          color: Colors.yellow,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            FaIcon(
                                              FontAwesomeIcons.noteSticky,
                                              size: 32,
                                              color: Colors.black,
                                            ),
                                            const Text(
                                              "FLUTTER, DART, FIREBASE, SUPABASE",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 28,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Align(
                                              alignment:
                                                  AlignmentGeometry.bottomRight,
                                              child: Container(
                                                padding: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.5,
                                                  ),
                                                ),
                                                child: Icon(
                                                  Icons.arrow_forward_rounded,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        //TODO: Navigate to Career Section
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          color: Colors.red,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            FaIcon(
                                              FontAwesomeIcons.layerGroup,
                                              size: 32,
                                              color: Colors.white,
                                            ),
                                            const Text(
                                              "MOBILE APPLICATION DEVELOPMENT",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 28,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Align(
                                              alignment:
                                                  AlignmentGeometry.bottomRight,
                                              child: Container(
                                                padding: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                    color: Colors.white,
                                                    width: 1.5,
                                                  ),
                                                ),
                                                child: Icon(
                                                  Icons.arrow_forward_rounded,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(height: 100),

                          AnimatedSection(
                            delay: const Duration(milliseconds: 700),
                            child: const SectionHeader(
                              title: "RECENT",
                              subtitle: "PROJECTS",
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
                                child: ProjectCard(
                                  project: project,
                                  isDesktop: isDesktop,
                                  isTablet: isTablet,
                                ),
                              ),
                            );
                          }),

                          SizedBox(height: 100),

                          const SectionHeader(
                            title: "3+ YEARS OF",
                            subtitle: "EXPERIENCE",
                          ),

                          SizedBox(
                            height: 24,
                          ),

                          ...careerItems.asMap().entries.map((entry) {
                            final index = entry.key;
                            final item = entry.value;
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
                                child: TimelineCard(
                                  careerItem: item,
                                ),
                              ),
                            );
                          }),

                          SizedBox(height: 100),

                          const SectionHeader(
                            title: "LET'S WORK",
                            subtitle: "TOGETHER",
                          ),

                          SizedBox(
                            height: 24,
                          ),
                          ContactForm(
                            isDesktop: isDesktop,
                            isTablet: isTablet,
                          ),
                          SizedBox(
                            height: 80,
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
}
