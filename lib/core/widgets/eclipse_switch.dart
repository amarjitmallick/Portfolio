import 'package:flutter/material.dart';

import '../motion/springs.dart';
import '../shapes/m3e_shapes.dart';
import 'pressable.dart';

/// The design's light/dark switch: a sunny sun that slides across, turns
/// round and is eclipsed into a moon, with stars fading in.
class EclipseSwitch extends StatelessWidget {
  const EclipseSwitch({super.key, required this.dark, required this.onToggle, required this.label});

  final bool dark;
  final VoidCallback onToggle;
  final String label;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final track = dark ? scheme.surfaceContainerHighest : scheme.primaryContainer;
    final sun = dark ? scheme.onSurface : scheme.primary;
    final fast = M3Spring.fastSpatial, def = M3Spring.defaultSpatial, slow = M3Spring.slowSpatial;
    final fx = M3Spring.defaultEffects;

    Widget star(double left, double top, double size, int delayMs) => Positioned(
      left: left,
      top: top,
      child: AnimatedOpacity(
        opacity: dark ? .9 : 0,
        duration: fx.durationOf(context) + Duration(milliseconds: delayMs),
        curve: Interval(delayMs / (fx.duration.inMilliseconds + delayMs), 1),
        child: AnimatedScale(
          scale: dark ? 1 : 0,
          duration: def.durationOf(context) + Duration(milliseconds: delayMs),
          curve: Interval(delayMs / (def.duration.inMilliseconds + delayMs), 1, curve: def.curve),
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(color: scheme.onSurface, shape: BoxShape.circle),
          ),
        ),
      ),
    );

    return Semantics(
      toggled: dark,
      child: Pressable(
        onTap: onToggle,
        semanticLabel: label,
        tooltip: label,
        focusRadius: BorderRadius.circular(22),
        builder: (context, s) => AnimatedScale(
          scale: s.pressed ? .92 : 1,
          duration: fast.durationOf(context),
          curve: fast.curve,
          child: AnimatedContainer(
            duration: fast.durationOf(context),
            curve: fast.curve,
            width: 80,
            height: 44,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: track,
              borderRadius: BorderRadius.circular(s.pressed ? 10 : (s.hovered ? 14 : 22)),
            ),
            child: Stack(
              children: [
                star(12, 9, 7, 60),
                star(22, 26, 5, 140),
                star(30, 12, 4, 220),
                AnimatedPositioned(
                  duration: def.durationOf(context),
                  curve: def.curve,
                  left: dark ? 42 : 6,
                  top: 6,
                  width: 32,
                  height: 32,
                  child: AnimatedRotation(
                    turns: dark ? 200 / 360 : 0,
                    duration: slow.durationOf(context),
                    curve: slow.curve,
                    child: AnimatedScale(
                      scale: dark ? .82 : 1,
                      duration: def.durationOf(context),
                      curve: def.curve,
                      child: ShapeBox(
                        shape: dark ? M3Shape.circle : M3Shape.sunny,
                        clip: true,
                        child: AnimatedContainer(
                          duration: fx.durationOf(context),
                          color: sun,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              AnimatedPositioned(
                                duration: slow.durationOf(context),
                                curve: slow.curve,
                                left: dark ? 11 : 36,
                                top: dark ? -7 : -30,
                                width: 28,
                                height: 28,
                                child: AnimatedContainer(
                                  duration: fx.durationOf(context),
                                  decoration: BoxDecoration(color: track, shape: BoxShape.circle),
                                ),
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
        ),
      ),
    );
  }
}
