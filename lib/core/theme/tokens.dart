import 'package:flutter/material.dart';

/// Seeds the "Hot reload" button cycles through, in design order.
const List<({String name, Color color})> seeds = [
  (name: 'Saffron', color: Color(0xFFE6A100)),
  (name: 'Raspberry', color: Color(0xFFD81B60)),
  (name: 'Jade', color: Color(0xFF12A37A)),
  (name: 'Vermilion', color: Color(0xFFE4512B)),
  (name: 'Chartreuse', color: Color(0xFF9DBA00)),
  (name: 'Teal', color: Color(0xFF00A3A3)),
];

/// Background painted before the first frame (matches web/index.html).
const Color bootBackground = Color(0xFF141210);

/// Layout tokens. Fluid values mirror the design's CSS `clamp()` calls.
abstract final class Space {
  static const double appBarHeight = 84;
  static const double maxContent = 1200;

  /// clamp(16px, 3vw, 44px): the page gutter.
  static double gutter(double width) => fluid(width, 16, 3, 44);

  /// Equivalent of CSS `clamp(min, vw * width / 100, max)`.
  static double fluid(double width, double min, double vw, double max) => (width * vw / 100).clamp(min, max);
}

abstract final class Radii {
  static const double pill = 999;
  static const BorderRadius button = BorderRadius.all(Radius.circular(14));
  static const BorderRadius chip = BorderRadius.all(Radius.circular(10));
  static const BorderRadius card = BorderRadius.all(Radius.circular(28));
}
