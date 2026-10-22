import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/motion/springs.dart';
import '../core/theme/app_theme.dart';
import '../core/theme/theme_controller.dart';
import 'router.dart';

class PortfolioApp extends StatefulWidget {
  const PortfolioApp({super.key, required this.theme, this.router});

  final ThemeController theme;

  /// Injected in tests; built once otherwise.
  final GoRouter? router;

  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  late final GoRouter _router = widget.router ?? buildRouter();

  @override
  Widget build(BuildContext context) {
    return ThemeScope(
      controller: widget.theme,
      child: ListenableBuilder(
        listenable: widget.theme,
        builder: (context, _) {
          final seed = widget.theme.seed;
          return MaterialApp.router(
            title: siteTitle,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.build(seed, Brightness.light),
            darkTheme: AppTheme.build(seed, Brightness.dark),
            themeMode: widget.theme.mode,
            themeAnimationDuration: M3Spring.slowEffects.duration * 2,
            themeAnimationCurve: Curves.easeInOut,
            routerConfig: _router,
          );
        },
      ),
    );
  }
}
