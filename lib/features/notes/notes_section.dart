import 'package:flutter/material.dart';

import '../../content/models.dart';
import '../../content/notes.dart';
import '../../core/motion/reveal.dart';
import '../../core/motion/scroll_linked.dart';
import '../../core/motion/springs.dart';
import '../../core/responsive/breakpoints.dart';
import '../../core/shapes/m3e_shapes.dart';
import '../../core/theme/tokens.dart';
import '../../core/theme/typography.dart';
import '../../core/widgets/external_link.dart';
import '../../core/widgets/pressable.dart';

const _badgeShapes = [M3Shape.cookie9, M3Shape.clover4, M3Shape.cookie7, M3Shape.pentagon, M3Shape.cookie4];

class NotesSection extends StatelessWidget {
  const NotesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final w = context.screenWidth;
    final scheme = Theme.of(context).colorScheme;
    final heading = AppText.urbanist(Space.fluid(w, 56, 9, 140), 800, height: .84, tracking: -.05);
    final posts = NotesCopy.posts;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1440),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Space.fluid(w, 16, 3, 64), vertical: Space.fluid(w, 24, 4, 56)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Reveal(
                child: Text('BLOG', style: AppText.manrope(13, 700, tracking: .16).copyWith(color: scheme.primary)),
              ),
              const SizedBox(height: 14),
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.end,
                spacing: 20,
                runSpacing: 20,
                children: [
                  Reveal(
                    child: Semantics(
                      header: true,
                      label: NotesCopy.heading.toString(),
                      child: ExcludeSemantics(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ScrollWeightText(NotesCopy.heading.first, style: heading, from: 300, to: 800),
                            ScrollWeightText(
                              NotesCopy.heading.second,
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
                  Reveal(
                    index: 1,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 340),
                      child: Text(
                        NotesCopy.subtitle,
                        style: AppText.urbanist(17, 500, height: 1.4).copyWith(color: scheme.onSurfaceVariant),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              if (posts.isEmpty)
                Text(NotesCopy.emptyState, style: AppText.body(size: 18).copyWith(color: scheme.onSurfaceVariant))
              else
                Container(
                  decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: scheme.outlineVariant)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      for (var i = 0; i < posts.length; i++)
                        Reveal(
                          index: i + 2,
                          child: _PostRow(post: posts[i], index: i),
                        ),
                    ],
                  ),
                ),
              const SizedBox(height: 28),
              Reveal(index: 6, child: const _AllPostsButton()),
            ],
          ),
        ),
      ),
    );
  }
}

class _PostRow extends StatelessWidget {
  const _PostRow({required this.post, required this.index});

  final Post post;
  final int index;

  @override
  Widget build(BuildContext context) {
    final w = context.screenWidth;
    final scheme = Theme.of(context).colorScheme;
    final wide = context.isWide;
    final tones = [
      (scheme.primary, scheme.onPrimary),
      (scheme.tertiaryContainer, scheme.onTertiaryContainer),
      (scheme.secondaryContainer, scheme.onSecondaryContainer),
      (scheme.primaryContainer, scheme.onPrimaryContainer),
      (scheme.surfaceContainerHighest, scheme.onSurface),
    ];
    final tone = tones[index % tones.length];
    final def = M3Spring.defaultSpatial, fast = M3Spring.fastSpatial;
    final hPad = Space.fluid(w, 10, 1.6, 20);
    final gap = Space.fluid(w, 12, 2.4, 32);
    final badge = Space.fluid(w, 48, 5, 64);
    final num = '${index + 1}'.padLeft(2, '0');

    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: scheme.outlineVariant)),
      ),
      child: Pressable(
        onTap: () => openExternal(post.url),
        isLink: true,
        semanticLabel: '${post.title}${post.date == null ? '' : ', ${post.date}'} (opens in a new tab)',
        focusRadius: BorderRadius.circular(20),
        builder: (context, s) => AnimatedContainer(
          duration: def.durationOf(context),
          curve: def.curve,
          padding: EdgeInsets.symmetric(horizontal: hPad, vertical: Space.fluid(w, 18, 2.4, 28)),
          decoration: BoxDecoration(
            color: s.hovered ? scheme.surfaceContainer : Colors.transparent,
            borderRadius: BorderRadius.circular(s.pressed ? 20 : (s.hovered ? 36 : 6)),
          ),
          child: Row(
            children: [
              ShapeBox(
                shape: s.hovered ? M3Shape.sunny : _badgeShapes[index % _badgeShapes.length],
                rotation: s.hovered ? .125 : 0,
                spring: def,
                size: badge,
                color: tone.$1,
                child: Text(num, style: AppText.manrope(Space.fluid(w, 16, 1.6, 20), 800).copyWith(color: tone.$2)),
              ),
              SizedBox(width: gap),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TweenAnimationBuilder<double>(
                      tween: Tween(end: s.hovered ? 800 : 600),
                      duration: def.durationOf(context),
                      curve: Curves.easeOut,
                      builder: (context, wght, _) => Text(
                        post.title,
                        style: AppText.urbanist(
                          Space.fluid(w, 22, 2.6, 36),
                          (wght / 25).round() * 25.0,
                          height: 1.12,
                          tracking: s.hovered ? -.035 : -.025,
                        ).copyWith(color: scheme.onSurface),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        for (final t in post.tags)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: scheme.surfaceContainerHigh,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(t, style: AppText.manrope(12, 700).copyWith(color: scheme.onSurfaceVariant)),
                          ),
                        if (post.date != null)
                          Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Text(
                              post.date!,
                              style: AppText.manrope(13, 600).copyWith(color: scheme.onSurfaceVariant),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              if (wide) ...[
                SizedBox(width: gap),
                AnimatedRotation(
                  turns: s.hovered ? .125 : 0,
                  duration: def.durationOf(context),
                  curve: def.curve,
                  child: AnimatedContainer(
                    duration: fast.durationOf(context),
                    curve: fast.curve,
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: s.hovered ? scheme.primary : scheme.surfaceContainerHigh,
                      borderRadius: BorderRadius.circular(s.hovered ? 14 : 26),
                    ),
                    child: Icon(
                      Icons.arrow_outward_rounded,
                      size: 24,
                      color: s.hovered ? scheme.onPrimary : scheme.onSurface,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _AllPostsButton extends StatelessWidget {
  const _AllPostsButton();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final fast = M3Spring.fastSpatial;
    return Pressable(
      onTap: () => openExternal(NotesCopy.blogUrl),
      isLink: true,
      semanticLabel: 'All posts on Hashnode (opens in a new tab)',
      focusRadius: BorderRadius.circular(18),
      builder: (context, s) => AnimatedScale(
        scale: s.pressed ? .96 : 1,
        duration: fast.durationOf(context),
        curve: fast.curve,
        child: AnimatedContainer(
          duration: fast.durationOf(context),
          curve: fast.curve,
          height: 56,
          padding: const EdgeInsets.only(left: 18, right: 24),
          decoration: BoxDecoration(
            color: scheme.primary,
            borderRadius: BorderRadius.circular(s.pressed ? 12 : (s.hovered ? 28 : 18)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.article_rounded, size: 22, color: scheme.onPrimary),
              const SizedBox(width: 10),
              Text('All posts on Hashnode', style: AppText.urbanist(16, 700).copyWith(color: scheme.onPrimary)),
              AnimatedContainer(duration: fast.durationOf(context), width: s.hovered ? 16 : 10),
              Icon(Icons.north_east_rounded, size: 20, color: scheme.onPrimary),
            ],
          ),
        ),
      ),
    );
  }
}
