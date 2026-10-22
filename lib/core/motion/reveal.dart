import 'package:flutter/material.dart';

import 'springs.dart';

/// Entrance choreography: fade in, rise 32px and scale from .96, staggered
/// by [index] × 70ms. Triggered when the widget first scrolls into view (not
/// on mount). Shows immediately under reduced motion.
class Reveal extends StatefulWidget {
  const Reveal({super.key, this.index = 0, required this.child});

  final int index;
  final Widget child;

  static const stagger = Duration(milliseconds: 70);

  @override
  State<Reveal> createState() => _RevealState();
}

class _RevealState extends State<Reveal> with SingleTickerProviderStateMixin {
  // The stagger delay is the start of the animation itself (vsync-driven,
  // no timers), so the entrance can't stall on a throttled timer.
  late final Duration _delay = Reveal.stagger * widget.index;
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: _delay + M3Spring.slowSpatial.duration,
  );
  late final double _start = _delay.inMicroseconds / _c.duration!.inMicroseconds;
  late final Animation<double> _fade = CurvedAnimation(
    parent: _c,
    curve: Interval(_start, 1, curve: M3Spring.slowEffects.curve),
  );
  late final Animation<double> _rise = CurvedAnimation(
    parent: _c,
    curve: Interval(_start, 1, curve: M3Spring.slowSpatial.curve),
  );
  late final Animation<double> _scale = CurvedAnimation(
    parent: _c,
    curve: Interval(_start, 1, curve: M3Spring.defaultSpatial.curve),
  );
  ScrollPosition? _position;
  bool _started = false;
  bool _queued = false;

  // Scroll notifications fire before layout moves the children, so measure
  // after the frame instead.
  void _onScroll() {
    if (_queued || _started) return;
    _queued = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _queued = false;
      _check();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (context.reduceMotion) {
      _c.value = 1;
      _started = true;
    }
    final position = Scrollable.maybeOf(context, axis: Axis.vertical)?.position;
    if (position != _position) {
      _position?.removeListener(_onScroll);
      _position = position;
      _position?.addListener(_onScroll);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) => _check());
  }

  void _check() {
    if (_started || !mounted) return;
    final box = context.findRenderObject() as RenderBox?;
    if (box == null || !box.attached || !box.hasSize) return;
    final top = box.localToGlobal(Offset.zero).dy;
    final viewport = MediaQuery.sizeOf(context).height;
    // Same as an IntersectionObserver with a 5% threshold.
    if (top < viewport - box.size.height * 0.05 && top + box.size.height > 0) {
      _started = true;
      _position?.removeListener(_onScroll);
      _c.forward();
    }
  }

  @override
  void dispose() {
    _position?.removeListener(_onScroll);
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _c,
      child: widget.child,
      // Keep the same widget structure when complete so children never remount.
      builder: (context, child) {
        return Opacity(
          opacity: _fade.value.clamp(0.0, 1.0),
          alwaysIncludeSemantics: true,
          child: Transform.translate(
            offset: Offset(0, 32 * (1 - _rise.value)),
            child: Transform.scale(scale: .96 + .04 * _scale.value, child: child),
          ),
        );
      },
    );
  }
}

/// Plays the same entrance whenever [keyValue] changes (the design's
/// `key=` + `data-enter` swaps: switching project, role or tab).
class SwapReveal extends StatelessWidget {
  const SwapReveal({super.key, required this.keyValue, this.index = 0, required this.child});

  final Object keyValue;
  final int index;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (context.reduceMotion) return child;
    return TweenAnimationBuilder<double>(
      key: ValueKey(keyValue),
      tween: Tween(begin: 0, end: 1),
      duration: M3Spring.slowSpatial.duration + Reveal.stagger * index,
      curve: Interval(
        index == 0
            ? 0
            : (Reveal.stagger * index).inMilliseconds /
                  (M3Spring.slowSpatial.duration + Reveal.stagger * index).inMilliseconds,
        1,
        curve: M3Spring.slowSpatial.curve,
      ),
      child: child,
      builder: (context, t, child) => Opacity(
        opacity: t.clamp(0.0, 1.0),
        alwaysIncludeSemantics: true,
        child: Transform.translate(offset: Offset(0, 32 * (1 - t)), child: child),
      ),
    );
  }
}
