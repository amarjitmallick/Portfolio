import 'package:flutter/material.dart';

import '../../content/career.dart';
import '../../content/models.dart';
import '../../core/motion/reveal.dart';
import '../../core/motion/scroll_linked.dart';
import '../../core/motion/springs.dart';
import '../../core/responsive/breakpoints.dart';
import '../../core/shapes/m3e_shapes.dart';
import '../../core/theme/tokens.dart';
import '../../core/theme/typography.dart';
import '../../core/widgets/pressable.dart';
import '../../core/widgets/tone.dart';
import 'career_state.dart';

/// One role at a time: connected tabs, an animated panel, Newer / Older.
class CareerSection extends StatefulWidget {
  const CareerSection({super.key});

  @override
  State<CareerSection> createState() => _CareerSectionState();
}

class _CareerSectionState extends State<CareerSection> {
  /// Role whose achievement list is expanded (-1 = none).
  int _expanded = -1;

  List<Role> get _roles => CareerCopy.roles;

  void _pick(int i) => selectedRole.value = i.clamp(0, _roles.length - 1);

  @override
  Widget build(BuildContext context) {
    final w = context.screenWidth;
    final scheme = Theme.of(context).colorScheme;
    final gutter = Space.gutter(w);
    final headingSize = Space.fluid(w, 48, 7.4, 108);
    final heading = AppText.sectionHeading(headingSize, 800);

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1440),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: gutter, vertical: Space.fluid(w, 24, 4, 56)),
          child: ValueListenableBuilder<int>(
            valueListenable: selectedRole,
            builder: (context, index, _) {
              final gap = SizedBox(height: Space.fluid(w, 18, 2.4, 28));
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Reveal(
                    child: Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      crossAxisAlignment: WrapCrossAlignment.end,
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ScrollShape(
                              from: M3Shape.cookie9,
                              to: M3Shape.sunny,
                              color: scheme.tertiaryContainer,
                              size: Space.fluid(w, 56, 7, 104),
                              rotateTo: 240,
                            ),
                            SizedBox(width: Space.fluid(w, 12, 2, 24)),
                            Flexible(
                              child: Semantics(
                                header: true,
                                label: CareerCopy.heading.toString(),
                                child: ExcludeSemantics(
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        ScrollWeightText(CareerCopy.heading.first, style: heading, from: 300, to: 800),
                                        ScrollWeightText(
                                          CareerCopy.heading.second,
                                          style: heading,
                                          from: 800,
                                          to: 200,
                                          color: scheme.primary,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          CareerCopy.subtitle,
                          style: AppText.urbanist(17, 400, height: 1.4).copyWith(color: scheme.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                  gap,
                  Reveal(
                    index: 1,
                    child: _RoleTabs(roles: _roles, selected: index, onPick: _pick),
                  ),
                  gap,
                  SwapReveal(
                    keyValue: 'role$index',
                    child: _RolePanel(
                      role: _roles[index],
                      expanded: _expanded == index,
                      onToggle: () => setState(() => _expanded = _expanded == index ? -1 : index),
                    ),
                  ),
                  gap,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _StepButton(label: 'Newer', back: true, enabled: index > 0, onTap: () => _pick(index - 1)),
                      _StepButton(
                        label: 'Older',
                        back: false,
                        enabled: index < _roles.length - 1,
                        onTap: () => _pick(index + 1),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _RoleTabs extends StatelessWidget {
  const _RoleTabs({required this.roles, required this.selected, required this.onPick});

  final List<Role> roles;
  final int selected;
  final ValueChanged<int> onPick;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final fast = M3Spring.fastSpatial, fx = M3Spring.defaultEffects;
    Widget tab(int i) {
      final on = i == selected;
      final r = roles[i];
      final fg = on ? scheme.onPrimary : scheme.onSurface;
      return Pressable(
        onTap: () => onPick(i),
        selected: on,
        semanticLabel: '${r.short}, ${r.years}',
        focusRadius: BorderRadius.circular(12),
        builder: (context, s) => AnimatedContainer(
          duration: fast.durationOf(context),
          curve: fast.curve,
          height: 68,
          constraints: const BoxConstraints(minWidth: 130),
          padding: const EdgeInsets.symmetric(horizontal: 18),
          decoration: BoxDecoration(
            color: on ? scheme.primary : scheme.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(on || s.pressed ? 34 : 12),
          ),
          foregroundDecoration: BoxDecoration(
            color: s.hovered && !on ? scheme.onSurface.withValues(alpha: .08) : Colors.transparent,
            borderRadius: BorderRadius.circular(on || s.pressed ? 34 : 12),
          ),
          child: AnimatedDefaultTextStyle(
            duration: fx.durationOf(context),
            style: AppText.urbanist(16, on ? 700 : 500, height: 1.15).copyWith(color: fg),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(r.short),
                Text(r.years, style: AppText.urbanist(12, 500).copyWith(color: fg.withValues(alpha: .75))),
              ],
            ),
          ),
        ),
      );
    }

    final fits = context.screenWidth - Space.gutter(context.screenWidth) * 2 >= roles.length * 133;
    if (fits) {
      return Row(
        children: [
          for (var i = 0; i < roles.length; i++) ...[
            if (i > 0) const SizedBox(width: 3),
            Expanded(child: tab(i)),
          ],
        ],
      );
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (var i = 0; i < roles.length; i++) ...[if (i > 0) const SizedBox(width: 3), tab(i)],
        ],
      ),
    );
  }
}

class _RolePanel extends StatelessWidget {
  const _RolePanel({required this.role, required this.expanded, required this.onToggle});

  final Role role;
  final bool expanded;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final w = context.screenWidth;
    final scheme = Theme.of(context).colorScheme;
    final current = role.isCurrent;
    final fg = current ? scheme.onPrimaryContainer : scheme.onSurface;
    final pad = Space.fluid(w, 24, 3.5, 48);
    final inner = w - Space.gutter(w) * 2 - pad * 2;
    final twoUp = inner >= 420 * 2 + Space.fluid(w, 20, 3, 40);
    final all = role.achievements;
    final more = all.length > CareerCopy.collapsedCount;
    final shown = more && !expanded ? all.take(CareerCopy.collapsedCount).toList() : all;

    final left = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(role.duration, style: AppText.manrope(15, 600).copyWith(color: fg.withValues(alpha: .8))),
        const SizedBox(height: 12),
        Text(role.position, style: AppText.urbanist(Space.fluid(w, 34, 4.4, 60), 800, height: 1.02, tracking: -.03)),
        const SizedBox(height: 12),
        Text(
          role.company,
          style: AppText.urbanist(Space.fluid(w, 20, 2, 26), 600).copyWith(color: current ? fg : scheme.primary),
        ),
        if (role.metrics.isNotEmpty) ...[
          const SizedBox(height: 20),
          Wrap(spacing: 12, runSpacing: 12, children: [for (final m in role.metrics) _MetricBadge(metric: m)]),
        ],
      ],
    );

    final right = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(CareerCopy.achievementsLabel, style: AppText.eyebrow().copyWith(color: fg.withValues(alpha: .8))),
        const SizedBox(height: 12),
        Semantics(
          container: true,
          label: 'List, ${all.length} items',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var i = 0; i < shown.length; i++)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: SwapReveal(
                    keyValue: '${role.company}-$i',
                    index: i % 4,
                    child: _Achievement(item: shown[i]),
                  ),
                ),
            ],
          ),
        ),
        if (more) _MoreButton(expanded: expanded, count: all.length - CareerCopy.collapsedCount, onTap: onToggle),
      ],
    );

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: current ? scheme.primaryContainer : scheme.surfaceContainer,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Stack(
        children: [
          if (current)
            Positioned(
              right: -90,
              bottom: -90,
              child: ExcludeSemantics(
                child: Opacity(
                  opacity: .22,
                  child: ShapeBox(shape: M3Shape.sunny, size: 420, color: scheme.primary),
                ),
              ),
            ),
          Padding(
            padding: EdgeInsets.all(pad),
            child: DefaultTextStyle.merge(
              style: TextStyle(color: fg),
              child: twoUp
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: left),
                        SizedBox(width: Space.fluid(w, 20, 3, 40)),
                        Expanded(child: right),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        left,
                        SizedBox(height: Space.fluid(w, 20, 3, 40)),
                        right,
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricBadge extends StatefulWidget {
  const _MetricBadge({required this.metric});
  final Metric metric;

  @override
  State<_MetricBadge> createState() => _MetricBadgeState();
}

class _MetricBadgeState extends State<_MetricBadge> {
  bool _h = false;

  @override
  Widget build(BuildContext context) {
    final w = context.screenWidth;
    final tone = toneColors(Theme.of(context).colorScheme, widget.metric.tone);
    return MouseRegion(
      onEnter: (_) => setState(() => _h = true),
      onExit: (_) => setState(() => _h = false),
      child: ShapeBox(
        shape: _h ? M3Shape.circle : M3Shape.byName(widget.metric.shape),
        rotation: _h ? -10 / 360 : 0,
        spring: M3Spring.defaultSpatial,
        size: Space.fluid(w, 100, 10, 140),
        color: tone.bg,
        child: Text(
          widget.metric.value,
          style: AppText.urbanist(Space.fluid(w, 28, 3, 40), 800).copyWith(color: tone.fg),
        ),
      ),
    );
  }
}

class _Achievement extends StatefulWidget {
  const _Achievement({required this.item});
  final Achievement item;

  @override
  State<_Achievement> createState() => _AchievementState();
}

class _AchievementState extends State<_Achievement> {
  bool _h = false;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final def = M3Spring.defaultSpatial;
    final base = AppText.urbanist(16, 400, height: 1.5).copyWith(color: scheme.onSurface);
    return MouseRegion(
      onEnter: (_) => setState(() => _h = true),
      onExit: (_) => setState(() => _h = false),
      child: AnimatedContainer(
        duration: def.durationOf(context),
        curve: def.curve,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          color: scheme.surface,
          borderRadius: _h
              ? const BorderRadius.only(
                  topLeft: Radius.circular(6),
                  topRight: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                  bottomLeft: Radius.circular(24),
                )
              : const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                  bottomLeft: Radius.circular(6),
                ),
        ),
        child: Text.rich(
          TextSpan(
            children: [
              if (widget.item.lead != null)
                TextSpan(text: '${widget.item.lead} ', style: AppText.withWeight(base, 800)),
              TextSpan(text: widget.item.text),
            ],
          ),
          style: base,
        ),
      ),
    );
  }
}

