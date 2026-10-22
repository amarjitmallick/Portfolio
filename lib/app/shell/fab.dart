import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../content/identity.dart';
import '../../content/microcopy.dart';
import '../../core/motion/reveal.dart';
import '../../core/motion/springs.dart';
import '../../core/responsive/breakpoints.dart';
import '../../core/theme/theme_controller.dart';
import '../../core/theme/typography.dart';
import '../../core/widgets/pressable.dart';
import 'shell_actions.dart';

typedef _Action = ({IconData icon, String label, VoidCallback run});

List<_Action> _menuActions(BuildContext context, VoidCallback close, {required bool withHotReload}) {
  final actions = ShellActions.of(context);
  final theme = ThemeScope.read(context);
  return [
        if (withHotReload) (icon: Icons.bolt_rounded, label: Microcopy.hotReload, run: () => hotReload(context)),
        (icon: Icons.contrast_rounded, label: Microcopy.lightDark, run: theme.toggleMode),
        (icon: Icons.content_copy_rounded, label: Microcopy.copyEmail, run: () => actions.copy(Identity.email)),
        (icon: Icons.edit_rounded, label: Microcopy.writeMessage, run: actions.openContact),
      ]
      .map(
        (a) => (
          icon: a.icon,
          label: a.label,
          run: () {
            close();
            a.run();
          },
        ),
      )
      .toList();
}

/// Next seed + toast. Shapes tied to the seed index morph on their own.
void hotReload(BuildContext context) {
  ThemeScope.read(context).nextSeed();
  ShellActions.of(context).toast(Microcopy.hotReloadToast);
}

/// Wide screens: split button (Hot reload | ⌃) with a menu above it.
class SplitFab extends StatelessWidget {
  const SplitFab({super.key, required this.open});

