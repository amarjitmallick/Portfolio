import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:flutter/physics.dart';

import '../motion/springs.dart';

/// M3 Expressive wavy linear progress. [value] null = indeterminate.
/// The wave keeps moving while visible; it's flat-still under reduced motion.
class WavyProgress extends StatefulWidget {
  const WavyProgress({
    super.key,
    required this.value,
    required this.activeColor,
    required this.trackColor,
    this.amplitude = 3,
    this.wavelength = 28,
    this.height = 14,
    this.semanticLabel,
  });

  final double? value;
  final Color activeColor;
  final Color trackColor;
  final double amplitude;
  final double wavelength;
  final double height;
  final String? semanticLabel;

  @override
  State<WavyProgress> createState() => _WavyProgressState();
}

class _WavyProgressState extends State<WavyProgress> with TickerProviderStateMixin {
  late final AnimationController _phase = AnimationController(vsync: this, duration: const Duration(seconds: 3));
  late final AnimationController _value = AnimationController(vsync: this, value: widget.value ?? 0);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (context.reduceMotion) {
      _phase.stop();
    } else if (!_phase.isAnimating) {
      _phase.repeat();
    }
  }

  @override
  void didUpdateWidget(WavyProgress old) {
    super.didUpdateWidget(old);
    final v = widget.value;
    if (v != null && v != old.value) {
      final s = M3Spring.defaultSpatial;
      if (context.reduceMotion) {
        _value.value = v;
      } else {
        _value.animateWith(_springTo(_value.value, v, s));
      }
    }
  }

  Simulation _springTo(double from, double to, M3Spring s) => _Spring(s, from, to);

  @override
  void dispose() {
    _phase.dispose();
    _value.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: widget.semanticLabel,
      value: widget.value == null ? null : '${(widget.value! * 100).round()}%',
      child: SizedBox(
        height: widget.height,
        child: CustomPaint(
          size: Size.infinite,
          painter: _WavePainter(
            phase: _phase,
            value: _value,
            indeterminate: widget.value == null,
            amplitude: widget.amplitude,
            wavelength: widget.wavelength,
            active: widget.activeColor,
            track: widget.trackColor,
          ),
        ),
      ),
    );
  }
}

class _Spring extends Simulation {
  _Spring(M3Spring s, this.from, this.to) : _sim = SpringSimulation(s.description, 0, 1, 0);
  final double from;
  final double to;
  final SpringSimulation _sim;

  @override
  double x(double t) => from + (to - from) * _sim.x(t);
  @override
  double dx(double t) => (to - from) * _sim.dx(t);
  @override
  bool isDone(double t) => _sim.isDone(t);
}

class _WavePainter extends CustomPainter {
  _WavePainter({
    required this.phase,
    required this.value,
    required this.indeterminate,
    required this.amplitude,
    required this.wavelength,
    required this.active,
    required this.track,
  }) : super(repaint: Listenable.merge([phase, value]));

  final Animation<double> phase;
  final Animation<double> value;
  final bool indeterminate;
  final double amplitude;
  final double wavelength;
  final Color active;
  final Color track;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width, mid = size.height / 2;
    final ph = phase.value * 2 * math.pi * 4;
    var start = 0.0, v = value.value.clamp(0.0, 1.0);
    if (indeterminate) {
      final t = (phase.value * 1.5) % 1.4;
      start = math.max(0, t - .4) * w;
      v = math.min(1, t);
    }
    final end = math.max(start, v * w);
    final stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
    final path = Path();
    for (var x = start; x <= end; x += 2) {
      final y = mid + amplitude * math.sin(x / wavelength * 2 * math.pi - ph);
      x == start ? path.moveTo(x, y) : path.lineTo(x, y);
    }
    if (end + 8 < w - 2) {
      canvas.drawLine(Offset(end + 8, mid), Offset(w - 2, mid), stroke..color = track);
    }
    canvas.drawPath(path, stroke..color = active);
    canvas.drawCircle(Offset(w - 2, mid), 2, Paint()..color = active);
  }

  @override
  bool shouldRepaint(_WavePainter old) =>
      old.indeterminate != indeterminate || old.active != active || old.track != track;
}
