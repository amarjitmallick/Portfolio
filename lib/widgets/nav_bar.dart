import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../themes/theme_provider.dart';

class NavBar extends StatelessWidget implements PreferredSizeWidget {
  final Function(String section)? onItemSelected;

  const NavBar({super.key, this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.themeMode == ThemeMode.dark;

    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.95),
      elevation: 1,
      toolbarHeight: 70,
      titleSpacing: 20,
      title: Text(
        'Portfolio',
        style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.bodyLarge?.color),
      ),
      actions: [
        ...[
          'About',
          'Projects',
          'Publications',
          'Career',
          'Contact',
        ].map((section) => _navItem(section, context)),
        const SizedBox(width: 180),
        // Light/Dark toggle
        // Switch(
        //   value: isDarkMode,
        //   onChanged: (value) {
        //     themeProvider.toggleTheme(value);
        //   },
        // ),
        // const SizedBox(width: 8),
        // Profile Avatar
        const CircleAvatar(
          radius: 18,
          backgroundImage: AssetImage(
            'assets/images/profile.jpeg', // Placeholder profile image
          ),
        ),
        const SizedBox(width: 16),
      ],
    );
  }

  Widget _navItem(String title, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextButton(
        onPressed: () {
          if (onItemSelected != null) onItemSelected!(title);
        },
        child: Text(title, style: Theme.of(context).textTheme.titleMedium),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
