import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../content/models.dart';
import '../../content/projects.dart';
import '../../core/motion/reveal.dart';
import '../../core/motion/scroll_linked.dart';
import '../../core/motion/springs.dart';
import '../../core/responsive/breakpoints.dart';
import '../../core/shapes/m3e_shapes.dart';
import '../../core/theme/tokens.dart';
import '../../core/theme/typography.dart';
import '../../core/widgets/external_link.dart';
import '../../core/widgets/pressable.dart';
import '../../core/widgets/toast.dart';
import 'parts.dart';

const _masks = [M3Shape.cookie9, M3Shape.clover4, M3Shape.sunny];
const _maskHover = [M3Shape.cookie4, M3Shape.cookie6, M3Shape.cookie7];
const _maskLabels = ['Cookie', 'Clover', 'Sunny'];

/// "Widget catalog": pick a project on the left, inspect the specimen in
/// the middle, tweak the knobs on the right.
class WorkSection extends StatefulWidget {
  const WorkSection({super.key});

  @override
  State<WorkSection> createState() => _WorkSectionState();
}

class _WorkSectionState extends State<WorkSection> {
  int _index = 0;
  int _mask = 0;

  List<Project> get _projects => WorkCopy.projects;
  Project get _project => _projects[_index];

  void _select(int i) => setState(() => _index = (i + _projects.length) % _projects.length);

  void _openDetail() => context.go('/work/${_project.slug}');

  @override
  Widget build(BuildContext context) {
    final w = context.screenWidth;
    final h = MediaQuery.sizeOf(context).height;
    final scheme = Theme.of(context).colorScheme;
    final threeCol = w >= Breakpoints.workThreeColumn;
    final wide = context.isWide;

    final catalogW = threeCol ? (w * .2).clamp(220.0, 280.0) : (w * .26).clamp(200.0, 260.0);
    final knobsW = (w * .24).clamp(260.0, 340.0);
    final canvasW = threeCol ? w - catalogW - knobsW : (wide ? w - catalogW : w);
    final catalog = _Catalog(projects: _projects, index: _index, onSelect: _select, horizontal: !wide);
    final canvas = _Canvas(
      project: _project,
      mask: _mask,
      index: _index,
      count: _projects.length,
      width: canvasW,
      onOpen: _openDetail,
      onSwipe: (d) => _select(_index + d),
    );
    final knobs = _Knobs(project: _project, mask: _mask, onMask: (m) => setState(() => _mask = m), onOpen: _openDetail);

    Widget body;
    if (threeCol) {
      body = IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(width: catalogW, child: catalog),
            Expanded(child: canvas),
            SizedBox(width: knobsW, child: knobs),
          ],
        ),
      );
    } else if (wide) {
      body = Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(width: catalogW, child: catalog),
                Expanded(child: canvas),
              ],
            ),
          ),
          knobs,
        ],
      );
    } else {
      body = Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [catalog, canvas, knobs]);
    }

    return Container(
      constraints: BoxConstraints(minHeight: h - (wide ? Space.appBarHeight : 0)),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: scheme.outlineVariant)),
      ),
      child: body,
    );
  }
}

class _Catalog extends StatelessWidget {
  const _Catalog({required this.projects, required this.index, required this.onSelect, required this.horizontal});

  final List<Project> projects;
  final int index;
  final ValueChanged<int> onSelect;
  final bool horizontal;

