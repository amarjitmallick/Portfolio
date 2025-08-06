import 'package:flutter/material.dart';

class CareerScreen extends StatelessWidget {
  const CareerScreen({super.key});

  final List<Map<String, String>> careers = const [
    {
      "role": "Associate Software Developer",
      "company": "Cloudcraftz",
      "duration": "Apr 2024 – Mar 2025",
      "description":
          "Developed modular Flutter web apps with PDF generation and real-time sync, streamlining workflows for 100+ users.",
    },
    {
      "role": "Flutter Developer",
      "company": "Fineant Consultant Services",
      "duration": "Aug 2023 – Feb 2024",
      "description":
          "Built cross-platform mobile apps from scratch using Flutter and REST APIs, focusing on robust architecture and maintainable code.",
    },
    {
      "role": "Flutter Developer (Consultant)",
      "company": "Hosachiguru",
      "duration": "Oct 2022 – Jul 2023",
      "description":
          "Led development of FarmOps and MyFarm apps, implementing offline-first functionality and improving app stability by 40%.",
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
              "Career",
              style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.w500),
            ),
          ),

          // Timeline
          Column(
            spacing: 40,
            children: careers.asMap().entries.map((entry) {
              final index = entry.key;
              final career = entry.value;

              return Row(
                spacing: 16,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      const Icon(Icons.work_outline, size: 28, color: Colors.blueAccent),
                      if (index != careers.length - 1) Container(width: 2, height: 200, color: Colors.grey[300]),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        spacing: 10,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            career["role"]!,
                            style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "${career["company"]} • ${career["duration"]}",
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          Text(
                            career["description"]!,
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w500),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
