import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  final List<Map<String, String>> projects = const [
    {
      "title": "GDG Siliguri App",
      "description":
          "Flutter app for DevFest schedules and real-time updates, supporting 100+ installs and seamless dynamic event content.",
      "image": "assets/images/gdg_siliguri.webp",
      "link": "https://play.google.com/store/apps/details?id=com.amarjitmallick.gdg_siliguri",
    },
    {
      "title": "Xpense",
      "description":
          "An offline-first expense tracker designed with a lightweight UI optimized for low battery and memory usage.",
      "image": "assets/images/xpense.webp",
      "link": "https://play.google.com/store/apps/details?id=me.amarjitmallick.xpense",
    },
    {
      "title": "FarmOps",
      "description":
          "A Flutter-based farm management app for agronomists, improving field operations and productivity.",
      "image": "assets/images/farmops.webp",
      "link": "https://play.google.com/store/apps/details?id=com.hosachiguru.farmops",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 70),
      child: Column(
        spacing: 30,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              "Projects",
              style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.w500),
            ),
          ),

          // Project List
          Column(
            spacing: 20,
            children: projects.map((project) {
              return Container(
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Flex(
                  mainAxisSize: MainAxisSize.min,
                  direction: isMobile ? Axis.vertical : Axis.horizontal,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: isMobile
                      ? [
                          Flexible(
                            child: Column(
                              spacing: 16,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  project["title"]!,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                                ),

                                Text(
                                  project["description"]!,
                                  style: Theme.of(context).textTheme.headlineSmall,
                                ),

                                TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: Color(0xFFDBE8F2),
                                  ),
                                  onPressed: () {
                                    launchUrl(Uri.parse(project["link"]!));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                                    child: const Text(
                                      "View Project",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 200, height: 20),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              project["image"]!,
                              width: isMobile ? double.infinity : 200,
                              height: isMobile ? 200 : 200,
                              fit: isMobile ? BoxFit.fitHeight : BoxFit.cover,
                              errorBuilder: (_, obj, stc) {
                                return Placeholder();
                              },
                            ),
                          ),
                        ].reversed.toList()
                      : [
                          Flexible(
                            child: Column(
                              spacing: 16,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  project["title"]!,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                                ),

                                Text(
                                  project["description"]!,
                                  style: Theme.of(context).textTheme.headlineSmall,
                                ),

                                TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: Color(0xFFDBE8F2),
                                  ),
                                  onPressed: () {
                                    launchUrl(Uri.parse(project["link"]!));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                                    child: const Text(
                                      "View Project",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 200, height: 20),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              project["image"]!,
                              width: isMobile ? double.infinity : 200,
                              height: isMobile ? 200 : 200,
                              fit: isMobile ? BoxFit.fitHeight : BoxFit.cover,
                              errorBuilder: (_, obj, stc) {
                                return Placeholder();
                              },
                            ),
                          ),
                        ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
