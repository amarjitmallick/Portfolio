import 'package:flutter/material.dart';

import '../motion/springs.dart';
import '../theme/typography.dart';
import 'pressable.dart';

class GroupItem<T> {
  const GroupItem({required this.value, required this.label, this.caption, this.icon, this.tooltip});
  final T value;
  final String label;
  final String? caption;
  final IconData? icon;
  final String? tooltip;
}

/// M3 Expressive connected button group: the selected item becomes a pill
/// in the primary colour; the rest keep small corners. Corners spring
/// (fast spatial); colours use the effects spring. Pressing squeezes an
/// item towards a pill.
class ConnectedButtonGroup<T> extends StatelessWidget {
  const ConnectedButtonGroup({
    super.key,
    required this.items,
    required this.selected,
    required this.onSelected,
    this.height = 44,
    this.gap = 3,
    this.padding = const EdgeInsets.symmetric(horizontal: 18),
    this.unselectedColor,
    this.unselectedRadius,
    this.selectedRadius,
    this.fontSize = 15,
    this.scrollable = false,
    this.semanticLabel,
  });

  final List<GroupItem<T>> items;
  final T selected;
  final ValueChanged<T> onSelected;
  final double height;
  final double gap;
  final EdgeInsets padding;
  final Color? unselectedColor;

  /// Corner radius for an unselected item at [index] of [count]. Defaults
  /// to 10 all round.
  final BorderRadius Function(int index, int count)? unselectedRadius;
  final double? selectedRadius;
  final double fontSize;
  final bool scrollable;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final pill = BorderRadius.circular(selectedRadius ?? height / 2);
    final spatial = M3Spring.fastSpatial;
    final effects = M3Spring.defaultEffects;
    final children = <Widget>[];
    for (var i = 0; i < items.length; i++) {
      final item = items[i];
      final on = item.value == selected;
      final rest = unselectedRadius?.call(i, items.length) ?? BorderRadius.circular(10);
      if (i > 0) children.add(SizedBox(width: gap));
      children.add(
        Pressable(
          onTap: () => onSelected(item.value),
          selected: on,
          tooltip: item.tooltip,
          focusRadius: rest,
          builder: (context, s) {
            final fg = on ? scheme.onPrimary : scheme.onSurface;
            return AnimatedContainer(
              duration: spatial.durationOf(context),
              curve: spatial.curve,
              height: height,
              padding: padding,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: on ? scheme.primary : (unselectedColor ?? scheme.surfaceContainerHigh),
                borderRadius: on || s.pressed ? pill : rest,
              ),
              foregroundDecoration: BoxDecoration(
                color: s.hovered && !on ? scheme.onSurface.withValues(alpha: .08) : Colors.transparent,
                borderRadius: on || s.pressed ? pill : rest,
              ),
              child: AnimatedDefaultTextStyle(
                duration: effects.durationOf(context),
                curve: effects.curve,
                style: AppText.withWeight(AppText.button(size: fontSize), on ? 700 : 500).copyWith(color: fg),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (item.icon != null) ...[Icon(item.icon, size: 20, color: fg), const SizedBox(width: 6)],
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.label),
                        if (item.caption != null)
                          Text(
                            item.caption!,
                            style: AppText.caption(size: 11).copyWith(color: fg.withValues(alpha: .75)),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    }
    final row = Row(mainAxisSize: MainAxisSize.min, children: children);
    return Semantics(
      container: true,
      label: semanticLabel,
      child: scrollable ? SingleChildScrollView(scrollDirection: Axis.horizontal, child: row) : row,
    );
  }
}
