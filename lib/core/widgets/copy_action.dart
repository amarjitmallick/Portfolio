import 'dart:async';

import 'package:flutter/material.dart';

import '../motion/springs.dart';
import 'pressable.dart';
import 'toast.dart';

/// A pressable that copies [text] and flips to a "copied" state for 1.6s,
/// with the design's small pop.
class CopyAction extends StatefulWidget {
  const CopyAction({
    super.key,
    required this.text,
    required this.builder,
    this.semanticLabel,
    this.focusRadius = const BorderRadius.all(Radius.circular(16)),
  });

  final String text;
  final Widget Function(BuildContext context, PressState state, bool copied) builder;
  final String? semanticLabel;
  final BorderRadius focusRadius;

  @override
  State<CopyAction> createState() => _CopyActionState();
}

class _CopyActionState extends State<CopyAction> {
  bool _copied = false;
  bool _pop = false;
  Timer? _t;
  Timer? _p;

  void _copy() {
    copyText(context, widget.text, silent: true);
    _t?.cancel();
    _p?.cancel();
    setState(() {
      _copied = true;
      _pop = true;
    });
    _p = Timer(const Duration(milliseconds: 160), () => mounted ? setState(() => _pop = false) : null);
    _t = Timer(const Duration(milliseconds: 1600), () => mounted ? setState(() => _copied = false) : null);
  }

  @override
  void dispose() {
    _t?.cancel();
    _p?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fast = M3Spring.fastSpatial;
    return Semantics(
      liveRegion: true,
      child: Pressable(
        onTap: _copy,
        semanticLabel: widget.semanticLabel,
        focusRadius: widget.focusRadius,
        builder: (context, s) => AnimatedScale(
          scale: _pop ? 1.06 : 1,
          duration: fast.durationOf(context),
          curve: fast.curve,
          child: widget.builder(context, s, _copied),
        ),
      ),
    );
  }
}
