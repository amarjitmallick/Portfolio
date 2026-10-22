import 'package:flutter/material.dart';

import '../theme/typography.dart';
import 'springs.dart';

/// How scroll progress is measured, matching the design runtime:
/// - [enter]: 0 when the widget's top reaches the viewport bottom, 1 after it
///   has travelled 90% of the viewport.
/// - [through]: 0 at the viewport bottom, 1 when it has left the top.
enum ScrollTrack { enter, through }

/// Rebuilds [builder] with the widget's scroll progress (0..1) in the
/// nearest vertical scrollable. Only this subtree rebuilds on scroll.
class ScrollLinked extends StatefulWidget {
  const ScrollLinked({super.key, this.track = ScrollTrack.enter, required this.builder, this.child});

  final ScrollTrack track;
  final Widget Function(BuildContext context, double progress, Widget? child) builder;
  final Widget? child;

  @override
  State<ScrollLinked> createState() => _ScrollLinkedState();
}

class _ScrollLinkedState extends State<ScrollLinked> {
  ScrollPosition? _position;
  double _p = 0;
  bool _queued = false;

  void _onScroll() {
    if (_queued) return;
    _queued = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _queued = false;
      _update();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final position = Scrollable.maybeOf(context, axis: Axis.vertical)?.position;
    if (position != _position) {
      _position?.removeListener(_onScroll);
      _position = position;
      _position?.addListener(_onScroll);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) => _update());
  }

  void _update() {
    if (!mounted) return;
    final box = context.findRenderObject() as RenderBox?;
    if (box == null || !box.attached || !box.hasSize) return;
    final vh = MediaQuery.sizeOf(context).height;
    final top = box.localToGlobal(Offset.zero).dy;
    if (top > vh * 2 || top + box.size.height < -vh) return;
    final p = switch (widget.track) {
      ScrollTrack.enter => ((vh - top) / (vh * .9)).clamp(0.0, 1.0),
      ScrollTrack.through => ((vh - top) / (vh + box.size.height)).clamp(0.0, 1.0),
    };
    // Quantise so tiny scrolls don't rebuild (text relayout is the costly part).
    final q = (p * 40).round() / 40;
    if (q != _p) setState(() => _p = q);
  }

  @override
  void dispose() {
    _position?.removeListener(_onScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, _p, widget.child);
}

/// Text whose weight follows scroll position (`data-scroll-wght`).
class ScrollWeightText extends StatelessWidget {
  const ScrollWeightText(this.text, {super.key, required this.style, required this.from, required this.to, this.color});

  final String text;
  final TextStyle style;
  final double from;
  final double to;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final s = color == null ? style : style.copyWith(color: color);
    return ScrollLinked(
      builder: (context, p, _) {
        final w = ((from + (to - from) * p) / 25).round() * 25.0;
        return Text(text, style: AppText.withWeight(s, w));
      },
    );
  }
}

/// Rotation (degrees) linked to scroll, disabled under reduced motion.
class ScrollRotate extends StatelessWidget {
  const ScrollRotate({super.key, required this.from, required this.to, required this.child});

  final double from;
  final double to;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (context.reduceMotion) return child;
    return ScrollLinked(
      track: ScrollTrack.through,
      child: child,
      builder: (context, p, child) =>
          Transform.rotate(angle: (from + (to - from) * p) * 3.14159265 / 180, child: child),
    );
  }
}
