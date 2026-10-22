import 'package:flutter/material.dart';

import '../../app/shell/shell_actions.dart';
import '../../content/contact.dart';
import '../../content/identity.dart';
import '../../content/microcopy.dart';
import '../../core/motion/reveal.dart';
import '../../core/motion/scroll_linked.dart';
import '../../core/motion/springs.dart';
import '../../core/responsive/breakpoints.dart';
import '../../core/shapes/m3e_shapes.dart';
import '../../core/shapes/morph_loader.dart';
import '../../core/theme/tokens.dart';
import '../../core/theme/typography.dart';
import '../../core/widgets/copy_action.dart';
import '../../core/widgets/pressable.dart';
import '../about/about_section.dart' show SocialPill;

/// "flutter build --release": the closing section, CTA and footer.
class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final w = context.screenWidth;
    final scheme = Theme.of(context).colorScheme;
    final fg = scheme.onPrimaryContainer;
    final radius = Radius.circular(Space.fluid(w, 40, 6, 96));
    final gap = SizedBox(height: Space.fluid(w, 22, 3, 36));
    final reduce = context.reduceMotion;
    final check = AppText.manrope(15, 600, height: 1.5);

    Widget checkRow(String text) => Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('✓', style: AppText.withWeight(check, 800).copyWith(color: scheme.primary)),
        const SizedBox(width: 10),
        Expanded(
          child: Text(text, style: check.copyWith(color: scheme.onSurface)),
        ),
      ],
    );

    return Padding(
      padding: EdgeInsets.only(top: Space.fluid(w, 32, 5, 64)),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: scheme.primaryContainer,
          borderRadius: BorderRadius.only(topLeft: radius, topRight: radius),
        ),
        child: Stack(
          children: [
            Positioned(
              right: -w * .10,
              bottom: -w * .16,
              child: ExcludeSemantics(
                child: Opacity(
                  opacity: .28,
                  child: ScrollShape(
                    from: M3Shape.cookie7,
                    to: M3Shape.sunny,
                    color: scheme.primary,
                    size: Space.fluid(w, 320, 48, 720),
                    rotateTo: 120,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                Space.fluid(w, 18, 4, 72),
                Space.fluid(w, 64, 10, 150),
                Space.fluid(w, 18, 4, 72),
                Space.fluid(w, 110, 10, 150),
              ),
              child: DefaultTextStyle.merge(
                style: TextStyle(color: fg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('CONTACT · THE LAST STEP', style: AppText.manrope(13, 700, tracking: .16)),
                    gap,
                    Reveal(
                      child: Semantics(
                        header: true,
                        child: ScrollWeightText(
                          'flutter build --release',
                          style: AppText.urbanist(Space.fluid(w, 40, 6.4, 104), 800, height: .92, tracking: -.05),
                          from: 200,
                          to: 800,
                          color: fg,
                        ),
                      ),
                    ),
                    gap,
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 520),
                      child: Text(
                        'The command that turns code into an app people can install.',
                        style: AppText.manrope(16, 600, height: 1.5),
                      ),
                    ),
                    gap,
                    Container(
                      constraints: const BoxConstraints(maxWidth: 640),
                      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
                      decoration: BoxDecoration(
                        color: scheme.surface,
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
                          Reveal(child: checkRow('Compiled 5+ years of Flutter')),
                          const SizedBox(height: 8),
                          Reveal(
                            index: 1,
                            child: checkRow('Shipped 3 production apps, built as the sole or lead developer'),
                          ),
                          const SizedBox(height: 8),
                          Reveal(
                            index: 2,
                            child: Row(
                              children: [
                                MorphLoader(
                                  shapes: const [M3Shape.cookie4, M3Shape.sunny, M3Shape.cookie7, M3Shape.clover4],
                                  size: 18,
                                  color: scheme.primary,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    'Waiting for your message…',
                                    style: check.copyWith(color: scheme.onSurfaceVariant),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: Space.fluid(w, 22, 3, 36) + Space.fluid(w, 10, 2, 24)),
                    Reveal(
                      index: 4,
                      child: Semantics(
                        header: true,
                        label: ContactCopy.heading.toString(),
                        child: ExcludeSemantics(
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(text: '${ContactCopy.heading.first}\n'),
                                TextSpan(
                                  text: ContactCopy.heading.second,
                                  style: AppText.withWeight(
                                    AppText.urbanist(Space.fluid(w, 44, 7, 112), 200, height: .9, tracking: -.05),
                                    200,
                                  ),
                                ),
                              ],
                            ),
                            style: AppText.urbanist(Space.fluid(w, 44, 7, 112), 800, height: .9, tracking: -.05),
                          ),
                        ),
                      ),
                    ),
                    gap,
                    Reveal(
                      index: 5,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 560),
                        child: Text(
                          '${ContactCopy.subtitle} ${ContactCopy.responseTime}',
                          style: AppText.manrope(Space.fluid(w, 18, 1.8, 22), 500, height: 1.45),
                        ),
                      ),
                    ),
                    gap,
                    Reveal(
                      index: 6,
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          _WriteButton(onTap: ShellActions.of(context).openContact),
                          CopyAction(
                            text: Identity.email,
                            semanticLabel: 'Copy email ${Identity.email}',
                            focusRadius: BorderRadius.circular(24),
                            builder: (context, s, copied) => AnimatedContainer(
                              duration: M3Spring.fastSpatial.durationOf(context),
                              curve: M3Spring.fastSpatial.curve,
                              height: 68,
                              padding: const EdgeInsets.symmetric(horizontal: 22),
                              decoration: BoxDecoration(
                                color: scheme.surface,
                                borderRadius: BorderRadius.circular(s.hovered ? 34 : 24),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.content_copy_rounded, size: 22, color: scheme.onSurface),
                                  const SizedBox(width: 10),
                                  Flexible(
                                    child: Text(
                                      copied ? Microcopy.copied : Identity.email,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppText.manrope(16, 700).copyWith(color: scheme.onSurface),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    gap,
                    Reveal(
                      index: 7,
                      child: Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 6),
                            child: Text('I CAN HELP WITH', style: AppText.manrope(12, 800, tracking: .14)),
                          ),
                          for (final h in ContactCopy.helpWith)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
                              decoration: BoxDecoration(color: scheme.surface, borderRadius: BorderRadius.circular(10)),
                              child: Text(h, style: AppText.urbanist(14, 700).copyWith(color: scheme.onSurface)),
                            ),
                        ],
                      ),
                    ),
                    gap,
                    Reveal(
                      index: 8,
                      child: Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: [for (final s in Identity.socials) SocialPill(link: s, background: scheme.surface)],
                      ),
                    ),
                    SizedBox(height: Space.fluid(w, 28, 5, 64)),
                    Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 24,
                      runSpacing: 12,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(Microcopy.footerIdentity, style: AppText.manrope(14, 700, height: 1.5)),
                            Text(
                              Microcopy.footer,
                              style: AppText.manrope(14, 600, height: 1.5).copyWith(color: fg.withValues(alpha: .85)),
                            ),
                            if (reduce)
                              Text(
                                Microcopy.reducedMotion,
                                style: AppText.manrope(14, 600, height: 1.5).copyWith(color: fg.withValues(alpha: .85)),
                              ),
                          ],
                        ),
                        _BackToMain(onTap: () => ShellActions.of(context).goTo('home')),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WriteButton extends StatelessWidget {
  const _WriteButton({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final fast = M3Spring.fastSpatial;
    return Pressable(
      onTap: onTap,
      focusRadius: BorderRadius.circular(24),
      builder: (context, s) => AnimatedScale(
        scale: s.pressed ? .96 : 1,
        duration: fast.durationOf(context),
        curve: fast.curve,
        child: AnimatedContainer(
          duration: fast.durationOf(context),
          curve: fast.curve,
          height: 68,
          padding: const EdgeInsets.only(left: 24, right: 30),
          decoration: BoxDecoration(
            color: scheme.primary,
            borderRadius: BorderRadius.circular(s.pressed ? 14 : (s.hovered ? 34 : 24)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.edit_rounded, size: 24, color: scheme.onPrimary),
              AnimatedContainer(duration: fast.durationOf(context), width: s.hovered ? 18 : 12),
              Text(Microcopy.writeMessage, style: AppText.urbanist(18, 800).copyWith(color: scheme.onPrimary)),
            ],
          ),
        ),
      ),
    );
  }
}

class _BackToMain extends StatelessWidget {
  const _BackToMain({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final fast = M3Spring.fastSpatial;
    final style = AppText.manrope(15, 700).copyWith(color: scheme.onSurface);
    return Pressable(
      onTap: onTap,
      semanticLabel: 'Back to main(), scroll to top',
      focusRadius: BorderRadius.circular(24),
      builder: (context, s) => AnimatedContainer(
        duration: fast.durationOf(context),
        curve: fast.curve,
        height: 48,
        padding: const EdgeInsets.only(left: 14, right: 18),
        decoration: BoxDecoration(color: scheme.surface, borderRadius: BorderRadius.circular(s.hovered ? 12 : 24)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.arrow_upward_rounded, size: 20, color: scheme.onSurface),
            const SizedBox(width: 8),
            Text(Microcopy.backToMain, style: style),
            Text('main()', style: AppText.mono(size: 14, weight: 700).copyWith(color: scheme.onSurface)),
          ],
        ),
      ),
    );
  }
}
