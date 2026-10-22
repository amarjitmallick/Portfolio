import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../../content/career.dart';
import '../../../content/models.dart';
import '../../../content/projects.dart';
import '../../../core/motion/reveal.dart';
import '../../../core/motion/springs.dart';
import '../../../core/responsive/breakpoints.dart';
import '../../../core/shapes/m3e_shapes.dart';
import '../../../core/theme/theme_controller.dart';
import '../../../core/theme/tokens.dart';
import '../../../core/theme/typography.dart';
import '../../../core/widgets/copy_action.dart';
import '../../../core/widgets/external_link.dart';
import '../../../core/widgets/pressable.dart';
import '../../career/career_state.dart';
import '../parts.dart';

const _specimenShapes = [M3Shape.clover4, M3Shape.cookie9, M3Shape.sunny];

/// Full-screen project detail, stacked over the page at /work/:slug.
class ProjectDetailPage extends StatefulWidget {
  const ProjectDetailPage({super.key, required this.project});

  final Project project;

  static Page<void> page(String slug) {
    final project = WorkCopy.bySlug(slug)!;
    return CustomTransitionPage<void>(
      key: ValueKey('detail-$slug'),
      name: project.displayTitle,
      // Keep the page underneath laid out: an offstage page breaks its
      // SelectionArea. The detail Scaffold covers it fully anyway.
      opaque: false,
      child: ProjectDetailPage(project: project),
      transitionDuration: M3Spring.defaultSpatial.duration,
      reverseTransitionDuration: M3Spring.defaultEffects.duration,
      transitionsBuilder: (context, animation, _, child) {
        if (context.reduceMotion) return child;
        final fade = CurvedAnimation(parent: animation, curve: M3Spring.defaultEffects.curve);
        final rise = CurvedAnimation(parent: animation, curve: M3Spring.defaultSpatial.curve);
        return FadeTransition(
          opacity: fade,
          child: AnimatedBuilder(
            animation: rise,
            child: child,
            builder: (context, child) => Transform.translate(offset: Offset(0, 32 * (1 - rise.value)), child: child),
          ),
        );
      },
    );
  }

