import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> skills = const [
      {"name": "Flutter", "icon": "🚀"},
      {"name": "Dart", "icon": "🎯"},
      {"name": "Firebase", "icon": "🔥"},
      {"name": "REST APIs", "icon": "🌐"},
      {"name": "BLoC", "icon": "📦"},
      {"name": "GetX", "icon": "📦"},
      {"name": "MobX", "icon": "📦"},
      {"name": "State Management", "icon": "📦"},
      {"name": "UX/UI Design", "icon": "🎨"},
      {"name": "Git", "icon": "🔧"},
      {"name": "Supabase", "icon": "🗄️"},
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = constraints.maxWidth < 600;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 70),
          child: Column(
            spacing: 30,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "About Me",
                style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.w500),
              ),
              Container(
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Flex(
                  direction: isMobile ? Axis.vertical : Axis.horizontal,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(radius: isMobile ? 60 : 80, backgroundImage: AssetImage('assets/images/profile.jpeg')),
                    SizedBox(width: isMobile ? 0 : 40, height: isMobile ? 20 : 0),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "I am a Flutter Developer with over 3 years of experience building mobile and web apps. I specialize in creating scalable, maintainable, and beautifully designed apps using Flutter, Dart, and modern state management tools.",
                            style: Theme.of(context).textTheme.headlineMedium,
                            textAlign: isMobile ? TextAlign.center : TextAlign.left,
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
                            children: [
                              TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: Color(0xFFDBE8F2),
                                ),
                                onPressed: () {
                                  launchUrl(
                                    Uri.parse("https://drive.google.com/file/d/161FOXZArLz2TfrqD2zBIA2mMRTCsgwlq/view"),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                                  child: const Text(
                                    "Download Resume",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              TextButton(
                                style: TextButton.styleFrom(
                                  side: const BorderSide(color: Color(0xFFDBE8F2)),
                                ),
                                onPressed: () {
                                  launchUrl(
                                    Uri.parse("https://github.com/amarjitmallick"),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                                  child: const Text(
                                    "Visit GitHub",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFDBE8F2).withValues(alpha: 0.3),
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(24),
                        alignment: Alignment.center,
                        child: Text(
                          "Skills",
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                      ),
                    ),

                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(32),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(24),
                            bottomRight: Radius.circular(24),
                          ),
                        ),
                        child: Wrap(
                          spacing: 24,
                          runSpacing: 24,
                          alignment: WrapAlignment.start,
                          children: skills.map((skill) {
                            return Chip(
                              label: Text(
                                skill["name"]!,
                                style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w500),
                              ),
                              avatar: Text(skill["icon"]!, style: const TextStyle(fontSize: 18)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: const BorderSide(color: Color(0xFFDBE8F2)),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
