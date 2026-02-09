import 'package:flutter/material.dart';
import 'package:portfolio/screens/about_screen.dart';
import 'package:portfolio/screens/career_screen.dart';
import 'package:portfolio/screens/contact_screen.dart';
import 'package:portfolio/screens/home_screen.dart';
import 'package:portfolio/screens/projects_screen.dart';
import 'package:portfolio/screens/publications_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int _currentIndex = 0;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final List<Widget> _screens = [
    const HomeScreen(),
    const AboutScreen(),
    const ProjectsScreen(),
    const PublicationsScreen(),
    const CareerScreen(),
    const ContactScreen(),
  ];

  final List<NavigationItem> _navigationItems = [
    NavigationItem(icon: Icons.home_rounded, label: 'Home'),
    NavigationItem(icon: Icons.person_rounded, label: 'About'),
    NavigationItem(icon: Icons.work_rounded, label: 'Projects'),
    NavigationItem(icon: Icons.article_rounded, label: 'Publications'),
    NavigationItem(icon: Icons.timeline_rounded, label: 'Career'),
    NavigationItem(icon: Icons.contact_mail_rounded, label: 'Contact'),
  ];

  final List<NavigationItem> _mobileNavigationItems = [
    NavigationItem(icon: Icons.home_rounded, label: 'Home'),
    NavigationItem(icon: Icons.person_rounded, label: 'About'),
    NavigationItem(icon: Icons.work_rounded, label: 'Projects'),
    NavigationItem(icon: Icons.contact_mail_rounded, label: 'Contact'),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation =
        Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onNavigationTap(int index) {
    if (index != _currentIndex) {
      _animationController.reset();
      setState(() {
        _currentIndex = index;
      });
      _animationController.forward();
    }
  }

  void _onMobileNavigationTap(int index) {
    int actualIndex;
    switch (index) {
      case 0:
        actualIndex = 0;
        break;
      case 1:
        actualIndex = 1;
        break;
      case 2:
        actualIndex = 2;
        break;
      case 3:
        actualIndex = 5;
        break;
      default:
        actualIndex = 0;
    }

    if (actualIndex != _currentIndex) {
      _animationController.reset();
      setState(() {
        _currentIndex = actualIndex;
      });
      _animationController.forward();
    }
  }

  int _getMobileIndexFromCurrentIndex() {
    switch (_currentIndex) {
      case 0:
        return 0;
      case 1:
      case 4:
        return 1;
      case 2:
      case 3:
        return 2;
      case 5:
        return 3;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isDesktop = screenSize.width >= 1024;

    return SelectionArea(
      child: Scaffold(
        appBar: !isDesktop
            ? AppBar(
                title: Text(
                  'Portfolio',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                centerTitle: true,
                backgroundColor: Theme.of(context).colorScheme.surface,
                elevation: 0,
              )
            : null,
        body: Column(
          children: [
            if (isDesktop) _buildDesktopNavigation(),
            Expanded(
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: isDesktop ? 1400 : double.infinity,
                  ),
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: _screens[_currentIndex],
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: isDesktop ? null : _buildBottomNavigation(),
      ),
    );
  }

  Widget _buildDesktopNavigation() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      margin: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        //color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withValues(alpha: 0.1),
            offset: const Offset(0, 2),
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          ..._navigationItems.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            final isSelected = index == _currentIndex;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: IconButton(
                tooltip: item.label,
                onPressed: () => _onNavigationTap(index),
                style: TextButton.styleFrom(
                  backgroundColor: isSelected ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.15) : null,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                icon: Icon(
                  item.icon,
                  color: isSelected ? Colors.white : Theme.of(context).colorScheme.onSurface,
                  size: 20,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return NavigationBar(
      elevation: 5,
      backgroundColor: Theme.of(context).colorScheme.surface,
      animationDuration: const Duration(milliseconds: 400),
      onDestinationSelected: _onMobileNavigationTap,
      selectedIndex: _getMobileIndexFromCurrentIndex(),
      destinations: _mobileNavigationItems
          .map(
            (item) => NavigationDestination(
              icon: Icon(
                item.icon,
                size: 24,
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.6),
              ),
              selectedIcon: Icon(
                item.icon,
                size: 26,
              ),
              label: item.label,
            ),
          )
          .toList(),
    );
  }
}

class NavigationItem {
  final IconData icon;
  final String label;

  NavigationItem({required this.icon, required this.label});
}
