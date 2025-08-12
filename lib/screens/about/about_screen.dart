import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../responsive/responsive.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;

    final avatarSize = const ResponsiveValue<double>(
      desktop: 96,
      tablet: 80,
      mobile: 60,
    ).resolve(context);

    final verticalPad = const ResponsiveValue<double>(
      desktop: 70,
      tablet: 48,
      mobile: 24,
    ).resolve(context);

    final cardPad = const ResponsiveValue<double>(
      desktop: 24,
      tablet: 20,
      mobile: 16,
    ).resolve(context);

    final buttonGap = const ResponsiveValue<double>(
      desktop: 10,
      tablet: 10,
      mobile: 8,
    ).resolve(context);

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

    return Padding(
      padding: EdgeInsets.symmetric(vertical: verticalPad),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "About Me",
            style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 30),

          Container(
            padding: EdgeInsets.all(cardPad),
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Flex(
              mainAxisSize: MainAxisSize.min,
              direction: isMobile ? Axis.vertical : Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: avatarSize,
                  backgroundImage: const AssetImage('assets/images/profile.jpeg'),
                ),
                SizedBox(width: isMobile ? 0 : 40, height: isMobile ? 20 : 0),
                Flexible(
                  child: Column(
                    crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                    children: [
                      Text(
                        "I am a Flutter Developer with over 3 years of experience building mobile and web apps. I specialize in creating scalable, maintainable, and beautifully designed apps using Flutter, Dart, and modern state management tools.",
                        style: Theme.of(context).textTheme.headlineMedium,
                        textAlign: isMobile ? TextAlign.center : TextAlign.left,
                      ),
                      const SizedBox(height: 20),

                      Wrap(
                        alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
                        spacing: buttonGap,
                        runSpacing: buttonGap,
                        children: [
                          TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: const Color(0xFFDBE8F2),
                            ),
                            onPressed: () {
                              launchUrl(
                                Uri.parse("https://drive.google.com/file/d/161FOXZArLz2TfrqD2zBIA2mMRTCsgwlq/view"),
                                mode: LaunchMode.externalApplication,
                              );
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                              child: Text(
                                "Download Resume",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              side: const BorderSide(color: Color(0xFFDBE8F2)),
                            ),
                            onPressed: () {
                              launchUrl(
                                Uri.parse("https://github.com/amarjitmallick"),
                                mode: LaunchMode.externalApplication,
                              );
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                              child: Text(
                                "Visit GitHub",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
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

          const SizedBox(height: 30),

          Container(
            decoration: BoxDecoration(
              color: isMobile ? Colors.white : const Color(0xFFDBE8F2).withValues(alpha: 0.3),
              border: Border.all(),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Flex(
              mainAxisSize: MainAxisSize.min,
              direction: isMobile ? Axis.vertical : Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Container(
                    padding: EdgeInsets.all(cardPad),
                    alignment: Alignment.center,
                    child: Text(
                      "Skills",
                      style: Theme.of(context).textTheme.displayLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.all(isMobile ? 16 : 32),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: isMobile
                          ? BorderRadius.only(
                              bottomLeft: Radius.circular(22),
                              bottomRight: Radius.circular(22),
                            )
                          : const BorderRadius.only(
                              topRight: Radius.circular(24),
                              bottomRight: Radius.circular(24),
                            ),
                    ),
                    child: Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
                      children: skills.map((skill) {
                        return Chip(
                          label: Text(
                            skill["name"]!,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500),
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
  }
}
