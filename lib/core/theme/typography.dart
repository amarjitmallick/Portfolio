import 'package:flutter/material.dart';

/// Every text style in the app comes from here. The fonts ship as variable
/// TTFs, so each style sets both [FontWeight] (for semantics/fallback) and the
/// `wght` axis (what actually renders).
abstract final class AppText {
  static const String display = 'Urbanist';
  static const String label = 'Manrope';

  static TextStyle urbanist(double size, double weight, {double? height, double tracking = 0}) =>
      _style(display, size, weight, height: height, tracking: tracking);

  static TextStyle manrope(double size, double weight, {double? height, double tracking = 0}) =>
      _style(label, size, weight, height: height, tracking: tracking);

  /// [tracking] is in em, like the design's CSS letter-spacing.
  static TextStyle _style(String family, double size, double weight, {double? height, double tracking = 0}) {
    return TextStyle(
      fontFamily: family,
      fontSize: size,
      height: height,
      letterSpacing: tracking * size,
      fontWeight: _nearest(weight),
      fontVariations: [FontVariation('wght', weight)],
    );
  }

  static FontWeight _nearest(double w) => FontWeight.values[((w / 100).round() - 1).clamp(0, 8)];

  /// Returns [style] at a new weight (used by scroll-linked weight effects).
  static TextStyle withWeight(TextStyle style, double weight) => style.copyWith(
    fontWeight: _nearest(weight),
    fontVariations: [FontVariation('wght', weight)],
  );

  // Named design styles.
  static TextStyle hero(double size, double weight) => urbanist(size, weight, height: .84, tracking: -.055);
  static TextStyle sectionHeading(double size, double weight) => urbanist(size, weight, height: .9, tracking: -.05);
  static TextStyle eyebrow({double size = 12, double weight = 700}) => manrope(size, weight, tracking: .14);
  static TextStyle body({double size = 16, double weight = 400}) => urbanist(size, weight, height: 1.5);
  static TextStyle bodyStrong({double size = 16}) => urbanist(size, 700, height: 1.5);
  static TextStyle button({double size = 15, double weight = 700}) => urbanist(size, weight);
  static TextStyle caption({double size = 12, double weight = 500}) => manrope(size, weight, height: 1.3);
  static TextStyle mono({double size = 13, double weight = 600}) =>
      manrope(size, weight, height: 1.5).copyWith(fontFeatures: const [FontFeature.tabularFigures()]);

  static TextTheme textTheme() {
    return TextTheme(
      displayLarge: urbanist(57, 300, tracking: -.03),
      displayMedium: urbanist(45, 300),
      displaySmall: urbanist(36, 400),
      headlineLarge: urbanist(32, 800, tracking: -.02),
      headlineMedium: urbanist(28, 800, tracking: -.02),
      headlineSmall: urbanist(24, 700),
      titleLarge: urbanist(22, 700),
      titleMedium: urbanist(17, 600),
      titleSmall: urbanist(15, 600),
      bodyLarge: urbanist(16, 400, height: 1.5),
      bodyMedium: urbanist(15, 400, height: 1.5),
      bodySmall: urbanist(13, 400, height: 1.4),
      labelLarge: urbanist(15, 700),
      labelMedium: manrope(12, 600, tracking: .04),
      labelSmall: manrope(11, 600, tracking: .04),
    );
  }
}
