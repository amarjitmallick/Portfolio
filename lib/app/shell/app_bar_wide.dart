import 'package:flutter/foundation.dart';

import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';

import '../../content/identity.dart';
import '../../content/microcopy.dart';
import '../../core/motion/springs.dart';
import '../../core/theme/theme_controller.dart';
import '../../core/theme/tokens.dart';
import '../../core/theme/typography.dart';
import '../../core/widgets/connected_button_group.dart';
import '../../core/widgets/eclipse_switch.dart';
import '../../core/widgets/pressable.dart';
import 'shell_actions.dart';

/// Sticky, blurred top bar for wide screens.
class AppBarWide extends SliverPersistentHeaderDelegate {
  AppBarWide({required this.active});

  final ValueListenable<String> active;

  @override
  double get minExtent => Space.appBarHeight;
  @override
  double get maxExtent => Space.appBarHeight;

  @override
  bool shouldRebuild(AppBarWide old) => old.active != active;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) => WideAppBar(active: active);
}

/// The bar itself (the delegate pins it).
class WideAppBar extends StatelessWidget {
  const WideAppBar({super.key, required this.active});

  final ValueListenable<String> active;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final width = MediaQuery.sizeOf(context).width;
    final actions = ShellActions.of(context);
    final theme = ThemeScope.of(context);
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 22, sigmaY: 22),
        child: Container(
          height: Space.appBarHeight,
          padding: EdgeInsets.symmetric(horizontal: Space.fluid(width, 16, 3, 40)),
          decoration: BoxDecoration(
            color: scheme.surface.withValues(alpha: .62),
            border: Border(bottom: BorderSide(color: scheme.outlineVariant.withValues(alpha: .6))),
          ),
          child: Row(
            children: [
              _NameButton(onTap: () => actions.goTo('home')),
              SizedBox(width: Space.fluid(width, 16, 2.4, 32)),
              Expanded(
                child: Semantics(
                  container: true,
                  explicitChildNodes: true,
                  label: 'Main navigation',
                  child: ValueListenableBuilder<String>(
                    valueListenable: active,
                    builder: (context, current, _) => Align(
                      alignment: Alignment.centerLeft,
                      child: ConnectedButtonGroup<String>(
                        scrollable: true,
                        items: [for (final n in Microcopy.nav) GroupItem(value: n.id, label: n.label)],
                        selected: current,
                        onSelected: actions.goTo,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: Space.fluid(width, 16, 2.4, 32)),
              EclipseSwitch(
                dark: theme.isDark,
                label: theme.isDark ? Microcopy.switchToLight : Microcopy.switchToDark,
                onToggle: theme.toggleMode,
              ),
              SizedBox(width: Space.fluid(width, 16, 2.4, 32)),
              _ContactButton(onTap: actions.openContact),
            ],
          ),
        ),
      ),
    );
  }
}

class _NameButton extends StatelessWidget {
  const _NameButton({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final def = M3Spring.defaultSpatial;
    return Pressable(
      onTap: onTap,
      semanticLabel: '${Identity.name}, home',
      focusRadius: BorderRadius.circular(8),
      builder: (context, s) => TweenAnimationBuilder<double>(
        tween: Tween(end: s.hovered ? .02 : -.01),
        duration: def.durationOf(context),
        curve: def.curve,
        builder: (context, ls, _) => Text(
          Identity.name,
          maxLines: 1,
          style: AppText.urbanist(20, 700, tracking: ls),
        ),
      ),
    );
  }
}

class _ContactButton extends StatelessWidget {
  const _ContactButton({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final fast = M3Spring.fastSpatial;
    return Pressable(
      onTap: onTap,
      focusRadius: Radii.button,
      builder: (context, s) => AnimatedContainer(
        duration: fast.durationOf(context),
        curve: fast.curve,
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 18),
        decoration: BoxDecoration(
          color: scheme.primaryContainer,
          borderRadius: BorderRadius.circular(s.pressed ? 8 : (s.hovered ? 22 : 14)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.mail_rounded, size: 20, color: scheme.onPrimaryContainer),
            const SizedBox(width: 8),
            Text(Microcopy.contact, style: AppText.button().copyWith(color: scheme.onPrimaryContainer)),
          ],
        ),
      ),
    );
  }
}
