import 'dart:math' as math;
import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';

import '../motion/scroll_linked.dart';
import '../motion/springs.dart';

part 'm3e_shapes_data.g.dart';

/// The official Material 3 Expressive shapes used by the design.
enum M3Shape {
  arch,
  arrow,
  bun,
  circle,
  clover4,
  cookie4,
  cookie6,
  cookie7,
  cookie9,
  fan,
  ghost,
  pentagon,
  pill,
  semicircle,
  square,
  sunny;

  /// Outline as 128 points in the unit square, flattened [x0, y0, x1, ...].
  List<double> get outline => _outlines[this]!;

  /// Resolves the prototype's names, including legacy aliases such as
  /// `softBurst` or `cookie12`.
  static M3Shape byName(String name) => m3ShapeAliases[name] ?? M3Shape.values.firstWhere((s) => s.name == name);
}

List<double> _blend(List<double> a, List<double> b, double t) =>
    List<double>.generate(a.length, (i) => a[i] + (b[i] - a[i]) * t, growable: false);

/// A shape sitting somewhere between two outlines [a] and [b]. Every shape
/// morph in the app is a blend of outline points, the same as the design's
/// `clip-path: polygon()` transitions.
@immutable
class MorphShapeBorder extends OutlinedBorder {
  const MorphShapeBorder(this.a, this.b, {this.t = 0, this.rotation = 0, super.side});

  MorphShapeBorder.shape(M3Shape shape, {double rotation = 0, BorderSide side = BorderSide.none})
    : this(shape.outline, shape.outline, rotation: rotation, side: side);

  final List<double> a;
  final List<double> b;

  /// 0 = [a], 1 = [b]. Values past 1 (spring overshoot) extrapolate.
  final double t;

  /// Turns (1.0 = 360°) around the centre. Rotating the outline instead of
  /// the widget keeps child content upright.
  final double rotation;

  /// The current outline as a resting point list.
  List<double> get points => t == 0 ? a : (t == 1 ? b : _blend(a, b, t));

  Path _path(Rect rect) {
    final path = Path();
    final c = rect.center;
    final angle = rotation * 2 * math.pi;
    final cosR = math.cos(angle), sinR = math.sin(angle);
    final n = a.length ~/ 2;
    for (var i = 0; i < n; i++) {
      final px = a[i * 2] + (b[i * 2] - a[i * 2]) * t;
      final py = a[i * 2 + 1] + (b[i * 2 + 1] - a[i * 2 + 1]) * t;
      var x = rect.left + px * rect.width;
      var y = rect.top + py * rect.height;
      if (angle != 0) {
        final dx = x - c.dx, dy = y - c.dy;
        x = c.dx + dx * cosR - dy * sinR;
        y = c.dy + dx * sinR + dy * cosR;
      }
      i == 0 ? path.moveTo(x, y) : path.lineTo(x, y);
    }
    return path..close();
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) => _path(rect);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) => _path(rect.deflate(side.strokeInset));

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(side.strokeInset);

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    if (side.style == BorderStyle.none) return;
    canvas.drawPath(_path(rect.inflate(side.strokeOffset / 2)), side.toPaint());
  }

  @override
  MorphShapeBorder scale(double t) => MorphShapeBorder(a, b, t: this.t, rotation: rotation, side: side.scale(t));

  @override
  MorphShapeBorder copyWith({BorderSide? side}) =>
      MorphShapeBorder(a, b, t: t, rotation: rotation, side: side ?? this.side);

  MorphShapeBorder _towards(MorphShapeBorder other, double k) => MorphShapeBorder(
    points,
    other.points,
    t: k,
    rotation: lerpDouble(rotation, other.rotation, k)!,
    side: BorderSide.lerp(side, other.side, k.clamp(0.0, 1.0)),
  );

  @override
  ShapeBorder? lerpFrom(ShapeBorder? a, double t) => a is MorphShapeBorder ? a._towards(this, t) : super.lerpFrom(a, t);

  @override
  ShapeBorder? lerpTo(ShapeBorder? b, double t) => b is MorphShapeBorder ? _towards(b, t) : super.lerpTo(b, t);

  @override
  bool operator ==(Object other) =>
      other is MorphShapeBorder &&
      identical(other.a, a) &&
      identical(other.b, b) &&
      other.t == t &&
      other.rotation == rotation &&
      other.side == side;

  @override
  int get hashCode => Object.hash(identityHashCode(a), identityHashCode(b), t, rotation, side);
}

