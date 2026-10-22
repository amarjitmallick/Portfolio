import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

/// M3 Expressive motion scheme as used by the design (mass 1).
/// Spatial springs may overshoot; effects springs are critically damped and
/// are the ones to use for opacity and colour.
class M3Spring {
  const M3Spring._(this.dampingRatio, this.stiffness);

  final double dampingRatio;
  final double stiffness;

  static const fastSpatial = M3Spring._(0.6, 800);
  static const defaultSpatial = M3Spring._(0.8, 380);
  static const slowSpatial = M3Spring._(0.8, 200);
  static const fastEffects = M3Spring._(1, 3800);
  static const defaultEffects = M3Spring._(1, 1600);
  static const slowEffects = M3Spring._(1, 800);

  /// Page scroll: slow, critically damped so it never overshoots the page end.
  static const pageScroll = M3Spring._(1, 170);

  SpringDescription get description =>
      SpringDescription.withDampingRatio(mass: 1, stiffness: stiffness, ratio: dampingRatio);

  /// Settle time: the first moment the spring stays within 0.2% of rest for
  /// the next 300ms (same rule the design runtime uses).
  Duration get duration => _durations[this] ??= _settle();

  /// The spring expressed as a [Curve] over [duration], for implicit
  /// animations (`AnimatedContainer`, `AnimatedSlide`, ...).
  Curve get curve => _curves[this] ??= _SpringCurve(this, duration);

  /// [duration], or zero when the platform asks for reduced motion.
  Duration durationOf(BuildContext context) =>
      MediaQuery.maybeDisableAnimationsOf(context) ?? false ? Duration.zero : duration;

  Duration _settle() {
    final sim = SpringSimulation(description, 0, 1, 0);
    var t = 0.05;
    while (t < 3) {
      var ok = true;
      for (var u = t; u < t + 0.3; u += 0.01) {
        if ((1 - sim.x(u)).abs() > 0.002) {
          ok = false;
          break;
        }
      }
      if (ok) break;
      t += 0.01;
    }
    return Duration(milliseconds: (t * 1000).round());
  }

  static final Map<M3Spring, Duration> _durations = {};
  static final Map<M3Spring, Curve> _curves = {};
}

class _SpringCurve extends Curve {
  _SpringCurve(M3Spring spring, Duration duration)
    : _sim = SpringSimulation(spring.description, 0, 1, 0),
      _seconds = duration.inMicroseconds / Duration.microsecondsPerSecond;

  final SpringSimulation _sim;
  final double _seconds;

  @override
  double transform(double t) => t >= 1 ? 1 : (t <= 0 ? 0 : _sim.x(t * _seconds));
}

/// Shorthand for building the design's transitions.
extension SpringContext on BuildContext {
  bool get reduceMotion => MediaQuery.maybeDisableAnimationsOf(this) ?? false;
}
