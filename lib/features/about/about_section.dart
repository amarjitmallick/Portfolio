import 'dart:async';

import 'package:flutter/material.dart';

import '../../content/about.dart';
import '../../content/identity.dart';
import '../../content/microcopy.dart';
import '../../content/models.dart';
import '../../core/motion/reveal.dart';
import '../../core/motion/scroll_linked.dart';
import '../../core/motion/springs.dart';
import '../../core/responsive/breakpoints.dart';
import '../../core/shapes/m3e_shapes.dart';
import '../../core/theme/tokens.dart';
import '../../core/theme/typography.dart';
import '../../core/widgets/copy_action.dart';
import '../../core/widgets/external_link.dart';
import '../../core/widgets/pressable.dart';

/// Shapes the portrait cycles through on each "setState()".
const _photoShapes = [
  M3Shape.cookie9,
  M3Shape.clover4,
  M3Shape.sunny,
  M3Shape.cookie4,
  M3Shape.sunny,
  M3Shape.circle,
  M3Shape.clover4,
  M3Shape.cookie6,
];

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final w = context.screenWidth;
    final scheme = Theme.of(context).colorScheme;
    final gutter = Space.gutter(w);
    final inner = w.clamp(0, 1440) - gutter * 2;
    final heading = AppText.urbanist(Space.fluid(w, 56, 9, 128), 800, height: .92, tracking: -.05);
    final twoUp = inner >= 440 * 2 + Space.fluid(w, 14, 2, 24);
    final gap = Space.fluid(w, 14, 2, 24);

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1440),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: gutter, vertical: Space.fluid(w, 24, 4, 56)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Reveal(
                child: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.end,
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    Semantics(
                      header: true,
                      label: AboutCopy.heading.toString(),
                      child: ExcludeSemantics(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ScrollWeightText(AboutCopy.heading.first, style: heading, from: 300, to: 800),
                              ScrollWeightText(
                                AboutCopy.heading.second,
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
                  ],
                ),
              ),
              SizedBox(height: Space.fluid(w, 20, 3, 32)),
              if (twoUp)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(child: _AboutMe()),
                    SizedBox(width: gap),
                    const Expanded(child: Reveal(index: 3, child: _AboutMeState())),
                  ],
                )
              else ...[
                const _AboutMe(),
                SizedBox(height: gap),
                const Reveal(index: 3, child: _AboutMeState()),
              ],
              SizedBox(height: Space.fluid(w, 24, 4, 56)),
              _Pubspec(key: const ValueKey('skills'), width: inner),
            ],
          ),
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip(this.text, {this.filled = false});
  final String text;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: filled ? scheme.primary : null,
        border: filled ? null : Border.all(color: scheme.outline, width: 1.5),
        borderRadius: BorderRadius.circular(99),
      ),
      child: Text(text, style: AppText.manrope(13, 600).copyWith(color: filled ? scheme.onPrimary : scheme.onSurface)),
    );
  }
}

/// The README: title, "What I do" and the facts that don't change.
class _AboutMe extends StatelessWidget {
  const _AboutMe();

  @override
  Widget build(BuildContext context) {
    final w = context.screenWidth;
    final scheme = Theme.of(context).colorScheme;
    final care = AppText.urbanist(
      Space.fluid(w, 26, 3.2, 44),
      400,
      height: 1.15,
      tracking: -.02,
    ).copyWith(color: scheme.onSurface);
    const r28 = Radius.circular(28), r6 = Radius.circular(6);
    final cells = <(InfoRow, BorderRadius)>[
      (AboutCopy.info[0], const BorderRadius.only(topLeft: r28, topRight: r6, bottomLeft: r6, bottomRight: r6)),
      (AboutCopy.info[1], const BorderRadius.only(topLeft: r6, topRight: r28, bottomLeft: r6, bottomRight: r6)),
      (AboutCopy.info[2], const BorderRadius.only(topLeft: r6, topRight: r6, bottomLeft: r28, bottomRight: r6)),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Reveal(index: 1, child: _Chip(AboutCopy.fileName)),
        const SizedBox(height: 22),
        Reveal(
          index: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AboutCopy.readmeTitle, style: AppText.withWeight(care, 800).copyWith(color: scheme.primary)),
              const SizedBox(height: 10),
              Text(AboutCopy.whatIDo, style: care),
            ],
          ),
        ),
        const SizedBox(height: 22),
        Reveal(
          index: 3,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: _InfoCell(row: cells[0].$1, radius: cells[0].$2),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: _InfoCell(row: cells[1].$1, radius: cells[1].$2),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: _InfoCell(row: cells[2].$1, radius: cells[2].$2),
                    ),
                    const SizedBox(width: 4),
                    const Expanded(child: _EmailCell()),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 22),
        Reveal(
          index: 4,
          child: Wrap(spacing: 6, runSpacing: 6, children: [for (final s in Identity.socials) SocialPill(link: s)]),
        ),
      ],
    );
  }
}