/// A box filled (or a child clipped) with an M3 shape. When [shape] or
/// [rotation] changes it springs to the new outline, continuing from
/// wherever an interrupted morph currently is. Content stays upright.
class ShapeBox extends StatefulWidget {
  const ShapeBox({
    super.key,
    required this.shape,
    this.size,
    this.color,
    this.rotation = 0,
    this.spring = M3Spring.slowSpatial,
    this.clip = false,
    this.child,
  });

  final M3Shape shape;
  final double? size;
  final Color? color;

  /// Turns (1.0 = 360°).
  final double rotation;
  final M3Spring spring;

  /// Clip [child] to the shape (photos). Otherwise the child is centred on top.
  final bool clip;
  final Widget? child;

  @override
  State<ShapeBox> createState() => _ShapeBoxState();
}

class _ShapeBoxState extends State<ShapeBox> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(vsync: this, value: 1);
  late List<double> _from = widget.shape.outline;
  late List<double> _to = widget.shape.outline;
  late double _rotFrom = widget.rotation;
  late double _rotTo = widget.rotation;

  double get _t => widget.spring.curve.transform(_c.value);

  @override
  void didUpdateWidget(ShapeBox old) {
    super.didUpdateWidget(old);
    if (old.shape == widget.shape && old.rotation == widget.rotation) return;
    final t = _t;
    _from = t >= 1 ? _to : _blend(_from, _to, t);
    _rotFrom = lerpDouble(_rotFrom, _rotTo, t)!;
    _to = widget.shape.outline;
    _rotTo = widget.rotation;
    if (context.reduceMotion) {
      _c.value = 1;
    } else {
      _c.duration = widget.spring.duration;
      _c.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _c,
      builder: (context, _) {
        final t = _t;
        final border = MorphShapeBorder(_from, _to, t: t, rotation: lerpDouble(_rotFrom, _rotTo, t)!);
        if (widget.clip) {
          return SizedBox(
            width: widget.size,
            height: widget.size,
            child: ClipPath(
              clipper: ShapeBorderClipper(shape: border),
              child: widget.child,
            ),
          );
        }
        return Container(
          width: widget.size,
          height: widget.size,
          decoration: ShapeDecoration(shape: border, color: widget.color),
          child: widget.child == null ? null : Center(child: widget.child),
        );
      },
    );
  }
}

/// A shape whose outline follows scroll progress (`data-scroll-morph`).
class ScrollMorphPainter extends CustomPainter {
  ScrollMorphPainter({
    required this.from,
    required this.to,
    required this.t,
    required this.rotation,
    required this.color,
  });

  final M3Shape from;
  final M3Shape to;
  final double t;
  final double rotation;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final border = MorphShapeBorder(from.outline, to.outline, t: t, rotation: rotation);
    canvas.drawPath(border.getOuterPath(Offset.zero & size), Paint()..color = color);
  }

  @override
  bool shouldRepaint(ScrollMorphPainter old) =>
      old.t != t || old.rotation != rotation || old.color != color || old.from != from || old.to != to;
}

/// Decorative shape that morphs and rotates as it scrolls through the
/// viewport (`data-scroll-morph` + `data-scroll-rot`, "through" mode).
/// Static under reduced motion.
class ScrollShape extends StatelessWidget {
  const ScrollShape({
    super.key,
    required this.from,
    required this.to,
    required this.color,
    this.size,
    this.rotateFrom = 0,
    this.rotateTo = 0,
  });

  final M3Shape from;
  final M3Shape to;
  final Color color;
  final double? size;

  /// Degrees.
  final double rotateFrom;
  final double rotateTo;

  @override
  Widget build(BuildContext context) {
    Widget paint(double p) => SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: ScrollMorphPainter(
          from: from,
          to: to,
          t: p,
          rotation: (rotateFrom + (rotateTo - rotateFrom) * p) / 360,
          color: color,
        ),
      ),
    );
    if (context.reduceMotion) return paint(0);
    return ScrollLinked(track: ScrollTrack.through, builder: (context, p, _) => paint(p));
  }
}
