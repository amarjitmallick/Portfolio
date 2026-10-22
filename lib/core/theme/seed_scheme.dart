import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Port of the design's tonal scheme generator (an OKLCH approximation of
/// HCT tones). Material's own `ColorScheme.fromSeed` lands on slightly
/// different tones, so it is used as the base and every role the design
/// defines is overridden with these values.
class SeedScheme {
  SeedScheme._(this.seed, this.brightness, this._roles);

  factory SeedScheme(Color seed, Brightness brightness) {
    final lch = _toOklch(seed);
    final pc = lch.c.clamp(0.11, 0.2);
    final h = lch.h;
    String p(double t) => _tone(h, pc, t);
    String s(double t) => _tone(h, 0.045, t);
    String te(double t) => _tone((h + 70) % 360, 0.11, t);
    String n(double t) => _tone(h, 0.008, t);
    String v(double t) => _tone(h, 0.022, t);
    String e(double t) => _tone(27, 0.17, t);
    final d = brightness == Brightness.dark;
    double k(double dark, double light) => d ? dark : light;
    return SeedScheme._(seed, brightness, {
      'primary': p(k(80, 40)),
      'onPrimary': p(k(20, 100)),
      'primaryContainer': p(k(30, 90)),
      'onPrimaryContainer': p(k(90, 10)),
      'secondary': s(k(80, 40)),
      'onSecondary': s(k(20, 100)),
      'secondaryContainer': s(k(30, 90)),
      'onSecondaryContainer': s(k(90, 10)),
      'tertiary': te(k(80, 40)),
      'onTertiary': te(k(20, 100)),
      'tertiaryContainer': te(k(30, 90)),
      'onTertiaryContainer': te(k(90, 10)),
      'surface': n(k(6, 98)),
      'surface0': n(k(4, 100)),
      'surface1': n(k(10, 96)),
      'surface2': n(k(12, 94)),
      'surface3': n(k(17, 92)),
      'surface4': n(k(22, 90)),
      'onSurface': n(k(90, 10)),
      'onSurfaceVariant': v(k(80, 30)),
      'outline': v(k(60, 50)),
      'outlineVariant': v(k(30, 80)),
      'inverseSurface': n(k(90, 20)),
      'onInverseSurface': n(k(20, 95)),
      'inversePrimary': p(k(40, 80)),
      'error': e(k(80, 40)),
      'onError': e(k(20, 100)),
      'errorContainer': e(k(30, 90)),
      'onErrorContainer': e(k(90, 10)),
    });
  }

  final Color seed;
  final Brightness brightness;
  final Map<String, String> _roles;

  Color role(String name) => Color(int.parse('FF${_roles[name]!.substring(1)}', radix: 16));

  ColorScheme toColorScheme() {
    return ColorScheme.fromSeed(seedColor: seed, brightness: brightness).copyWith(
      primary: role('primary'),
      onPrimary: role('onPrimary'),
      primaryContainer: role('primaryContainer'),
      onPrimaryContainer: role('onPrimaryContainer'),
      secondary: role('secondary'),
      onSecondary: role('onSecondary'),
      secondaryContainer: role('secondaryContainer'),
      onSecondaryContainer: role('onSecondaryContainer'),
      tertiary: role('tertiary'),
      onTertiary: role('onTertiary'),
      tertiaryContainer: role('tertiaryContainer'),
      onTertiaryContainer: role('onTertiaryContainer'),
      surface: role('surface'),
      surfaceContainerLowest: role('surface0'),
      surfaceContainerLow: role('surface1'),
      surfaceContainer: role('surface2'),
      surfaceContainerHigh: role('surface3'),
      surfaceContainerHighest: role('surface4'),
      onSurface: role('onSurface'),
      onSurfaceVariant: role('onSurfaceVariant'),
      outline: role('outline'),
      outlineVariant: role('outlineVariant'),
      inverseSurface: role('inverseSurface'),
      onInverseSurface: role('onInverseSurface'),
      inversePrimary: role('inversePrimary'),
      error: role('error'),
      onError: role('onError'),
      errorContainer: role('errorContainer'),
      onErrorContainer: role('onErrorContainer'),
    );
  }
}

double _lin(double c) => c <= 0.04045 ? c / 12.92 : math.pow((c + 0.055) / 1.055, 2.4).toDouble();

double _gam(double c) => c <= 0.0031308 ? 12.92 * c : 1.055 * math.pow(c, 1 / 2.4) - 0.055;

double _cbrt(double x) => x < 0 ? -math.pow(-x, 1 / 3).toDouble() : math.pow(x, 1 / 3).toDouble();

({double l, double c, double h}) _toOklch(Color color) {
  final r = _lin((color.r * 255).round() / 255);
  final g = _lin((color.g * 255).round() / 255);
  final b = _lin((color.b * 255).round() / 255);
  final l = _cbrt(0.4122214708 * r + 0.5363325363 * g + 0.0514459929 * b);
  final m = _cbrt(0.2119034982 * r + 0.6806995451 * g + 0.1073969566 * b);
  final s = _cbrt(0.0883024619 * r + 0.2817188376 * g + 0.6299787005 * b);
  final bigL = 0.2104542553 * l + 0.793617785 * m - 0.0040720468 * s;
  final a = 1.9779984951 * l - 2.428592205 * m + 0.4505937099 * s;
  final bb = 0.0259040371 * l + 0.7827717662 * m - 0.808675766 * s;
  return (l: bigL, c: math.sqrt(a * a + bb * bb), h: (math.atan2(bb, a) * 180 / math.pi + 360) % 360);
}

List<double> _oklchToRgb(double l, double c, double h) {
  final a = c * math.cos(h * math.pi / 180);
  final b = c * math.sin(h * math.pi / 180);
  final ll = math.pow(l + 0.3963377774 * a + 0.2158037573 * b, 3).toDouble();
  final m = math.pow(l - 0.1055613458 * a - 0.0638541728 * b, 3).toDouble();
  final s = math.pow(l - 0.0894841775 * a - 1.291485548 * b, 3).toDouble();
  return [
    4.0767416621 * ll - 3.3077115913 * m + 0.2309699292 * s,
    -1.2684380046 * ll + 2.6097574011 * m - 0.3413193965 * s,
    -0.0041960863 * ll - 0.7034186147 * m + 1.707614701 * s,
  ];
}

bool _inGamut(List<double> rgb) => rgb.every((v) => v >= -0.0005 && v <= 1.0005);

String _tone(double h, double c, double t) {
  final y = t > 8 ? math.pow((t + 16) / 116, 3).toDouble() : t / 903.3;
  final l = _cbrt(y);
  var hi = c;
  if (!_inGamut(_oklchToRgb(l, hi, h))) {
    var lo = 0.0;
    for (var i = 0; i < 18; i++) {
      final mid = (lo + hi) / 2;
      if (_inGamut(_oklchToRgb(l, mid, h))) {
        lo = mid;
      } else {
        hi = mid;
      }
    }
    hi = lo;
  }
  final rgb = _oklchToRgb(l, hi, h).map((v) => (_gam(v.clamp(0.0, 1.0)).clamp(0.0, 1.0) * 255).round());
  return '#${rgb.map((v) => v.toRadixString(16).padLeft(2, '0')).join().toUpperCase()}';
}