  @override
  Widget build(BuildContext context) {
    final w = context.screenWidth;
    final scheme = Theme.of(context).colorScheme;
    final headingSize = Space.fluid(w, 34, 3.2, 46);
    final heading = AppText.sectionHeading(headingSize, 800);
    final items = [
      for (var i = 0; i < projects.length; i++)
        _CatalogItem(project: projects[i], selected: i == index, onTap: () => onSelect(i)),
    ];
    return Reveal(
      child: Container(
        color: scheme.surfaceContainerLow,
        padding: EdgeInsets.symmetric(vertical: Space.fluid(w, 20, 3, 36), horizontal: Space.fluid(w, 14, 2, 20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 18),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Semantics(
                      header: true,
                      label: WorkCopy.heading.toString(),
                      // Scale down rather than break words in the narrow column.
                      child: ExcludeSemantics(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ScrollWeightText(WorkCopy.heading.first, style: heading, from: 300, to: 800),
                              ScrollWeightText(
                                WorkCopy.heading.second,
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
                  ScrollShape(
                    from: M3Shape.pentagon,
                    to: M3Shape.cookie7,
                    color: scheme.tertiary,
                    size: 44,
                    rotateTo: 180,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 6),
              child: Text(
                'CATALOG · ${projects.length}',
                style: AppText.eyebrow(weight: 600).copyWith(color: scheme.onSurfaceVariant),
              ),
            ),
            _ListboxKeys(
              onMove: (d) => onSelect(index + d),
              child: Semantics(
                label: 'Projects',
                container: true,
                child: horizontal
                    ? SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for (final it in items) Padding(padding: const EdgeInsets.only(right: 4), child: it),
                          ],
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          for (final it in items) Padding(padding: const EdgeInsets.only(bottom: 4), child: it),
                        ],
                      ),
              ),
            ),
            if (!horizontal) ...[
              const SizedBox(height: 20),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  WorkCopy.subtitle,
                  style: AppText.urbanist(15, 500, height: 1.5).copyWith(color: scheme.onSurfaceVariant),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Arrow keys move the selection while focus is inside the catalog.
class _ListboxKeys extends StatelessWidget {
  const _ListboxKeys({required this.onMove, required this.child});

  final ValueChanged<int> onMove;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.arrowDown): () => onMove(1),
        const SingleActivator(LogicalKeyboardKey.arrowRight): () => onMove(1),
        const SingleActivator(LogicalKeyboardKey.arrowUp): () => onMove(-1),
        const SingleActivator(LogicalKeyboardKey.arrowLeft): () => onMove(-1),
      },
      child: FocusTraversalGroup(child: child),
    );
  }
}

class _CatalogItem extends StatelessWidget {
  const _CatalogItem({required this.project, required this.selected, required this.onTap});

