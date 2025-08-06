import 'package:flutter/material.dart';

class SkillsScreen extends StatelessWidget {
  const SkillsScreen({super.key});

  final List<Map<String, String>> skills = const [
    {"name": "Flutter", "icon": "🚀"},
    {"name": "Dart", "icon": "🎯"},
    {"name": "Firebase", "icon": "🔥"},
    {"name": "REST APIs", "icon": "🌐"},
    {"name": "State Management", "icon": "📦"},
    {"name": "UX/UI Design", "icon": "🎨"},
    {"name": "Git", "icon": "🔧"},
    {"name": "Supabase", "icon": "🗄️"},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Skills", style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: skills.map((skill) {
              return Chip(
                label: Text(skill["name"]!, style: const TextStyle(fontSize: 16)),
                avatar: Text(skill["icon"]!, style: const TextStyle(fontSize: 18)),
                backgroundColor: Colors.grey[100],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide(color: Colors.grey),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