class _MoreButton extends StatelessWidget {
  const _MoreButton({required this.expanded, required this.count, required this.onTap});

  final bool expanded;
  final int count;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final fast = M3Spring.fastSpatial, def = M3Spring.defaultSpatial;
    return Semantics(
      expanded: expanded,
      child: Pressable(
        onTap: onTap,
        focusRadius: BorderRadius.circular(24),
        builder: (context, s) => AnimatedScale(
          scale: s.pressed ? .96 : 1,
          duration: fast.durationOf(context),
          curve: fast.curve,
          child: AnimatedContainer(
            duration: fast.durationOf(context),
            curve: fast.curve,
            height: 48,
            padding: const EdgeInsets.only(left: 14, right: 20),
            decoration: BoxDecoration(color: scheme.surface, borderRadius: BorderRadius.circular(s.hovered ? 12 : 24)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedRotation(
                  turns: expanded ? .5 : 0,
                  duration: def.durationOf(context),
                  curve: def.curve,
                  child: Icon(Icons.expand_more_rounded, size: 22, color: scheme.onSurface),
                ),
                const SizedBox(width: 6),
                Text(
                  expanded ? 'Show less' : 'Show $count more',
                  style: AppText.urbanist(15, 700).copyWith(color: scheme.onSurface),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StepButton extends StatelessWidget {
  const _StepButton({required this.label, required this.back, required this.enabled, required this.onTap});

  final String label;
  final bool back;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final fast = M3Spring.fastSpatial;
    final icon = Icon(back ? Icons.arrow_back_rounded : Icons.arrow_forward_rounded, size: 22, color: scheme.onSurface);
    final text = Text(label, style: AppText.urbanist(15, 600).copyWith(color: scheme.onSurface));
    return Pressable(
      onTap: onTap,
      enabled: enabled,
      focusRadius: BorderRadius.circular(26),
      builder: (context, s) => AnimatedOpacity(
        opacity: enabled ? 1 : .38,
        duration: M3Spring.defaultEffects.durationOf(context),
        child: AnimatedContainer(
          duration: fast.durationOf(context),
          curve: fast.curve,
          height: 52,
          padding: EdgeInsets.only(left: back ? 14 : 20, right: back ? 20 : 14),
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(s.pressed ? 12 : 26),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: back ? [icon, const SizedBox(width: 6), text] : [text, const SizedBox(width: 6), icon],
          ),
        ),
      ),
    );
  }
}
