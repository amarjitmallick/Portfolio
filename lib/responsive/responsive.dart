import 'package:flutter/widgets.dart';

/// Centralized breakpoints – tweak once, used everywhere.
class Breakpoints {
  static const double mobile = 600; // < 600
  static const double tablet = 840; // 600–899
  static const double desktop = 1200; // 900+
}

enum ScreenType { mobile, tablet, desktop }

extension ResponsiveContext on BuildContext {
  double get screenWidth => MediaQuery.sizeOf(this).width;

  ScreenType get screenType {
    if (screenWidth < Breakpoints.mobile) return ScreenType.mobile;
    if (screenWidth < Breakpoints.tablet) return ScreenType.tablet;
    return ScreenType.desktop;
  }

  bool get isMobile => screenType == ScreenType.mobile;
  bool get isTablet => screenType == ScreenType.tablet;
  bool get isDesktop => screenType == ScreenType.desktop;
}

/// Swap entire subtrees based on screen size.
class Responsive extends StatelessWidget {
  const Responsive({
    super.key,
    this.mobile,
    this.tablet,
    required this.desktop,
  });

  final Widget? mobile;
  final Widget? tablet;
  final Widget desktop;

  @override
  Widget build(BuildContext context) {
    if (context.isMobile && mobile != null) return mobile!;
    if (context.isTablet && tablet != null) return tablet!;
    return desktop;
  }
}

/// Pick a value per screen size (for paddings, font sizes, gaps, etc.).
class ResponsiveValue<T> {
  const ResponsiveValue({
    required this.desktop,
    this.tablet,
    this.mobile,
  });

  final T desktop;
  final T? tablet;
  final T? mobile;

  T resolve(BuildContext context) {
    if (context.isMobile && mobile != null) return mobile as T;
    if (context.isTablet && tablet != null) return tablet as T;
    return desktop;
  }
}

/// Optional: center + constrain content width for better readability.
class ResponsivePage extends StatelessWidget {
  const ResponsivePage({
    super.key,
    required this.child,
    this.maxWidth = 1400,
    this.horizontalPadding,
  });

  final Widget child;
  final double maxWidth;
  final double? horizontalPadding;

  @override
  Widget build(BuildContext context) {
    final pad =
        horizontalPadding ??
        const ResponsiveValue<double>(
          desktop: 24,
          tablet: 20,
          mobile: 16,
        ).resolve(context);

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: pad),
          child: child,
        ),
      ),
    );
  }
}
