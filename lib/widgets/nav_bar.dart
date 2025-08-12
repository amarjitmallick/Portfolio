// widgets/nav_bar.dart
import 'package:flutter/material.dart';
import 'package:portfolio/responsive/responsive.dart';

class NavBar extends StatelessWidget implements PreferredSizeWidget {
  final Function(String section)? onItemSelected;

  const NavBar({super.key, this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    final isCompact = context.isTablet; // tablet = compact, desktop = full

    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.95),
      elevation: 1,
      toolbarHeight: 70,
      titleSpacing: 20,
      leading: isCompact
          ? IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
              tooltip: 'Menu',
            )
          : null,
      title: Text(
        'Portfolio',
        style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.bodyLarge?.color),
      ),
      actions: isCompact
          ? const [
              CircleAvatar(radius: 18, backgroundImage: AssetImage('assets/images/profile.jpeg')),
              SizedBox(width: 16),
            ]
          : [
              ...[
                'About',
                'Projects',
                'Publications',
                'Career',
                'Contact',
              ].map((section) => _navItem(section, context)),
              const SizedBox(width: 180),
              const CircleAvatar(radius: 18, backgroundImage: AssetImage('assets/images/profile.jpeg')),
              const SizedBox(width: 16),
            ],
    );
  }

  Widget _navItem(String title, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextButton(
        onPressed: () => onItemSelected?.call(title),
        child: Text(title, style: Theme.of(context).textTheme.titleMedium),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