  @override
  State<ProjectDetailPage> createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
  final ScrollController _scroll = ScrollController();
  final ValueNotifier<double> _progress = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    _scroll.addListener(() {
      if (!_scroll.hasClients) return;
      final max = _scroll.position.maxScrollExtent;
      _progress.value = max <= 0 ? 0 : ((_scroll.offset / max) * 40).round() / 40;
    });
  }

  @override
  void dispose() {
    _scroll.dispose();
    _progress.dispose();
    super.dispose();
  }

  void _back() => context.go('/work');

  @override
  Widget build(BuildContext context) {
    final w = context.screenWidth;
    final h = MediaQuery.sizeOf(context).height;
    final scheme = Theme.of(context).colorScheme;
    final twoCol = w >= Breakpoints.detailTwoColumn;
    final p = widget.project;

    final hero = _Hero(project: p, progress: _progress, onBack: _back, twoColumn: twoCol);
    final content = _Content(project: p);

    return CallbackShortcuts(
      bindings: {const SingleActivator(LogicalKeyboardKey.escape): _back},
      child: Focus(
        autofocus: true,
        child: Scaffold(
          backgroundColor: scheme.surface,
          body: Semantics(
            scopesRoute: true,
            namesRoute: true,
            label: 'Project detail: ${p.displayTitle}',
            explicitChildNodes: true,
            child: SelectionArea(
              child: twoCol
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: SizedBox(height: h, child: hero),
                        ),
                        Expanded(
                          child: SingleChildScrollView(controller: _scroll, child: content),
                        ),
                      ],
                    )
                  : SingleChildScrollView(
                      controller: _scroll,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: (h * .62).clamp(420, 640), child: hero),
                          content,
                        ],
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Hero extends StatefulWidget {
  const _Hero({required this.project, required this.progress, required this.onBack, required this.twoColumn});

  final Project project;
  final ValueListenable<double> progress;
  final VoidCallback onBack;
  final bool twoColumn;

  @override
  State<_Hero> createState() => _HeroState();
}

class _HeroState extends State<_Hero> {
  final ValueNotifier<Offset> _tilt = ValueNotifier(Offset.zero);
  bool _hover = false;

  @override
  void dispose() {
    _tilt.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = context.screenWidth;
    final scheme = Theme.of(context).colorScheme;
    final p = widget.project;
    final colors = projectColors(scheme, p);
    final step = ThemeScope.of(context).seedIndex;
    final reduce = context.reduceMotion;
    final specimen = Space.fluid(w, 220, 30, 440);
    final titleSize = Space.fluid(w, 44, 5.6, 96);
    final fast = M3Spring.fastSpatial;

    return MouseRegion(
      onHover: (e) {
        if (e.kind != PointerDeviceKind.mouse || reduce) return;
        final size = (context.findRenderObject() as RenderBox).size;
        _tilt.value = Offset(e.localPosition.dx / size.width * 2 - 1, e.localPosition.dy / size.height * 2 - 1);
      },
      onExit: (_) => _tilt.value = Offset.zero,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: scheme.primaryContainer,
          borderRadius: widget.twoColumn
              ? const BorderRadius.only(topRight: Radius.circular(120))
              : const BorderRadius.only(bottomRight: Radius.circular(96)),
        ),
        child: LayoutBuilder(
          builder: (context, c) => ValueListenableBuilder<Offset>(
            valueListenable: _tilt,
            builder: (context, t, _) => ValueListenableBuilder<double>(
              valueListenable: widget.progress,
              builder: (context, prog, _) {
                final pr = reduce ? 0.0 : prog;
                return Stack(
                  children: [
                    // Decorative shapes.
                    Positioned(
                      right: -c.maxWidth * .18 - t.dx * 18,
                      bottom: -c.maxHeight * .22 - t.dy * 18,
                      width: c.maxWidth * .7,
                      height: c.maxWidth * .7,
                      child: ExcludeSemantics(
                        child: Opacity(
                          opacity: .18,
                          child: CustomPaint(
                            painter: ScrollMorphPainter(
                              from: M3Shape.cookie7,
                              to: M3Shape.sunny,
                              t: pr,
                              rotation: 140 * pr / 360,
                              color: scheme.primary,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: -c.maxWidth * .1 + t.dx * 28,
                      top: c.maxHeight * .12 + t.dy * 28,
                      width: c.maxWidth * .26,
                      height: c.maxWidth * .26,
                      child: ExcludeSemantics(
                        child: Opacity(
                          opacity: .08,
                          child: CustomPaint(
                            painter: ScrollMorphPainter(
                              from: M3Shape.clover4,
                              to: M3Shape.clover4,
                              t: 0,
                              rotation: -120 * pr / 360,
                              color: scheme.onPrimaryContainer,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Specimen.
                    Positioned(
                      left: c.maxWidth / 2 - specimen / 2,
                      top: c.maxHeight * .44 - specimen / 2,
                      width: specimen,
                      height: specimen,
                      child: Reveal(
                        index: 1,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Positioned(
                              left: -specimen * .1 - t.dx * 14,
                              top: -specimen * .1 - t.dy * 14,
                              width: specimen * 1.2,
                              height: specimen * 1.2,
                              child: ExcludeSemantics(
                                child: ShapeBox(
                                  shape: M3Shape.clover4,
                                  color: scheme.onPrimaryContainer.withValues(alpha: .1),
                                ),
                              ),
                            ),
                            Positioned.fill(
                              child: MouseRegion(
                                onEnter: (_) => setState(() => _hover = true),
                                onExit: (_) => setState(() => _hover = false),
                                child: Transform(
                                  alignment: Alignment.center,
                                  transform: Matrix4.identity()
                                    ..setEntry(3, 2, 1 / 900)
                                    ..rotateX(t.dy * -10 * 3.14159 / 180)
                                    ..rotateY(t.dx * 12 * 3.14159 / 180)
                                    ..scaleByDouble(1.06 - .2 * pr, 1.06 - .2 * pr, 1, 1),
                                  child: ShapeBox(
                                    shape: _hover ? M3Shape.cookie9 : _specimenShapes[step % _specimenShapes.length],
                                    color: colors.bg,
                                    child: ProjectArt(project: p, iconSize: Space.fluid(w, 90, 11, 160), fraction: .7),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Title (weight thins as you scroll).
                    Positioned(
                      left: Space.fluid(w, 18, 3, 48),
                      right: 16,
                      bottom: Space.fluid(w, 18, 3, 44),
                      child: Reveal(
                        index: 2,
                        child: Semantics(
                          header: true,
                          child: ProjectTitle(
                            project: p,
                            barWidthEm: 3.6,
                            ink: scheme.onPrimaryContainer,
                            style: AppText.withWeight(
                              AppText.urbanist(titleSize, 800, height: .9, tracking: -.05),
                              ((800 - 500 * pr) / 25).round() * 25.0,
                            ).copyWith(color: scheme.onPrimaryContainer),
                          ),
                        ),
                      ),
                    ),
                    // Back.
                    Positioned(
                      left: Space.fluid(w, 16, 2.4, 32),
                      top: Space.fluid(w, 16, 2.4, 32),
                      child: Pressable(
                        onTap: widget.onBack,
                        semanticLabel: 'Back to catalog',
                        tooltip: 'Back to catalog',
                        focusRadius: BorderRadius.circular(28),
                        builder: (context, s) => AnimatedScale(
                          scale: s.pressed ? .92 : (s.hovered ? 1.06 : 1),
                          duration: fast.durationOf(context),
                          curve: fast.curve,
                          child: AnimatedContainer(
                            duration: fast.durationOf(context),
                            curve: fast.curve,
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              color: scheme.surface,
                              borderRadius: BorderRadius.circular(s.pressed ? 14 : (s.hovered ? 18 : 28)),
                            ),
                            child: Icon(Icons.arrow_back_rounded, size: 24, color: scheme.onSurface),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    final w = context.screenWidth;
    final scheme = Theme.of(context).colorScheme;
    final p = project;
    final pad = Space.fluid(w, 22, 4, 56);
    final contentWidth = (w >= Breakpoints.detailTwoColumn ? w / 2 : w) - pad * 2;
    final eyebrow = AppText.eyebrow().copyWith(color: scheme.onSurfaceVariant);
    final projects = WorkCopy.projects;
    final next = projects[(projects.indexOf(p) + 1) % projects.length];
    final role = p.builtAtRole == null ? null : CareerCopy.roles[p.builtAtRole!];

    final children = <Widget>[
      Reveal(
        index: 1,
        child: Text(p.meta, style: AppText.manrope(14, 600).copyWith(color: scheme.onSurfaceVariant)),
      ),
      const SizedBox(height: 14),
      Reveal(
        index: 2,
        child: Text(
          p.commitTitle,
          style: AppText.manrope(Space.fluid(w, 18, 1.8, 24), 600, height: 1.4).copyWith(color: scheme.onSurface),
        ),
      ),
      const SizedBox(height: 26),
      Reveal(
        index: 3,
        child: ConstraintOutcome(project: p, width: contentWidth),
      ),
      if (p.approach.isNotEmpty) ...[
        const SizedBox(height: 26),
        Reveal(
          index: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(WorkCopy.approachLabel, style: eyebrow),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: scheme.outlineVariant)),
                ),
                child: Column(children: [for (final f in p.approach) _Fact(text: f)]),
              ),
            ],
          ),
        ),
      ],
      const SizedBox(height: 26),
      Reveal(
        index: 4,
        child: Container(
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: scheme.outlineVariant)),
          ),
          child: Column(
            children: [
              _Row(
                label: 'stack',
                child: Wrap(spacing: 6, runSpacing: 6, children: [for (final t in p.stack) _DetailChip(name: t)]),
              ),
              if (role != null)
                _Row(
                  label: 'built at',
                  child: _TextLink(
                    label: '${role.company} · ${role.position}${role.isCurrent ? '' : ' · ${role.duration}'} →',
                    onTap: () {
                      selectedRole.value = p.builtAtRole!;
                      context.go('/career');
                    },
                  ),
                ),
              _Row(
                label: 'link',
                child: Text(
                  linkText(p),
                  style: AppText.urbanist(16, 500, height: 1.4).copyWith(color: scheme.onSurface),
                ),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(height: 26),
      Reveal(
        index: 6,
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            if (p case PublicProject(:final url)) ...[
              _PlayStoreButton(url: url),
              CopyAction(
                text: url,
                semanticLabel: 'Copy link',
                focusRadius: BorderRadius.circular(20),
                builder: (context, s, copied) => _PillButton(
                  hovered: s.hovered,
                  bg: scheme.surfaceContainerHigh,
                  icon: Icons.link_rounded,
                  label: copied ? 'Copied' : 'Copy link',
                ),
              ),
            ],
            _NextButton(title: next.displayTitle, onTap: () => context.go('/work/${next.slug}')),
          ],
        ),
      ),
    ];

    return Padding(
      padding: EdgeInsets.all(pad),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: children),
    );
  }
}

class _Fact extends StatefulWidget {
  const _Fact({required this.text});
  final String text;

  @override
  State<_Fact> createState() => _FactState();
}

class _FactState extends State<_Fact> {
  bool _h = false;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final def = M3Spring.defaultSpatial;
    return MouseRegion(
      onEnter: (_) => setState(() => _h = true),
      onExit: (_) => setState(() => _h = false),
      child: Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: scheme.outlineVariant)),
        ),
        child: AnimatedContainer(
          duration: def.durationOf(context),
          curve: def.curve,
          padding: EdgeInsets.fromLTRB(_h ? 16 : 10, 12, 10, 12),
          transform: Matrix4.translationValues(-10, 0, 0),
          decoration: BoxDecoration(
            color: _h ? scheme.surfaceContainer : Colors.transparent,
            borderRadius: BorderRadius.circular(_h ? 16 : 4),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: AnimatedScale(
                  scale: _h ? 1.3 : 1,
                  duration: def.durationOf(context),
                  curve: def.curve,
                  child: ShapeBox(
                    shape: _h ? M3Shape.sunny : M3Shape.cookie4,
                    rotation: _h ? .25 : 0,
                    spring: def,
                    size: 12,
                    color: scheme.primary,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  widget.text,
                  style: AppText.urbanist(16, 400, height: 1.5).copyWith(color: scheme.onSurface),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({required this.label, required this.child});
  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: scheme.outlineVariant)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: Text(
                label,
                style: AppText.urbanist(16, 500, height: 1.4).copyWith(color: scheme.onSurfaceVariant),
              ),
            ),
          ),
          Expanded(
            child: Padding(padding: const EdgeInsets.symmetric(vertical: 10), child: child),
          ),
        ],
      ),
    );
  }
}

class _DetailChip extends StatefulWidget {
  const _DetailChip({required this.name});
  final String name;

  @override
  State<_DetailChip> createState() => _DetailChipState();
}

class _DetailChipState extends State<_DetailChip> {
  bool _h = false;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final fast = M3Spring.fastSpatial;
    return MouseRegion(
      onEnter: (_) => setState(() => _h = true),
      onExit: (_) => setState(() => _h = false),
      child: AnimatedScale(
        scale: _h ? 1.05 : 1,
        duration: fast.durationOf(context),
        curve: fast.curve,
        child: AnimatedContainer(
          duration: fast.durationOf(context),
          curve: fast.curve,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: _h ? scheme.secondaryContainer : scheme.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(_h ? 18 : 10),
          ),
          child: Text(
            widget.name,
            style: AppText.urbanist(
              16,
              700,
              height: 1.4,
            ).copyWith(color: _h ? scheme.onSecondaryContainer : scheme.onSurface),
          ),
        ),
      ),
    );
  }
}

class _TextLink extends StatelessWidget {
  const _TextLink({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Pressable(
      onTap: onTap,
      focusRadius: BorderRadius.circular(6),
      builder: (context, s) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Text(
          label,
          style: AppText.urbanist(16, 700, height: 1.4, tracking: s.hovered ? .01 : 0).copyWith(color: scheme.primary),
        ),
      ),
    );
  }
}

class _PillButton extends StatelessWidget {
  const _PillButton({
    required this.hovered,
    required this.bg,
    required this.icon,
    required this.label,
    this.fg,
    this.pressed = false,
    this.big = false,
  });

  final bool hovered;
  final bool pressed;
  final Color bg;
  final Color? fg;
  final IconData icon;
  final String label;
  final bool big;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final fast = M3Spring.fastSpatial;
    final color = fg ?? scheme.onSurface;
    return AnimatedScale(
      scale: pressed ? .97 : 1,
      duration: fast.durationOf(context),
      curve: fast.curve,
      child: AnimatedContainer(
        duration: fast.durationOf(context),
        curve: fast.curve,
        height: 64,
        padding: EdgeInsets.symmetric(horizontal: big ? 28 : 24),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(pressed ? 12 : (hovered ? 32 : 20)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: big ? 24 : 20, color: color),
            AnimatedContainer(duration: fast.durationOf(context), width: big && hovered ? 16 : (big ? 10 : 8)),
            Text(label, style: AppText.urbanist(big ? 18 : 16, big ? 700 : 600).copyWith(color: color)),
          ],
        ),
      ),
    );
  }
}

class _PlayStoreButton extends StatelessWidget {
  const _PlayStoreButton({required this.url});
  final String url;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Pressable(
      onTap: () => openExternal(url),
      isLink: true,
      semanticLabel: 'Open on Play Store (opens in a new tab)',
      focusRadius: BorderRadius.circular(20),
      builder: (context, s) => _PillButton(
        hovered: s.hovered,
        pressed: s.pressed,
        big: true,
        bg: scheme.primary,
        fg: scheme.onPrimary,
        icon: Icons.shop_rounded,
        label: 'Open on Play Store',
      ),
    );
  }
}

class _NextButton extends StatelessWidget {
  const _NextButton({required this.title, required this.onTap});
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final fast = M3Spring.fastSpatial;
    return Pressable(
      onTap: onTap,
      semanticLabel: 'Next: $title',
      focusRadius: BorderRadius.circular(20),
      builder: (context, s) => AnimatedScale(
        scale: s.pressed ? .96 : 1,
        duration: fast.durationOf(context),
        curve: fast.curve,
        child: AnimatedContainer(
          duration: fast.durationOf(context),
          curve: fast.curve,
          height: 64,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: s.hovered ? scheme.surfaceContainer : Colors.transparent,
            borderRadius: BorderRadius.circular(s.hovered ? 32 : 20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Next: $title', style: AppText.urbanist(16, 600).copyWith(color: scheme.onSurface)),
              AnimatedContainer(duration: fast.durationOf(context), width: s.hovered ? 16 : 8),
              Icon(Icons.arrow_forward_rounded, size: 20, color: scheme.onSurface),
            ],
          ),
        ),
      ),
    );
  }
}