class _InfoCell extends StatelessWidget {
  const _InfoCell({required this.row, required this.radius});
  final InfoRow row;
  final BorderRadius radius;

  @override
  Widget build(BuildContext context) {
    final w = context.screenWidth;
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(color: scheme.surfaceContainer, borderRadius: radius),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(row.label, style: AppText.urbanist(13, 500).copyWith(color: scheme.onSurfaceVariant)),
          Text(row.value, style: AppText.urbanist(Space.fluid(w, 17, 1.6, 21), 700).copyWith(color: scheme.onSurface)),
        ],
      ),
    );
  }
}

class _EmailCell extends StatelessWidget {
  const _EmailCell();

  @override
  Widget build(BuildContext context) {
    final w = context.screenWidth;
    final scheme = Theme.of(context).colorScheme;
    final fast = M3Spring.fastSpatial;
    const rest = BorderRadius.only(
      topLeft: Radius.circular(6),
      topRight: Radius.circular(6),
      bottomLeft: Radius.circular(6),
      bottomRight: Radius.circular(28),
    );
    return CopyAction(
      text: Identity.email,
      semanticLabel: 'Email ${Identity.email}, tap to copy',
      focusRadius: rest,
      builder: (context, s, copied) => AnimatedContainer(
        duration: fast.durationOf(context),
        curve: fast.curve,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          color: scheme.primaryContainer,
          borderRadius: s.hovered ? BorderRadius.circular(28) : rest,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.content_copy_rounded, size: 16, color: scheme.onPrimaryContainer),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    copied ? Microcopy.copied : 'Email · tap to copy',
                    style: AppText.urbanist(13, 500).copyWith(color: scheme.onPrimaryContainer),
                  ),
                ),
              ],
            ),
            Text(
              Identity.email,
              style: AppText.urbanist(Space.fluid(w, 15, 1.4, 19), 700).copyWith(color: scheme.onPrimaryContainer),
            ),
          ],
        ),
      ),
    );
  }
}

/// LinkedIn / GitHub / X pill, used in About and Contact.
class SocialPill extends StatelessWidget {
  const SocialPill({
    super.key,
    required this.link,
    this.height = 44,
    this.radius = 12,
    this.fontSize = 14,
    this.background,
  });

  final SocialLink link;

  /// Defaults to surfaceContainerHigh.
  final Color? background;
  final double height;
  final double radius;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final fast = M3Spring.fastSpatial;
    return Pressable(
      onTap: () => openExternal(link.url),
      isLink: true,
      semanticLabel: '${link.label} (opens in a new tab)',
      tooltip: link.label,
      focusRadius: BorderRadius.circular(radius),
      builder: (context, s) {
        final fg = s.hovered ? scheme.primary : scheme.onSurface;
        return AnimatedContainer(
          duration: fast.durationOf(context),
          curve: fast.curve,
          height: height,
          constraints: const BoxConstraints(minWidth: 48),
          padding: const EdgeInsets.symmetric(horizontal: 18),
          decoration: BoxDecoration(
            color: background ?? scheme.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(s.hovered ? height / 2 : radius),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(link.label, style: AppText.urbanist(fontSize, 700).copyWith(color: fg)),
              const SizedBox(width: 6),
              Icon(Icons.north_east_rounded, size: 16, color: fg),
            ],
          ),
        );
      },
    );
  }
}

/// "class _AboutMeState extends State": the counter easter egg, what I'm
/// doing now and the README sections as tabs.
class _AboutMeState extends StatefulWidget {
  const _AboutMeState();

