import 'package:flutter/material.dart';

import '../../app/shell/shell_actions.dart';
import '../../content/home.dart';
import '../../content/identity.dart';
import '../../content/models.dart';
import '../../core/motion/reveal.dart';
import '../../core/motion/scroll_linked.dart';
import '../../core/motion/springs.dart';
import '../../core/responsive/breakpoints.dart';
import '../../core/shapes/m3e_shapes.dart';
import '../../core/theme/theme_controller.dart';
import '../../core/theme/tokens.dart';
import '../../core/theme/typography.dart';
import '../../core/widgets/pressable.dart';
import '../../core/widgets/tone.dart';

/// Shapes the hero blob and portrait step through on each hot reload.
const _blobShapes = [M3Shape.sunny, M3Shape.clover4, M3Shape.cookie9, M3Shape.cookie6, M3Shape.cookie7];
const _photoShapes = [M3Shape.cookie9, M3Shape.cookie4, M3Shape.clover4, M3Shape.cookie7, M3Shape.circle];

class HomeSection extends StatelessWidget {
  const HomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final w = size.width;
    final wide = context.isWide;
    final scheme = Theme.of(context).colorScheme;
    final heroSize = Space.fluid(w, 30, 7.6, 128);
    final blob = Space.fluid(w, 380, 58, 860);
    final gutter = Space.gutter(w);

    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: size.height - (wide ? Space.appBarHeight : 0)),
      child: ClipRect(
        child: Stack(
          children: [
            Positioned(
              right: -w * .12,
              top: -w * .07,
              width: blob,
              height: blob,
              child: _HeroArt(size: blob),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(gutter, 0, gutter, Space.fluid(w, 40, 6, 80)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 230),
                  Semantics(
                    header: true,
                    label: HomeCopy.headline.toString(),
                    child: ExcludeSemantics(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Reveal(
                            index: 0,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Text(HomeCopy.headline.first, style: AppText.hero(heroSize, 300)),
                            ),
                          ),
                          Reveal(
                            index: 1,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                HomeCopy.headline.second,
                                style: AppText.hero(heroSize, 800).copyWith(color: scheme.primary),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: Space.fluid(w, 18, 2.4, 32)),
                  Reveal(
                    index: 4,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 560),
                      child: Text(
                        HomeCopy.intro,
                        style: AppText.body(size: Space.fluid(w, 16, 1.5, 20)).copyWith(color: scheme.onSurfaceVariant),
                      ),
                    ),
                  ),
                  SizedBox(height: Space.fluid(w, 18, 2.4, 28)),
                  const Reveal(index: 4, child: _ReleaseCard()),
                  SizedBox(height: Space.fluid(w, 18, 2.4, 28)),
                  const Reveal(index: 5, child: _Ctas()),
                  SizedBox(height: Space.fluid(w, 24, 3, 40)),
                  Reveal(
                    index: 5,
                    child: Text('RECEIPTS', style: AppText.eyebrow().copyWith(color: scheme.onSurfaceVariant)),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: Space.fluid(w, 10, 1.6, 20),
                    runSpacing: Space.fluid(w, 10, 1.6, 20),
                    children: [
                      for (var i = 0; i < HomeCopy.stats.length; i++)
                        Reveal(
                          index: 5 + i,
                          child: _StatBadge(stat: HomeCopy.stats[i]),
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
  }
}

/// Morphing sunny blob with the portrait on top. Parallax and rotation
/// follow scroll; hot reload steps both through their shape lists.
class _HeroArt extends StatelessWidget {
  const _HeroArt({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final step = ThemeScope.of(context).seedIndex;
    final reduce = context.reduceMotion;
    Widget art(double p) => Transform.translate(
      offset: Offset(0, reduce ? 0 : -160 * (p - .5)),
      child: Stack(
        children: [
          Positioned.fill(
            child: Reveal(
              index: 2,
              child: ShapeBox(
                shape: _blobShapes[step % _blobShapes.length],
                color: scheme.primaryContainer,
                rotation: reduce ? 0 : (-20 + 180 * p) / 360,
              ),
            ),
          ),
          Positioned(
            left: size * .24,
            top: size * .24,
            width: size * .52,
            height: size * .52,
            child: Reveal(
              index: 3,
              child: ShapeBox(
                shape: _photoShapes[step % _photoShapes.length],
                clip: true,
                child: Image.asset(
                  'assets/images/profile.jpg',
                  fit: BoxFit.cover,
                  semanticLabel: Identity.name,
                  cacheWidth: (size * .52 * MediaQuery.devicePixelRatioOf(context)).round(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
    return ScrollLinked(track: ScrollTrack.through, builder: (context, p, _) => art(p));
  }
}

class _StatBadge extends StatefulWidget {
  const _StatBadge({required this.stat});
  final Stat stat;

  @override
  State<_StatBadge> createState() => _StatBadgeState();
}

class _StatBadgeState extends State<_StatBadge> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final w = context.screenWidth;
    final scheme = Theme.of(context).colorScheme;
    final tone = toneColors(scheme, widget.stat.tone);
    final shapeSize = Space.fluid(w, 88, 8.6, 124);
    final def = M3Spring.defaultSpatial;
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: SizedBox(
        width: Space.fluid(w, 96, 9.4, 136),
        child: Column(
          children: [
            AnimatedScale(
              scale: _hover ? 1.06 : 1,
              duration: M3Spring.fastSpatial.durationOf(context),
              curve: M3Spring.fastSpatial.curve,
              child: ShapeBox(
                shape: _hover ? M3Shape.circle : M3Shape.byName(widget.stat.shape),
                spring: def,
                size: shapeSize,
                color: tone.bg,
                child: Text(
                  widget.stat.value,
                  style: AppText.urbanist(Space.fluid(w, 28, 3, 44), 800, tracking: -.03).copyWith(color: tone.fg),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.stat.label,
              textAlign: TextAlign.center,
              style: AppText.urbanist(13, 500, height: 1.3).copyWith(color: scheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}

/// The `pubspec.yaml` header and the changelog-style release notes.
class _ReleaseCard extends StatelessWidget {
  const _ReleaseCard();

  @override
  Widget build(BuildContext context) {
    final w = context.screenWidth;
    final scheme = Theme.of(context).colorScheme;
    final size = Space.fluid(w, 14, 1.3, 16);
    final code = AppText.manrope(size, 500, height: 1.6).copyWith(color: scheme.onSurface);
    final muted = code.copyWith(color: scheme.onSurfaceVariant);
    final key = AppText.withWeight(code, 700).copyWith(color: scheme.primary);
    return Container(
      constraints: const BoxConstraints(maxWidth: 640),
      padding: EdgeInsets.all(Space.fluid(w, 18, 2.2, 28)),
      decoration: BoxDecoration(
        color: scheme.surfaceContainer,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
          bottomRight: Radius.circular(28),
          bottomLeft: Radius.circular(8),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('# pubspec.yaml', style: muted),
          for (final (k, v) in HomeCopy.header)
            Text.rich(TextSpan(children: [TextSpan(text: '$k: ', style: key), TextSpan(text: v)]), style: code),
          const SizedBox(height: 14),
          Text('# CHANGELOG.md', style: muted),
          const SizedBox(height: 4),
          for (final n in HomeCopy.releaseNotes)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: '${n.lead} ', style: AppText.withWeight(code, 800)),
                    TextSpan(text: n.text),
                  ],
                ),
                style: code,
              ),
            ),
        ],
      ),
    );
  }
}

/// "View my work" and "Get in touch".
class _Ctas extends StatelessWidget {
  const _Ctas();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final actions = ShellActions.of(context);
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        _CtaButton(
          label: HomeCopy.ctaWork,
          icon: Icons.arrow_downward_rounded,
          bg: scheme.primary,
          fg: scheme.onPrimary,
          onTap: () => actions.goTo('work'),
        ),
        _CtaButton(
          label: HomeCopy.ctaContact,
          icon: Icons.edit_rounded,
          bg: scheme.secondaryContainer,
          fg: scheme.onSecondaryContainer,
          onTap: actions.openContact,
        ),
      ],
    );
  }
}

class _CtaButton extends StatelessWidget {
  const _CtaButton({required this.label, required this.icon, required this.bg, required this.fg, required this.onTap});

  final String label;
  final IconData icon;
  final Color bg;
  final Color fg;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final fast = M3Spring.fastSpatial;
    return Pressable(
      onTap: onTap,
      semanticLabel: label,
      focusRadius: BorderRadius.circular(20),
      builder: (context, s) => AnimatedScale(
        scale: s.pressed ? .97 : 1,
        duration: fast.durationOf(context),
        curve: fast.curve,
        child: AnimatedContainer(
          duration: fast.durationOf(context),
          curve: fast.curve,
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(s.pressed ? 12 : (s.hovered ? 28 : 20)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 20, color: fg),
              const SizedBox(width: 8),
              Text(label, style: AppText.urbanist(16, 700).copyWith(color: fg)),
            ],
          ),
        ),
      ),
    );
  }
}
