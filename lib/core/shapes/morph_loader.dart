import 'dart:async';

import 'package:flutter/material.dart';

import '../motion/springs.dart';
import 'm3e_shapes.dart';

/// M3 Expressive loading indicator: a shape that morphs and turns every
/// 650ms. Holds still under reduced motion.
class MorphLoader extends StatefulWidget {
  const MorphLoader({super.key, required this.shapes, required this.size, required this.color});

  final List<M3Shape> shapes;
  final double size;
  final Color color;

  @override
  State<MorphLoader> createState() => _MorphLoaderState();
}

class _MorphLoaderState extends State<MorphLoader> {
  Timer? _timer;
  int _i = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _timer?.cancel();
    if (!context.reduceMotion) {
      _timer = Timer.periodic(const Duration(milliseconds: 650), (_) => setState(() => _i++));
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Loading',
      child: ShapeBox(
        shape: widget.shapes[_i % widget.shapes.length],
        rotation: _i * 140 / 360,
        spring: M3Spring.fastSpatial,
        size: widget.size,
        color: widget.color,
      ),
    );
  }
}
