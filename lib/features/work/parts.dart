import 'package:flutter/material.dart';

import '../../content/models.dart';
import '../../content/projects.dart';
import '../../core/motion/springs.dart';
import '../../core/theme/typography.dart';
import '../../core/widgets/pressable.dart';
import '../../core/widgets/toast.dart';

/// Specimen fill for a project: an abstract device colour for case files,
/// the icon's own background for public apps.
({Color bg, Color fg}) projectColors(ColorScheme s, Project p) => switch (p) {
  PublicProject(:final iconBackground) => (bg: Color(iconBackground), fg: s.onSurface),
  RedactedCaseFile(device: Device.tablet) => (bg: s.tertiaryContainer, fg: s.onTertiaryContainer),
  RedactedCaseFile(device: Device.phone) => (bg: s.secondaryContainer, fg: s.onSecondaryContainer),
  RedactedCaseFile(device: Device.ipad) => (bg: s.primaryContainer, fg: s.onPrimaryContainer),
};

IconData deviceIcon(Device d) => switch (d) {
  Device.tablet => Icons.tablet_android_rounded,
  Device.phone => Icons.smartphone_rounded,
  Device.ipad => Icons.tablet_mac_rounded,
};

/// The specimen artwork: the public app icon, or an abstract device glyph
/// for a case file. Never imagery from a redacted product.
class ProjectArt extends StatelessWidget {
  const ProjectArt({
    super.key,
    required this.project,
    required this.iconSize,
    this.fraction = .72,
    this.thumbnail = false,
  });

  final Project project;
  final double iconSize;
  final double fraction;

  /// Small catalog thumbnail (image fills, no inner rounding).
  final bool thumbnail;

  @override
  Widget build(BuildContext context) {
    final colors = projectColors(Theme.of(context).colorScheme, project);
    final p = project;
    return Semantics(
      image: true,
      label: p.imageLabel,
      child: ExcludeSemantics(
        child: switch (p) {
          PublicProject(:final image) => FractionallySizedBox(
            widthFactor: thumbnail ? 1.18 : fraction,
            heightFactor: thumbnail ? 1.18 : fraction,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(thumbnail ? 0 : iconSize * .14),
              child: Image.asset(image, fit: BoxFit.cover, filterQuality: FilterQuality.medium),
            ),
          ),
          RedactedCaseFile(:final device) => Icon(deviceIcon(device), size: iconSize, color: colors.fg),
        },
      ),
    );
  }
}

/// The blacked-out name bar on case files. Hover or focus floats the NDA
/// line in a pill above the bar; tap shows it as a toast. The bar itself
/// never changes, and nothing else is ever revealed.
class RedactionBar extends StatefulWidget {
  const RedactionBar({
    super.key,
    required this.fontSize,
    required this.ink,
    this.widthEm = 4.2,
  });

  final double fontSize;
  final Color ink;
  final double widthEm;

  @override
  State<RedactionBar> createState() => _RedactionBarState();
}

class _RedactionBarState extends State<RedactionBar> {
  final _link = LayerLink();
  final _portal = OverlayPortalController();

  @override
  void initState() {
    super.initState();
    // The pill ignores the pointer and fades to nothing, so it can stay mounted.
    _portal.show();
  }

  @override
  Widget build(BuildContext context) {
    final fast = M3Spring.fastSpatial;
    final radius = BorderRadius.circular(widget.fontSize * .12);
    return Pressable(
      onTap: () => showToast(context, WorkCopy.redactedHover),
      semanticLabel: 'Name redacted. ${WorkCopy.redactedHover}',
      focusRadius: radius,
      builder: (context, s) => OverlayPortal(
        controller: _portal,
        overlayChildBuilder: (context) => _NdaPill(link: _link, visible: s.hovered || s.focused),
        child: CompositedTransformTarget(
          link: _link,
          child: AnimatedScale(
            scale: s.pressed ? .96 : (s.hovered ? 1.02 : 1),
            duration: fast.durationOf(context),
            curve: fast.curve,
            child: Container(
              width: widget.fontSize * widget.widthEm,
              height: widget.fontSize * .74,
              decoration: BoxDecoration(color: widget.ink, borderRadius: radius),
            ),
          ),
        ),
      ),
    );
  }
}

/// The NDA line, floated above a [RedactionBar].
class _NdaPill extends StatelessWidget {
  const _NdaPill({required this.link, required this.visible});