  @override
  State<_AboutMeState> createState() => _AboutMeStateState();
}

class _AboutMeStateState extends State<_AboutMeState> {
  int _count = 0;
  int _tab = 0;
  bool _pop = false;
  Timer? _popTimer;

  void _rebuild() {
    _popTimer?.cancel();
    setState(() {
      _count++;
      _pop = true;
    });
    _popTimer = Timer(const Duration(milliseconds: 120), () => mounted ? setState(() => _pop = false) : null);
  }

  @override
  void dispose() {
    _popTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = context.screenWidth;
    final scheme = Theme.of(context).colorScheme;
    final fast = M3Spring.fastSpatial;
    final photo = Space.fluid(w, 120, 14, 190);
    final tabs = AboutCopy.sections;
    final tab = tabs[_tab];
    final para = AppText.urbanist(17, 400, height: 1.6).copyWith(color: scheme.onSurfaceVariant);

    return Container(
      padding: EdgeInsets.all(Space.fluid(w, 20, 3, 40)),
      decoration: BoxDecoration(color: scheme.surfaceContainer, borderRadius: BorderRadius.circular(40)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Align(alignment: Alignment.centerLeft, child: _Chip('class _AboutMeState extends State', filled: true)),
          const SizedBox(height: 20),
          Wrap(
            spacing: 18,
            runSpacing: 18,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Pressable(
                onTap: _rebuild,
                onSecondaryTap: () => setState(() => _count = 0),
                semanticLabel: 'setState(), increments the counter',
                tooltip: 'setState() · right-click to reset',
                focusRadius: BorderRadius.circular(photo / 2),
                builder: (context, s) => AnimatedScale(
                  scale: s.pressed ? .92 : 1,
                  duration: fast.durationOf(context),
                  curve: fast.curve,
                  child: ShapeBox(
                    shape: _photoShapes[_count % _photoShapes.length],
                    size: photo,
                    clip: true,
                    child: Image.asset(
                      'assets/images/profile.jpg',
                      fit: BoxFit.cover,
                      semanticLabel: Identity.name,
                      cacheWidth: (photo * MediaQuery.devicePixelRatioOf(context)).round(),
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 220),
                    child: Text(
                      'You have pushed the button this many times:',
                      style: AppText.urbanist(14, 500, height: 1.4).copyWith(color: scheme.onSurfaceVariant),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Semantics(
                    liveRegion: true,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        AnimatedScale(
                          scale: _pop ? 1.35 : 1,
                          duration: fast.durationOf(context),
                          curve: fast.curve,
                          child: Text(
                            '$_count',
                            style: AppText.urbanist(
                              Space.fluid(w, 48, 5, 68),
                              800,
                              height: 1,
                              tracking: -.03,
                            ).copyWith(color: scheme.onSurface),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          _count == 1 ? 'rebuild' : 'rebuilds',
                          style: AppText.urbanist(17, 400).copyWith(color: scheme.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: scheme.surface, borderRadius: BorderRadius.circular(24)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AboutCopy.currentlyLabel, style: AppText.manrope(13, 600).copyWith(color: scheme.primary)),
                const SizedBox(height: 4),
                Text(
                  AboutCopy.currentlyLead,
                  style: AppText.urbanist(
                    Space.fluid(w, 20, 2, 26),
                    700,
                    height: 1.15,
                  ).copyWith(color: scheme.onSurface),
                ),
                const SizedBox(height: 4),
                Text(
                  AboutCopy.currentlyRest,
                  style: AppText.urbanist(16, 400).copyWith(color: scheme.onSurfaceVariant),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              for (var i = 0; i < tabs.length; i++) ...[
                if (i > 0) const SizedBox(width: 3),
                Expanded(
                  child: _TabButton(label: tabs[i].title, selected: i == _tab, onTap: () => setState(() => _tab = i)),
                ),
              ],
            ],
          ),
          const SizedBox(height: 20),
          SwapReveal(
            keyValue: 'about$_tab',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('## ${tab.title}', style: AppText.withWeight(para, 700).copyWith(color: scheme.onSurface)),
                for (var i = 0; i < tab.lines.length; i++)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (tab.numbered)
                          SizedBox(
                            width: 26,
                            child: Text('${i + 1}.', style: AppText.withWeight(para, 700).copyWith(color: scheme.primary)),
                          ),
                        Expanded(child: Text(tab.lines[i], style: para)),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  const _TabButton({required this.label, required this.selected, required this.onTap});

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final fast = M3Spring.fastSpatial;
    final fg = selected ? scheme.onPrimary : scheme.onSurface;
    return Pressable(
      onTap: onTap,
      selected: selected,
      focusRadius: BorderRadius.circular(10),
      builder: (context, s) => AnimatedContainer(
        duration: fast.durationOf(context),
        curve: fast.curve,
        constraints: const BoxConstraints(minHeight: 48),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? scheme.primary : scheme.surface,
          borderRadius: BorderRadius.circular(selected || s.pressed ? 24 : 10),
        ),
        foregroundDecoration: BoxDecoration(
          color: s.hovered && !selected ? scheme.onSurface.withValues(alpha: .08) : Colors.transparent,
          borderRadius: BorderRadius.circular(selected || s.pressed ? 24 : 10),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          maxLines: 2,
          style: AppText.urbanist(15, 600).copyWith(color: fg),
        ),
      ),
    );
  }
}

/// Skills rendered as a pubspec.yaml: "pub get" replays the list, "sort"
/// flattens it A–Z.
class _Pubspec extends StatefulWidget {
  const _Pubspec({super.key, required this.width});
  final double width;

  @override
  State<_Pubspec> createState() => _PubspecState();
}

class _PubspecState extends State<_Pubspec> {
  int _run = 0;
  bool _getting = false;
  bool _sorted = false;
  Timer? _t;

  void _pubGet() {
    _t?.cancel();
    setState(() {
      _run++;
      _getting = true;
    });
    _t = Timer(const Duration(milliseconds: 1100), () => mounted ? setState(() => _getting = false) : null);
  }

  @override
  void dispose() {
    _t?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = context.screenWidth;
    final scheme = Theme.of(context).colorScheme;
    final twoUp = widget.width >= 340 * 2;
    final groups = _sorted
        ? [
            SkillGroup(
              '# all dependencies, A–Z',
              'Every skill, sorted A–Z',
              [for (final g in AboutCopy.skills) ...g.skills]
                ..sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase())),
            ),
          ]
        : AboutCopy.skills;
    final status = _getting ? Microcopy.loading : (_sorted ? 'Sorted A–Z' : 'Got dependencies!');

    final intro = Reveal(
      child: Container(
        constraints: const BoxConstraints(minHeight: 280),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(color: scheme.primaryContainer),
        child: Stack(
          children: [
            Positioned(
              right: -100,
              bottom: -100,
              child: ExcludeSemantics(
                child: Opacity(
                  opacity: .22,
                  child: ScrollShape(
                    from: M3Shape.clover4,
                    to: M3Shape.cookie9,
                    color: scheme.primary,
                    size: 360,
                    rotateTo: 120,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(Space.fluid(w, 24, 3, 44)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Skills', style: AppText.urbanist(16, 600).copyWith(color: scheme.onPrimaryContainer)),
                  const SizedBox(height: 16),
                  Semantics(
                    header: true,
                    child: Text(
                      'pubspec\n.yaml',
                      style: AppText.urbanist(
                        Space.fluid(w, 52, 6, 84),
                        800,
                        height: .88,
                        tracking: -.04,
                      ).copyWith(color: scheme.onPrimaryContainer),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    AboutCopy.skillsHint,
                    style: AppText.urbanist(16, 400, height: 1.5).copyWith(color: scheme.onPrimaryContainer),
                  ),
                  const SizedBox(height: 32),
                  Wrap(
                    spacing: 14,
                    runSpacing: 10,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _SplitHalf(
                            onTap: _pubGet,
                            left: true,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.download_rounded, size: 20, color: scheme.onPrimary),
                                const SizedBox(width: 8),
                                Text('pub get', style: AppText.urbanist(16, 700).copyWith(color: scheme.onPrimary)),
                              ],
                            ),
                          ),
                          const SizedBox(width: 2),
                          _SplitHalf(
                            onTap: () => setState(() {
                              _sorted = !_sorted;
                              _run++;
                            }),
                            left: false,
                            tooltip: _sorted ? 'Group by how I work' : 'Sort A–Z',
                            child: Icon(Icons.sort_rounded, size: 22, color: scheme.onPrimary),
                          ),
                        ],
                      ),
                      Semantics(
                        liveRegion: true,
                        child: Text(status, style: AppText.manrope(14, 600).copyWith(color: scheme.onPrimaryContainer)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    final deps = Padding(
      padding: EdgeInsets.all(Space.fluid(w, 20, 3, 40)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text('dependencies:', style: AppText.manrope(15, 500).copyWith(color: scheme.onSurfaceVariant)),
          ),
          for (var i = 0; i < groups.length; i++) ...[
            if (groups[i].dev && (i == 0 || !groups[i - 1].dev))
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 6),
                child: Text(
                  'dev_dependencies:',
                  style: AppText.manrope(15, 500).copyWith(color: scheme.onSurfaceVariant),
                ),
              ),
            SwapReveal(
              keyValue: 'pub$_run-$i',
              index: i,
              child: Container(
                padding: const EdgeInsets.only(top: 14, bottom: 16),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: scheme.outlineVariant)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _GroupKey(group: groups[i], sorted: _sorted),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 20,
                      runSpacing: 4,
                      children: [for (final d in groups[i].skills) _Dep(name: d)],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );

    return Semantics(
      container: true,
      label: 'Skills',
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(color: scheme.surfaceContainerLow, borderRadius: BorderRadius.circular(40)),
        child: twoUp
            ? IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(child: intro),
                    Expanded(child: deps),
                  ],
                ),
              )
            : Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [intro, deps]),
      ),
    );
  }
}

class _SplitHalf extends StatelessWidget {
  const _SplitHalf({required this.onTap, required this.left, required this.child, this.tooltip});

  final VoidCallback onTap;
  final bool left;
  final Widget child;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final fast = M3Spring.fastSpatial;
    final rest = left
        ? const BorderRadius.horizontal(left: Radius.circular(28), right: Radius.circular(8))
        : const BorderRadius.horizontal(left: Radius.circular(8), right: Radius.circular(28));
    return Pressable(
      onTap: onTap,
      tooltip: tooltip,
      semanticLabel: tooltip,
      focusRadius: rest,
      builder: (context, s) => AnimatedContainer(
        duration: fast.durationOf(context),
        curve: fast.curve,
        height: 56,
        width: left ? null : 56,
        padding: left ? const EdgeInsets.symmetric(horizontal: 22) : null,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: scheme.primary,
          borderRadius: s.pressed && left
              ? BorderRadius.circular(14)
              : (s.hovered && !left ? BorderRadius.circular(28) : rest),
        ),
        child: child,
      ),
    );
  }
}

/// A pubspec key (`work_offline:`); hover or tap shows the plain reading.
class _GroupKey extends StatelessWidget {
  const _GroupKey({required this.group, required this.sorted});
  final SkillGroup group;
  final bool sorted;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final style = AppText.manrope(14, 600).copyWith(color: scheme.primary);
    if (sorted) return Text(group.key, style: style);
    return Tooltip(
      message: group.label,
      triggerMode: TooltipTriggerMode.tap,
      child: Text('${group.key}:', style: style),
    );
  }
}

class _Dep extends StatefulWidget {
  const _Dep({required this.name});
  final String name;

  @override
  State<_Dep> createState() => _DepState();
}

class _DepState extends State<_Dep> {
  bool _h = false;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final size = Space.fluid(context.screenWidth, 22, 2.3, 32);
    return MouseRegion(
      onEnter: (_) => setState(() => _h = true),
      onExit: (_) => setState(() => _h = false),
      child: TweenAnimationBuilder<double>(
        tween: Tween(end: _h ? 800 : 400),
        duration: M3Spring.defaultSpatial.durationOf(context),
        curve: Curves.easeOut,
        builder: (context, wght, _) => Text(
          widget.name,
          style: AppText.urbanist(
            size,
            (wght / 25).round() * 25.0,
            height: 1.15,
            tracking: -.02,
          ).copyWith(color: _h ? scheme.primary : scheme.onSurface),
        ),
      ),
    );
  }
}
