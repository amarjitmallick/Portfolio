import 'package:flutter/material.dart';

import 'responsive.dart';

class BreakpointTypography extends StatelessWidget {
  const BreakpointTypography({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaled = _scaledTextTheme(context, theme.textTheme);
    return Theme(
      data: theme.copyWith(textTheme: scaled),
      child: child,
    );
  }

  static TextTheme _scaledTextTheme(BuildContext context, TextTheme base) {
    final w = MediaQuery.sizeOf(context).width;
    final scales = w < Breakpoints.mobile
        ? _Scales.mobile
        : (w < Breakpoints.tablet ? _Scales.tablet : _Scales.desktop);

    TextStyle? s(TextStyle? style, double f) => style?.copyWith(fontSize: (style.fontSize ?? 14) * f);

    return base.copyWith(
      // Grow the big stuff most
      displayLarge: s(base.displayLarge, scales.display),
      displayMedium: s(base.displayMedium, scales.display),
      displaySmall: s(base.displaySmall, scales.display),

      headlineLarge: s(base.headlineLarge, scales.headline),
      headlineMedium: s(base.headlineMedium, scales.headline),
      headlineSmall: s(base.headlineSmall, scales.title),

      // Titles get a gentle bump
      titleLarge: s(base.titleLarge, scales.title),
      titleMedium: s(base.titleMedium, scales.title),
      titleSmall: s(base.titleSmall, scales.title),

      // Body barely changes (readability)
      bodyLarge: s(base.bodyLarge, scales.body),
      bodyMedium: s(base.bodyMedium, scales.body),
      bodySmall: s(base.bodySmall, scales.body),

      // Labels unchanged (chips, buttons, etc.)
      labelLarge: s(base.labelLarge, scales.label),
      labelMedium: s(base.labelMedium, scales.label),
      labelSmall: s(base.labelSmall, scales.label),
    );
  }
}

class _Scales {
  final double display;
  final double headline;
  final double title;
  final double body;
  final double label;

  const _Scales({
    required this.display,
    required this.headline,
    required this.title,
    required this.body,
    required this.label,
  });

  // Tune these to taste:
  static const mobile = _Scales(display: 0.90, headline: 0.94, title: 0.98, body: 1.00, label: 1.00);
  static const tablet = _Scales(display: 0.90, headline: 0.90, title: 0.90, body: 0.90, label: 1.00);
  static const desktop = _Scales(display: 1.00, headline: 1.00, title: 1.00, body: 1.00, label: 1.00);
}