  final LayerLink link;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final spatial = M3Spring.fastSpatial;
    final effects = M3Spring.fastEffects;
    return Align(
      alignment: Alignment.topLeft,
      child: CompositedTransformFollower(
        link: link,
        showWhenUnlinked: false,
        targetAnchor: Alignment.topCenter,
        followerAnchor: Alignment.bottomCenter,
        offset: const Offset(0, -8),
        child: IgnorePointer(
          child: AnimatedOpacity(
            opacity: visible ? 1 : 0,
            duration: effects.durationOf(context),
            curve: effects.curve,
            child: AnimatedScale(
              scale: visible ? 1 : .9,
              alignment: Alignment.bottomCenter,
              duration: spatial.durationOf(context),
              curve: spatial.curve,
              child: DecoratedBox(
                decoration: ShapeDecoration(
                  color: scheme.inverseSurface,
                  shape: const StadiumBorder(),
                  shadows: const [BoxShadow(color: Color(0x33000000), blurRadius: 12, offset: Offset(0, 4))],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  child: Text(
                    WorkCopy.redactedHover,
                    maxLines: 1,
                    softWrap: false,
                    style: AppText.manrope(13, 700, tracking: .02).copyWith(color: scheme.onInverseSurface),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Project title with the redaction bar for case files.
class ProjectTitle extends StatelessWidget {
  const ProjectTitle({
    super.key,
    required this.project,
    required this.style,
    required this.ink,
    this.barWidthEm = 4.2,
    this.center = false,
  });

  final Project project;
  final TextStyle style;
  final Color ink;
  final double barWidthEm;
  final bool center;

  @override
  Widget build(BuildContext context) {
    final size = style.fontSize ?? 40;
    if (project is! RedactedCaseFile) {
      return Text(project.displayTitle, style: style, textAlign: center ? TextAlign.center : TextAlign.start);
    }
    return Wrap(
      alignment: center ? WrapAlignment.center : WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: size * .22,
      children: [
        Text(project.displayTitle, style: style),
        RedactionBar(fontSize: size, ink: ink, widthEm: barWidthEm),
      ],
    );
  }
}

/// The two cards: the condition the app had to meet, and what it achieved.
class ConstraintOutcome extends StatelessWidget {
  const ConstraintOutcome({super.key, required this.project, required this.width});

  final Project project;

  /// Width available to the pair; side by side from 524px.
  final double width;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final hasConstraint = project.constraint.isNotEmpty;
    final twoUp = width >= 260 * 2 + 4;
    final constraint = _Card(
      label: WorkCopy.constraintLabel,
      icon: Icons.flag_rounded,
      iconColor: scheme.onSurfaceVariant,
      text: project.constraint,
      bg: scheme.surfaceContainerHigh,
      hoverBg: scheme.surfaceContainerHighest,
      fg: scheme.onSurface,
      labelColor: scheme.onSurfaceVariant,
      rest: const BorderRadius.horizontal(left: Radius.circular(28), right: Radius.circular(6)),
      hover: const BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(6),
        bottomRight: Radius.circular(6),
        bottomLeft: Radius.circular(40),
      ),
      shift: const Offset(-3, -3),
    );
    final outcome = _Card(
      label: WorkCopy.outcomeLabel,
      icon: Icons.check_circle_rounded,
      iconColor: scheme.onPrimaryContainer,
      text: project.outcome,
      bg: scheme.primaryContainer,
      hoverBg: Color.lerp(scheme.primaryContainer, Colors.white, .06)!,
      fg: scheme.onPrimaryContainer,
      labelColor: scheme.onPrimaryContainer,
      rest: const BorderRadius.horizontal(left: Radius.circular(6), right: Radius.circular(28)),
      hover: const BorderRadius.only(
        topLeft: Radius.circular(6),
        topRight: Radius.circular(40),
        bottomRight: Radius.circular(12),
        bottomLeft: Radius.circular(6),
      ),
      shift: const Offset(3, -3),
    );
    if (!hasConstraint) return outcome;
    if (!twoUp) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [constraint, const SizedBox(height: 4), outcome],
      );
    }
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: constraint),
          const SizedBox(width: 4),
          Expanded(child: outcome),
        ],
      ),
    );
  }
}

class _Card extends StatefulWidget {
  const _Card({
    required this.label,
    required this.icon,
    required this.iconColor,
    required this.text,
    required this.bg,
    required this.hoverBg,
    required this.fg,
    required this.labelColor,
    required this.rest,
    required this.hover,
    required this.shift,
  });

  final String label;
  final IconData icon;
  final Color iconColor;
  final String text;
  final Color bg;
  final Color hoverBg;
  final Color fg;
  final Color labelColor;
  final BorderRadius rest;
  final BorderRadius hover;
  final Offset shift;

  @override
  State<_Card> createState() => _CardState();
}

class _CardState extends State<_Card> {
  bool _h = false;

  @override
  Widget build(BuildContext context) {
    final def = M3Spring.defaultSpatial;
    return MouseRegion(
      onEnter: (_) => setState(() => _h = true),
      onExit: (_) => setState(() => _h = false),
      child: AnimatedContainer(
        duration: def.durationOf(context),
        curve: def.curve,
        transform: Matrix4.translationValues(_h ? widget.shift.dx : 0, _h ? widget.shift.dy : 0, 0),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          color: _h ? widget.hoverBg : widget.bg,
          borderRadius: _h ? widget.hover : widget.rest,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(widget.icon, size: 16, color: widget.iconColor),
                const SizedBox(width: 6),
                Text(widget.label, style: AppText.manrope(12, 700, tracking: .12).copyWith(color: widget.labelColor)),
              ],
            ),
            const SizedBox(height: 8),
            Text(widget.text, style: AppText.urbanist(16, 500, height: 1.5).copyWith(color: widget.fg)),
          ],
        ),
      ),
    );
  }
}

/// "play.google.com/…" for public apps; the not-public line otherwise.
String linkText(Project p) => p is PublicProject ? p.url.replaceFirst('https://', '') : WorkCopy.notPublic;
