import 'package:flutter/material.dart';

import '../about/about_screen.dart';
import '../career/career_screen.dart';
import '../contact/contact_screen.dart';
import '../projects/projects_screen.dart';
import '../publications/publications_screen.dart';
import 'hero_widget.dart';

class MobileHome extends StatefulWidget {
  const MobileHome({super.key});

  @override
  State<MobileHome> createState() => _MobileHomeState();
}

class _MobileHomeState extends State<MobileHome> {
  int _index = 0;

  late final List<Widget> _pages = [
    _MobileHomeAboutPage(
      onTap: () {
        setState(() => _index = 1);
      },
    ),
    _MobileProjectsPublicationsPage(),
    SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: CareerScreen(),
    ),
    SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: ContactScreen(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _index,
          children: _pages
              .map(
                (p) => p,
              )
              .toList(),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.apps_outlined),
            selectedIcon: Icon(Icons.apps),
            label: 'Work',
          ),
          NavigationDestination(
            icon: Icon(Icons.timeline_outlined),
            selectedIcon: Icon(Icons.timeline),
            label: 'Career',
          ),
          NavigationDestination(
            icon: Icon(Icons.mail_outline),
            selectedIcon: Icon(Icons.mail),
            label: 'Contact',
          ),
        ],
      ),
    );
  }
}

class _MobileHomeAboutPage extends StatelessWidget {
  final Function()? onTap;
  const _MobileHomeAboutPage({this.onTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          spacing: 16,
          children: [
            MobileHeroSection(
              onTap: onTap,
            ),
            AboutScreen(),
          ],
        ),
      ),
    );
  }
}

class _MobileProjectsPublicationsPage extends StatelessWidget {
  const _MobileProjectsPublicationsPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Projects & Publications"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          spacing: 16,
          children: [
            ProjectsScreen(),
            PublicationsScreen(),
          ],
        ),
      ),
    );
  }
}
