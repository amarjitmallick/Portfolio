import 'package:flutter/material.dart';
import 'package:portfolio/responsive/typography.dart';
import 'package:provider/provider.dart';

import 'responsive/responsive.dart';
import 'screens/home/desktop_and_tab_home.dart';
import 'screens/home/mobile_home.dart';
import 'themes/theme_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Amarjit Mallick | Portfolio',
      theme: themeProvider.lightTheme,
      builder: (context, child) => BreakpointTypography(child: child ?? const SizedBox()),
      home: const ResponsiveHomeSwitcher(),
    );
  }
}

class ResponsiveHomeSwitcher extends StatelessWidget {
  const ResponsiveHomeSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        final w = constraints.maxWidth;
        if (w < Breakpoints.mobile) {
          return const MobileHome();
        }
        return const DesktopAndTabHome();
      },
    );
  }
}
