import 'package:flutter/material.dart';

import 'seed_scheme.dart';
import 'tokens.dart';
import 'typography.dart';

abstract final class AppTheme {
  static ThemeData build(Color seed, Brightness brightness) {
    final scheme = SeedScheme(seed, brightness).toColorScheme();
    final text = AppText.textTheme().apply(bodyColor: scheme.onSurface, displayColor: scheme.onSurface);
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      brightness: brightness,
      scaffoldBackgroundColor: scheme.surface,
      canvasColor: scheme.surface,
      fontFamily: AppText.display,
      textTheme: text,
      splashFactory: InkSparkle.splashFactory,
      focusColor: scheme.primary.withValues(alpha: .16),
      hoverColor: scheme.onSurface.withValues(alpha: .08),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: scheme.primary,
        selectionColor: scheme.primary.withValues(alpha: .32),
        selectionHandleColor: scheme.primary,
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(color: scheme.inverseSurface, borderRadius: Radii.chip),
        textStyle: AppText.caption(size: 13).copyWith(color: scheme.onInverseSurface),
        waitDuration: const Duration(milliseconds: 400),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: scheme.inverseSurface,
        contentTextStyle: AppText.manrope(14, 500, height: 1.3).copyWith(color: scheme.onInverseSurface),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
        elevation: 6,
        width: 420,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: scheme.surfaceContainerLow,
        modalBackgroundColor: scheme.surfaceContainerLow,
        showDragHandle: false,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(36))),
        constraints: const BoxConstraints(maxWidth: 640),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: AppText.body(size: 22, weight: 500).copyWith(color: scheme.onSurfaceVariant.withValues(alpha: .6)),
        border: InputBorder.none,
      ),
      scrollbarTheme: ScrollbarThemeData(
        thumbColor: WidgetStatePropertyAll(scheme.onSurface.withValues(alpha: .24)),
        radius: const Radius.circular(8),
      ),
    );
  }
}
