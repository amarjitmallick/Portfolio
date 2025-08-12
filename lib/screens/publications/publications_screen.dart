import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PublicationsScreen extends StatelessWidget {
  const PublicationsScreen({super.key});

  final List<Map<String, String>> articles = const [
    {
      "title": "Understanding Method Channels in Flutter",
      "date": "March 5, 2025",
      "source": "Hashnode",
      "link": "https://amarjitmallick.hashnode.dev/understanding-method-channels-in-flutter",
    },
    {
      "title": "The Flutter Widget Lifecycle Explained: From Birth to Goodbye!",
      "date": "February 3, 2025",
      "source": "Hashnode",
      "link": "https://amarjitmallick.hashnode.dev/the-flutter-widget-lifecycle-explained-from-birth-to-goodbye",
    },
    {
      "title": "Integration Testing with Firebase Test Lab on GitHub Actions",
      "date": "June 1, 2024",
      "source": "Hashnode",
      "link": "https://amarjitmallick.hashnode.dev/integration-testing-with-firebase-test-lab-on-github-actions-part-1",
    },
    {
      "title": "An Introduction to Object Oriented Programming in Dart",
      "date": "May 10, 2023",
      "source": "Hashnode",
      "link": "https://amarjitmallick.hashnode.dev/a-basic-introduction-to-object-oriented-programming-in-dart",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 70),
      child: Column(
        spacing: 30,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              "Publications",
              style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.w500),
            ),
          ),

          // Articles
          Text(
            "Articles",
            style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 12),
          ...articles.map((article) => _buildPublicationTile(context, article)),
        ],
      ),
    );
  }

  Widget _buildPublicationTile(BuildContext context, Map<String, String> publication) {
    return InkWell(
      onTap: () {
        launchUrl(Uri.parse(publication["link"]!));
      },
      hoverColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Column(
                spacing: 5,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    publication["title"]!,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "Published: ${publication["date"]}",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text(
                    publication["source"]!,
                    style: Theme.of(context).textTheme.titleMedium,
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
