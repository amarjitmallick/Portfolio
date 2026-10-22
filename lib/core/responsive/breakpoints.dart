import 'package:flutter/widgets.dart';

/// Breakpoints from the design (not the M3 defaults).
abstract final class Breakpoints {
  /// Top app bar + side-by-side layouts from here; floating bottom nav below.
  static const double wide = 720;

  /// Project detail splits into hero | content.
  static const double detailTwoColumn = 900;

  /// Work section shows catalog | canvas | knobs; FAB shows its label.
  static const double workThreeColumn = 1100;
}

extension Responsive on BuildContext {
  double get screenWidth => MediaQuery.sizeOf(this).width;
  bool get isWide => screenWidth >= Breakpoints.wide;
}