  final ValueNotifier<bool> open;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final showLabel = context.screenWidth >= Breakpoints.workThreeColumn;
    final fast = M3Spring.fastSpatial, def = M3Spring.defaultSpatial;
    return ValueListenableBuilder<bool>(
      valueListenable: open,
      builder: (context, isOpen, _) {
        final items = _menuActions(context, () => open.value = false, withHotReload: false);
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (isOpen) ...[
              Material(
                color: scheme.surfaceContainerHigh,
                elevation: 8,
                shadowColor: Colors.black54,
                borderRadius: BorderRadius.circular(24),
                child: Container(
                  width: 236,
                  padding: const EdgeInsets.all(6),
                  child: Semantics(
                    container: true,
                    label: Microcopy.moreActions,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        for (var i = 0; i < items.length; i++)
                          SwapReveal(
                            keyValue: 'fab$i',
                            index: i,
                            child: _MenuItem(
                              action: items[i],
                              autofocus: i == 0,
                              rest: i == 0
                                  ? const BorderRadius.vertical(top: Radius.circular(18), bottom: Radius.circular(6))
                                  : (i == items.length - 1
                                        ? const BorderRadius.vertical(
                                            top: Radius.circular(6),
                                            bottom: Radius.circular(18),
                                          )
                                        : BorderRadius.circular(6)),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
            DecoratedBox(
              decoration: const BoxDecoration(
                boxShadow: [BoxShadow(color: Color(0x52000000), blurRadius: 18, offset: Offset(0, 8))],
                borderRadius: BorderRadius.all(Radius.circular(28)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Pressable(
                    onTap: () => hotReload(context),
                    semanticLabel: Microcopy.hotReload,
                    tooltip: showLabel ? null : Microcopy.hotReload,
                    focusRadius: const BorderRadius.horizontal(left: Radius.circular(28), right: Radius.circular(6)),
                    builder: (context, s) => AnimatedScale(
                      scale: s.pressed ? .97 : 1,
                      duration: fast.durationOf(context),
                      curve: fast.curve,
                      child: AnimatedContainer(
                        duration: fast.durationOf(context),
                        curve: fast.curve,
                        height: 56,
                        constraints: const BoxConstraints(minWidth: 56),
                        padding: EdgeInsets.only(left: showLabel ? 20 : 0, right: showLabel ? 22 : 0),
                        decoration: BoxDecoration(
                          color: scheme.primary,
                          borderRadius: BorderRadius.horizontal(
                            left: const Radius.circular(28),
                            right: Radius.circular(s.pressed ? 14 : 6),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.bolt_rounded, size: 26, color: scheme.onPrimary),
                            if (showLabel) ...[
                              const SizedBox(width: 10),
                              TweenAnimationBuilder<double>(
                                tween: Tween(end: s.hovered ? .03 : .005),
                                duration: def.durationOf(context),
                                curve: def.curve,
                                builder: (context, ls, _) => Text(
                                  Microcopy.hotReload,
                                  style: AppText.urbanist(18, 700, tracking: ls).copyWith(color: scheme.onPrimary),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 2),
                  Semantics(
                    expanded: isOpen,
                    child: Pressable(
                      onTap: () => open.value = !isOpen,
                      semanticLabel: Microcopy.moreActions,
                      tooltip: Microcopy.moreActions,
                      focusRadius: const BorderRadius.horizontal(left: Radius.circular(6), right: Radius.circular(28)),
                      builder: (context, s) => AnimatedScale(
                        scale: s.pressed ? .94 : 1,
                        duration: fast.durationOf(context),
                        curve: fast.curve,
                        child: AnimatedContainer(
                          duration: def.durationOf(context),
                          curve: def.curve,
                          width: isOpen ? 56 : 48,
                          height: 56,
                          decoration: BoxDecoration(
                            color: scheme.primary,
                            borderRadius: isOpen
                                ? BorderRadius.circular(28)
                                : const BorderRadius.horizontal(left: Radius.circular(6), right: Radius.circular(28)),
                          ),
                          child: AnimatedRotation(
                            turns: isOpen ? .5 : 0,
                            duration: def.durationOf(context),
                            curve: def.curve,
                            child: Icon(Icons.keyboard_arrow_up_rounded, size: 26, color: scheme.onPrimary),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _MenuItem extends StatelessWidget {
  const _MenuItem({required this.action, required this.rest, this.autofocus = false});

  final _Action action;
  final BorderRadius rest;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final fast = M3Spring.fastSpatial;
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Pressable(
        onTap: action.run,
        autofocus: autofocus,
        focusRadius: rest,
        builder: (context, s) => AnimatedContainer(
          duration: fast.durationOf(context),
          curve: fast.curve,
          height: 52,
          padding: const EdgeInsets.only(left: 14, right: 18),
          decoration: BoxDecoration(
            color: s.hovered || s.focused ? scheme.surfaceContainerHighest : Colors.transparent,
            borderRadius: s.pressed ? BorderRadius.circular(26) : (s.hovered ? BorderRadius.circular(14) : rest),
          ),
          child: Row(
            children: [
              Icon(action.icon, size: 22, color: scheme.primary),
              const SizedBox(width: 14),
              Text(action.label, style: AppText.urbanist(16, 600).copyWith(color: scheme.onSurface)),
            ],
          ),
        ),
      ),
    );
  }
}

/// Narrow screens: floating pill nav + bolt FAB; the FAB opens a stacked
/// action list over a scrim.
class NarrowNav extends StatelessWidget {
  const NarrowNav({super.key, required this.active, required this.open});

  final ValueListenable<String> active;
  final ValueNotifier<bool> open;

  static const double height = 76;

  static const _icons = {
    'home': Icons.home_rounded,
    'work': Icons.widgets_rounded,
    'career': Icons.commit_rounded,
    'about': Icons.person_rounded,
    'notes': Icons.article_rounded,
  };

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final actions = ShellActions.of(context);
    final width = context.screenWidth;
    final fast = M3Spring.fastSpatial, fx = M3Spring.defaultEffects;
    return ValueListenableBuilder<bool>(
      valueListenable: open,
      builder: (context, isOpen, _) {
        final items = _menuActions(context, () => open.value = false, withHotReload: true);
        return Stack(
          children: [
            if (isOpen)
              Positioned.fill(
                child: GestureDetector(
                  onTap: () => open.value = false,
                  child: const ColoredBox(color: Color(0x59000000)),
                ),
              ),
            if (isOpen)
              Positioned(
                right: 14,
                bottom: 96,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    for (var i = 0; i < items.length; i++)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: SwapReveal(
                          keyValue: 'm$i',
                          index: i,
                          child: Pressable(
                            onTap: items[i].run,
                            autofocus: i == 0,
                            focusRadius: BorderRadius.circular(28),
                            builder: (context, s) => Material(
                              color: scheme.primaryContainer,
                              elevation: 4,
                              borderRadius: BorderRadius.circular(28),
                              child: Container(
                                height: 56,
                                padding: const EdgeInsets.only(left: 18, right: 22),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(items[i].icon, size: 22, color: scheme.onPrimaryContainer),
                                    const SizedBox(width: 12),
                                    Text(
                                      items[i].label,
                                      style: AppText.urbanist(16, 600).copyWith(color: scheme.onPrimaryContainer),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 14),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0, .4],
                    colors: [scheme.surface.withValues(alpha: 0), scheme.surface],
                  ),
                ),
                child: SafeArea(
                  top: false,
                  child: Row(
                    children: [
                      Expanded(
                        child: Semantics(
                          container: true,
                          explicitChildNodes: true,
                          label: 'Main navigation',
                          child: Material(
                            color: scheme.surfaceContainerHigh,
                            elevation: 6,
                            shadowColor: Colors.black45,
                            borderRadius: BorderRadius.circular(999),
                            child: Padding(
                              padding: const EdgeInsets.all(6),
                              child: ValueListenableBuilder<String>(
                                valueListenable: active,
                                builder: (context, current, _) => Row(
                                  children: [
                                    for (final n in Microcopy.nav) ...[
                                      if (n != Microcopy.nav.first) const SizedBox(width: 3),
                                      _navItem(context, n, current == n.id, width >= 360, actions, fast, fx),
                                    ],
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Semantics(
                        expanded: isOpen,
                        child: Pressable(
                          onTap: () => open.value = !isOpen,
                          semanticLabel: Microcopy.fabMobileTitle,
                          tooltip: Microcopy.fabMobileTitle,
                          focusRadius: BorderRadius.circular(16),
                          builder: (context, s) => AnimatedContainer(
                            duration: fast.durationOf(context),
                            curve: fast.curve,
                            width: 52,
                            height: 52,
                            decoration: BoxDecoration(
                              color: scheme.primary,
                              borderRadius: BorderRadius.circular(isOpen ? 26 : 16),
                              boxShadow: const [
                                BoxShadow(color: Color(0x59000000), blurRadius: 16, offset: Offset(0, 6)),
                              ],
                            ),
                            child: Icon(
                              isOpen ? Icons.close_rounded : Icons.bolt_rounded,
                              size: 26,
                              color: scheme.onPrimary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _navItem(
    BuildContext context,
    ({String id, String label}) n,
    bool on,
    bool showLabel,
    ShellActions actions,
    M3Spring fast,
    M3Spring fx,
  ) {
    final scheme = Theme.of(context).colorScheme;
    final fg = on ? scheme.onPrimary : scheme.onSurface;
    final button = Pressable(
      onTap: () => actions.goTo(n.id),
      semanticLabel: n.label,
      selected: on,
      focusRadius: BorderRadius.circular(22),
      builder: (context, s) => AnimatedContainer(
        duration: fast.durationOf(context),
        curve: fast.curve,
        height: 44,
        constraints: const BoxConstraints(minWidth: 38),
        padding: EdgeInsets.symmetric(horizontal: on ? 14 : 0),
        decoration: BoxDecoration(
          color: on ? scheme.primary : scheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(on ? 22 : 10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(_icons[n.id], size: 21, color: fg),
            if (on && showLabel) ...[
              const SizedBox(width: 6),
              Text(n.label, style: AppText.urbanist(13, 700).copyWith(color: fg)),
            ],
          ],
        ),
      ),
    );
    return on ? button : Expanded(child: button);
  }
}