  final Project project;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = projectColors(scheme, project);
    final def = M3Spring.defaultSpatial, fast = M3Spring.fastSpatial;
    final fg = selected ? scheme.onSecondaryContainer : scheme.onSurface;
    return Pressable(
      onTap: onTap,
      selected: selected,
      semanticLabel: '${project.displayTitle}${project.isRedacted ? ', name redacted' : ''}, ${project.platform}',
      focusRadius: BorderRadius.circular(16),
      builder: (context, s) => AnimatedScale(
        scale: s.pressed ? .96 : 1,
        duration: fast.durationOf(context),
        curve: fast.curve,
        child: AnimatedContainer(
          duration: def.durationOf(context),
          curve: def.curve,
          transform: Matrix4.translationValues(s.hovered ? 4 : 0, 0, 0),
          padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
          decoration: BoxDecoration(
            color: selected ? scheme.secondaryContainer : Colors.transparent,
            borderRadius: BorderRadius.circular(selected ? 28 : 16),
          ),
          foregroundDecoration: BoxDecoration(
            color: s.hovered ? fg.withValues(alpha: .08) : Colors.transparent,
            borderRadius: BorderRadius.circular(selected ? 28 : 16),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ShapeBox(
                shape: selected ? M3Shape.sunny : M3Shape.cookie6,
                rotation: selected ? .125 : 0,
                spring: def,
                size: 40,
                color: colors.bg,
                clip: project is PublicProject,
                child: project is PublicProject
                    ? Container(
                        color: colors.bg,
                        child: ProjectArt(project: project, iconSize: 22, thumbnail: true),
                      )
                    : ProjectArt(project: project, iconSize: 22),
              ),
              const SizedBox(width: 12),
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // "Case file NN" keeps its width; the bar gives way.
                        Flexible(
                          flex: project.isRedacted ? 0 : 1,
                          child: Text(
                            project.displayTitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppText.urbanist(17, selected ? 700 : 500).copyWith(color: fg),
                          ),
                        ),
                        if (project.isRedacted) ...[
                          const SizedBox(width: 8),
                          Flexible(
                            child: Container(
                              constraints: const BoxConstraints(maxWidth: 56),
                              height: 12,
                              decoration: BoxDecoration(
                                color: fg.withValues(alpha: .85),
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 1),
                    Text(
                      project.platform,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppText.caption().copyWith(color: fg.withValues(alpha: .75)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// The dot-grid canvas with the specimen. Mouse movement tilts it (state
/// kept in a notifier so only the painted layers update); touch swipes
/// between projects.
class _Canvas extends StatefulWidget {
  const _Canvas({
    required this.project,
    required this.mask,
    required this.index,
    required this.count,
    required this.onOpen,
    required this.onSwipe,
    required this.width,
  });

  final Project project;
  final int mask;
  final int index;
  final int count;

  /// Width of the canvas column.
  final double width;
  final VoidCallback onOpen;
  final ValueChanged<int> onSwipe;

  @override
  State<_Canvas> createState() => _CanvasState();
}

class _CanvasState extends State<_Canvas> {
  final ValueNotifier<Offset> _tilt = ValueNotifier(Offset.zero);
  Offset? _down;

  @override
  void dispose() {
    _tilt.dispose();
    super.dispose();
  }

  void _onHover(PointerHoverEvent e) {
    if (e.kind != PointerDeviceKind.mouse || context.reduceMotion) return;
    final size = (context.findRenderObject() as RenderBox).size;
    _tilt.value = Offset(e.localPosition.dx / size.width * 2 - 1, e.localPosition.dy / size.height * 2 - 1);
  }

  @override
  Widget build(BuildContext context) {
    final w = context.screenWidth;
    final h = MediaQuery.sizeOf(context).height;
    final scheme = Theme.of(context).colorScheme;
    final wide = context.isWide;
    final p = widget.project;
    final specimen = Space.fluid(w, 200, 22, 300);

    final minHeight = (h * .6).clamp(480.0, 720.0);
    final textWidth = (widget.width - 40).clamp(0.0, 780.0);
    return MouseRegion(
      onHover: _onHover,
      onExit: (_) => _tilt.value = Offset.zero,
      child: Listener(
        onPointerDown: (e) => _down = e.kind == PointerDeviceKind.mouse ? null : e.position,
        onPointerUp: (e) {
          final start = _down;
          _down = null;
          if (start == null) return;
          final d = e.position - start;
          if (d.dx.abs() > 50 && d.dx.abs() > d.dy.abs() * 1.4) widget.onSwipe(d.dx < 0 ? 1 : -1);
        },
        child: ClipRect(
          child: CustomPaint(
            painter: _DotGrid(color: scheme.outlineVariant, tilt: _tilt),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: minHeight),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 40, 20, 72),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: Space.fluid(w, 20, 3, 36)),
                          _Specimen(
                            project: p,
                            mask: widget.mask,
                            size: specimen,
                            tilt: _tilt,
                            onOpen: widget.onOpen,
                          ),
                          SizedBox(height: Space.fluid(w, 20, 3, 36) + 24),
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 780),
                            child: Column(
                              children: [
                                SwapReveal(
                                  keyValue: 'm${widget.index}',
                                  child: Text(
                                    p.meta,
                                    textAlign: TextAlign.center,
                                    style: AppText.manrope(
                                      13,
                                      600,
                                      tracking: .04,
                                    ).copyWith(color: scheme.onSurfaceVariant),
                                  ),
                                ),
                                const SizedBox(height: 14),
                                SwapReveal(
                                  keyValue: 't${widget.index}',
                                  index: 1,
                                  child: ProjectTitle(
                                    project: p,
                                    center: true,
                                    ink: scheme.onSurface,
                                    style: AppText.urbanist(
                                      Space.fluid(w, 36, 4.6, 64),
                                      800,
                                      height: 1,
                                      tracking: -.04,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 14),
                                SwapReveal(
                                  keyValue: 'o${widget.index}',
                                  index: 2,
                                  child: ConstrainedBox(
                                    constraints: const BoxConstraints(maxWidth: 620),
                                    child: Text(
                                      p.commitTitle,
                                      textAlign: TextAlign.center,
                                      style: AppText.manrope(
                                        Space.fluid(w, 15, 1.4, 18),
                                        600,
                                        height: 1.5,
                                      ).copyWith(color: scheme.onSurfaceVariant),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                SwapReveal(
                                  keyValue: 'c${widget.index}',
                                  index: 3,
                                  child: ConstraintOutcome(project: p, width: textWidth),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    right: 20,
                    bottom: 18,
                    child: IgnorePointer(
                      child: Row(
                        children: [
                          Flexible(
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: scheme.surfaceContainerHigh,
                                borderRadius: BorderRadius.circular(99),
                              ),
                              child: Text(
                                wide ? 'Tap the specimen to open · ↑↓ to browse' : 'Tap to open · swipe to browse',
                                style: AppText.caption(weight: 600).copyWith(color: scheme.onSurfaceVariant),
                              ),
                            ),
                          ),
                          const Spacer(),
                          for (var i = 0; i < widget.count; i++) ...[
                            if (i > 0) const SizedBox(width: 6),
                            AnimatedContainer(
                              duration: M3Spring.defaultSpatial.durationOf(context),
                              curve: M3Spring.defaultSpatial.curve,
                              height: 8,
                              width: i == widget.index ? 24 : 8,
                              decoration: BoxDecoration(
                                color: i == widget.index ? scheme.primary : scheme.outlineVariant,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DotGrid extends CustomPainter {
  _DotGrid({required this.color, required this.tilt}) : super(repaint: tilt);

  final Color color;
  final ValueNotifier<Offset> tilt;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final o = tilt.value * -18;
    final dx = o.dx % 24, dy = o.dy % 24;
    for (var y = dy - 24; y < size.height + 24; y += 24) {
      for (var x = dx - 24; x < size.width + 24; x += 24) {
        canvas.drawCircle(Offset(x + 12, y + 12), 1.2, paint);
      }
    }
  }

  @override
  bool shouldRepaint(_DotGrid old) => old.color != color || old.tilt != tilt;
}

class _Specimen extends StatefulWidget {
  const _Specimen({
    required this.project,
    required this.mask,
    required this.size,
    required this.tilt,
    required this.onOpen,
  });

  final Project project;
  final int mask;
  final double size;
  final ValueNotifier<Offset> tilt;
  final VoidCallback onOpen;

  @override
  State<_Specimen> createState() => _SpecimenState();
}

class _SpecimenState extends State<_Specimen> {
  bool _halo = false;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = projectColors(scheme, widget.project);
    final s = widget.size;
    final fast = M3Spring.fastSpatial;
    return MouseRegion(
      onEnter: (_) => setState(() => _halo = true),
      onExit: (_) => setState(() => _halo = false),
      child: SizedBox(
        width: s,
        height: s,
        child: ValueListenableBuilder<Offset>(
          valueListenable: widget.tilt,
          builder: (context, t, _) => Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                left: -s * .12 - t.dx * 12,
                top: -s * .12 - t.dy * 12,
                width: s * 1.24,
                height: s * 1.24,
                child: AnimatedScale(
                  scale: _halo ? 1.08 : 1,
                  duration: M3Spring.defaultSpatial.durationOf(context),
                  curve: M3Spring.defaultSpatial.curve,
                  child: ExcludeSemantics(
                    child: ShapeBox(
                      shape: _halo ? _maskHover[widget.mask] : _masks[widget.mask],
                      color: scheme.surfaceContainerHigh,
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Reveal(
                  index: 1,
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 1 / 900)
                      ..rotateX(t.dy * -12 * 3.14159 / 180)
                      ..rotateY(t.dx * 14 * 3.14159 / 180)
                      ..translateByDouble(t.dx * 8, t.dy * 8, 0, 1),
                    child: Pressable(
                      onTap: widget.onOpen,
                      semanticLabel: 'Open detail: ${widget.project.displayTitle}',
                      tooltip: 'Open detail',
                      focusRadius: BorderRadius.circular(s / 2),
                      builder: (context, st) => AnimatedScale(
                        scale: st.pressed ? .94 : (st.hovered ? 1.05 : 1),
                        duration: fast.durationOf(context),
                        curve: fast.curve,
                        child: ShapeBox(
                          shape: st.hovered ? _maskHover[widget.mask] : _masks[widget.mask],
                          color: colors.bg,
                          child: SwapReveal(
                            keyValue: widget.project.slug,
                            child: ProjectArt(
                              project: widget.project,
                              iconSize: Space.fluid(context.screenWidth, 80, 9, 128),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Knobs extends StatelessWidget {
  const _Knobs({required this.project, required this.mask, required this.onMask, required this.onOpen});

  final Project project;
  final int mask;
  final ValueChanged<int> onMask;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    final w = context.screenWidth;
    final scheme = Theme.of(context).colorScheme;
    final label = AppText.manrope(14, 600).copyWith(color: scheme.onSurfaceVariant);
    final p = project;
    return Reveal(
      index: 1,
      child: Container(
        color: scheme.surfaceContainerLow,
        padding: EdgeInsets.symmetric(vertical: Space.fluid(w, 20, 3, 36), horizontal: Space.fluid(w, 18, 2, 28)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('KNOBS', style: AppText.eyebrow(weight: 600).copyWith(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 20),
            Text('stack', style: label),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (var i = 0; i < p.stack.length; i++)
                  SwapReveal(
                    keyValue: '${p.slug}-$i',
                    index: i,
                    child: _StackChip(name: p.stack[i]),
                  ),
              ],
            ),
            const SizedBox(height: 20),
            Text('mask', style: label),
            const SizedBox(height: 10),
            Row(
              children: [
                for (var i = 0; i < 3; i++) ...[
                  if (i > 0) const SizedBox(width: 2),
                  Expanded(
                    child: _MaskButton(index: i, selected: mask == i, onTap: () => onMask(i)),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 20),
            _KeyValue(k: 'platform', v: p.platform),
            const SizedBox(height: 10),
            _KeyValue(k: 'link', v: linkText(p)),
            const SizedBox(height: 20),
            _OpenDetailButton(onTap: onOpen),
            const SizedBox(height: 8),
            switch (p) {
              PublicProject(:final url) => _OutlineLink(label: 'Play Store', url: url),
              RedactedCaseFile() => _NotPublicBadge(),
            },
          ],
        ),
      ),
    );
  }
}

class _StackChip extends StatefulWidget {
  const _StackChip({required this.name});
  final String name;

  @override
  State<_StackChip> createState() => _StackChipState();
}

class _StackChipState extends State<_StackChip> {
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
          height: 36,
          padding: const EdgeInsets.only(left: 10, right: 14),
          decoration: BoxDecoration(
            color: scheme.secondaryContainer,
            borderRadius: BorderRadius.circular(_h ? 18 : 10),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_rounded, size: 18, color: scheme.onSecondaryContainer),
              const SizedBox(width: 6),
              Text(widget.name, style: AppText.urbanist(14, 700).copyWith(color: scheme.onSecondaryContainer)),
            ],
          ),
        ),
      ),
    );
  }
}

class _MaskButton extends StatelessWidget {
  const _MaskButton({required this.index, required this.selected, required this.onTap});

  final int index;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final fast = M3Spring.fastSpatial;
    final rest = index == 0
        ? const BorderRadius.horizontal(left: Radius.circular(22), right: Radius.circular(6))
        : index == 2
        ? const BorderRadius.horizontal(left: Radius.circular(6), right: Radius.circular(22))
        : BorderRadius.circular(6);
    final fg = selected ? scheme.onPrimary : scheme.onSurface;
    return Pressable(
      onTap: onTap,
      selected: selected,
      semanticLabel: '${_maskLabels[index]} mask',
      focusRadius: rest,
      builder: (context, s) => AnimatedScale(
        scale: s.pressed ? .94 : 1,
        duration: fast.durationOf(context),
        curve: fast.curve,
        child: AnimatedContainer(
          duration: fast.durationOf(context),
          curve: fast.curve,
          height: 44,
          decoration: BoxDecoration(
            color: selected ? scheme.primary : scheme.surfaceContainerHigh,
            borderRadius: selected || s.pressed ? BorderRadius.circular(22) : rest,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ShapeBox(
                shape: _masks[index],
                size: 14,
                color: fg,
                rotation: s.hovered ? .25 : 0,
                spring: M3Spring.defaultSpatial,
              ),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  _maskLabels[index],
                  overflow: TextOverflow.ellipsis,
                  style: AppText.urbanist(14, 700).copyWith(color: fg),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _KeyValue extends StatelessWidget {
  const _KeyValue({required this.k, required this.v});
  final String k;
  final String v;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final style = AppText.manrope(14, 500, height: 1.4);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 86,
          child: Text(k, style: style.copyWith(color: scheme.onSurfaceVariant)),
        ),
        Expanded(
          child: Text(v, style: style.copyWith(color: scheme.onSurface)),
        ),
      ],
    );
  }
}

class _OpenDetailButton extends StatelessWidget {
  const _OpenDetailButton({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final fast = M3Spring.fastSpatial;
    return Pressable(
      onTap: onTap,
      focusRadius: BorderRadius.circular(16),
      builder: (context, s) => AnimatedScale(
        scale: s.pressed ? .97 : 1,
        duration: fast.durationOf(context),
        curve: fast.curve,
        child: AnimatedContainer(
          duration: fast.durationOf(context),
          curve: fast.curve,
          height: 56,
          decoration: BoxDecoration(
            color: scheme.primary,
            borderRadius: BorderRadius.circular(s.pressed ? 10 : (s.hovered ? 28 : 16)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Open detail', style: AppText.urbanist(16, 700).copyWith(color: scheme.onPrimary)),
              AnimatedContainer(duration: fast.durationOf(context), curve: fast.curve, width: s.hovered ? 16 : 8),
              Icon(Icons.arrow_forward_rounded, size: 20, color: scheme.onPrimary),
            ],
          ),
        ),
      ),
    );
  }
}

class _OutlineLink extends StatelessWidget {
  const _OutlineLink({required this.label, required this.url});
  final String label;
  final String url;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final fast = M3Spring.fastSpatial;
    return Pressable(
      onTap: () => openExternal(url),
      isLink: true,
      semanticLabel: '$label (opens in a new tab)',
      focusRadius: BorderRadius.circular(16),
      builder: (context, s) => AnimatedContainer(
        duration: fast.durationOf(context),
        curve: fast.curve,
        height: 48,
        decoration: BoxDecoration(
          border: Border.all(color: scheme.outline, width: 1.5),
          borderRadius: BorderRadius.circular(s.hovered ? 24 : 16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: AppText.urbanist(15, 600).copyWith(color: s.hovered ? scheme.primary : scheme.onSurface),
            ),
            const SizedBox(width: 8),
            Icon(Icons.north_east_rounded, size: 18, color: s.hovered ? scheme.primary : scheme.onSurface),
          ],
        ),
      ),
    );
  }
}

class _NotPublicBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final fast = M3Spring.fastSpatial;
    return Pressable(
      onTap: () => showToast(context, WorkCopy.redactedHover),
      semanticLabel: WorkCopy.notPublic,
      focusRadius: BorderRadius.circular(16),
      builder: (context, s) => AnimatedContainer(
        duration: fast.durationOf(context),
        curve: fast.curve,
        height: 48,
        decoration: BoxDecoration(
          color: scheme.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(s.hovered ? 24 : 16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.lock_rounded, size: 18, color: scheme.onSurfaceVariant),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                WorkCopy.notPublic,
                overflow: TextOverflow.ellipsis,
                style: AppText.urbanist(15, 600).copyWith(color: scheme.onSurfaceVariant),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
