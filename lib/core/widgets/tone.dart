import 'package:flutter/material.dart';

import '../../content/models.dart';

/// Resolves a content [StatTone] to a background/foreground pair.
({Color bg, Color fg}) toneColors(ColorScheme s, StatTone tone) => switch (tone) {
  StatTone.tertiaryContainer => (bg: s.tertiaryContainer, fg: s.onTertiaryContainer),
  StatTone.secondaryContainer => (bg: s.secondaryContainer, fg: s.onSecondaryContainer),
  StatTone.primary => (bg: s.primary, fg: s.onPrimary),
  StatTone.primaryContainer => (bg: s.primaryContainer, fg: s.onPrimaryContainer),
  StatTone.surfaceHighest => (bg: s.surfaceContainerHighest, fg: s.onSurface),
};
