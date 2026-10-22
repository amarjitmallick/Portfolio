import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/core/theme/seed_scheme.dart';
import 'package:portfolio/core/theme/tokens.dart';

double _lum(Color c) {
  double ch(double v) => v <= 0.03928 ? v / 12.92 : math.pow((v + 0.055) / 1.055, 2.4).toDouble();
  return 0.2126 * ch(c.r) + 0.7152 * ch(c.g) + 0.0722 * ch(c.b);
}

double contrast(Color a, Color b) {
  final la = _lum(a), lb = _lum(b);
  return (math.max(la, lb) + 0.05) / (math.min(la, lb) + 0.05);
}

void main() {
  // WCAG AA: 4.5:1 for body text, 3:1 for large text (headings ≥ 24px).
  for (final seed in seeds) {
    for (final b in Brightness.values) {
      final s = SeedScheme(seed.color, b).toColorScheme();
      test('${seed.name} ${b.name}: text pairs meet AA', () {
        final body = <String, (Color, Color)>{
          'onSurface/surface': (s.onSurface, s.surface),
          'onSurfaceVariant/surface': (s.onSurfaceVariant, s.surface),
          'onSurfaceVariant/surfaceContainerLow': (s.onSurfaceVariant, s.surfaceContainerLow),
          'onSurfaceVariant/surfaceContainer': (s.onSurfaceVariant, s.surfaceContainer),
          'onSurfaceVariant/surfaceContainerHigh': (s.onSurfaceVariant, s.surfaceContainerHigh),
          'onPrimary/primary': (s.onPrimary, s.primary),
          'onPrimaryContainer/primaryContainer': (s.onPrimaryContainer, s.primaryContainer),
          'onSecondaryContainer/secondaryContainer': (s.onSecondaryContainer, s.secondaryContainer),
          'onTertiaryContainer/tertiaryContainer': (s.onTertiaryContainer, s.tertiaryContainer),
          'onInverseSurface/inverseSurface': (s.onInverseSurface, s.inverseSurface),
          'primary/surfaceContainerHigh (links, labels)': (s.primary, s.surfaceContainerHigh),
          'error/surfaceContainer (form errors)': (s.error, s.surfaceContainer),
          // Translucent text used by the design.
          'wink 80%/surface': (Color.alphaBlend(s.onSurfaceVariant.withValues(alpha: .8), s.surface), s.surface),
          'catalog caption 75%/surfaceContainerLow': (
            Color.alphaBlend(s.onSurface.withValues(alpha: .75), s.surfaceContainerLow),
            s.surfaceContainerLow,
          ),
          'role duration 80%/primaryContainer': (
            Color.alphaBlend(s.onPrimaryContainer.withValues(alpha: .8), s.primaryContainer),
            s.primaryContainer,
          ),
          'footer 85%/primaryContainer': (
            Color.alphaBlend(s.onPrimaryContainer.withValues(alpha: .85), s.primaryContainer),
            s.primaryContainer,
          ),
        };
        final large = <String, (Color, Color)>{
          'primary/surface (accent heading lines)': (s.primary, s.surface),
          'primary/surfaceContainerLow': (s.primary, s.surfaceContainerLow),
        };
        final failures = <String>[
          for (final e in body.entries)
            if (contrast(e.value.$1, e.value.$2) < 4.5) '${e.key} ${contrast(e.value.$1, e.value.$2).toStringAsFixed(2)}',
          for (final e in large.entries)
            if (contrast(e.value.$1, e.value.$2) < 3) '${e.key} ${contrast(e.value.$1, e.value.$2).toStringAsFixed(2)}',
        ];
        expect(failures, isEmpty);
      });
    }
  }
}
