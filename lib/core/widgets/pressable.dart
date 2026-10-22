import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Interaction state handed to [Pressable.builder].
class PressState {
  const PressState({this.hovered = false, this.pressed = false, this.focused = false});
  final bool hovered;
  final bool pressed;
  final bool focused;
}

/// The one interactive primitive: pointer + keyboard activation, hover and
/// press states for the design's shape changes, a visible focus ring, a
/// click cursor and button semantics. Rebuilds only itself on hover.
class Pressable extends StatefulWidget {
  const Pressable({
    super.key,
    required this.onTap,
    required this.builder,
    this.semanticLabel,
    this.tooltip,
    this.focusRadius = const BorderRadius.all(Radius.circular(16)),
    this.selected,
    this.enabled = true,
    this.isLink = false,
    this.focusNode,
    this.autofocus = false,
    this.onSecondaryTap,
  });

  final VoidCallback? onTap;
  final VoidCallback? onSecondaryTap;
  final Widget Function(BuildContext context, PressState state) builder;
  final String? semanticLabel;
  final String? tooltip;
  final BorderRadius focusRadius;
  final bool? selected;
  final bool enabled;
  final bool isLink;
  final FocusNode? focusNode;
  final bool autofocus;

  @override
  State<Pressable> createState() => _PressableState();
}

class _PressableState extends State<Pressable> {
  bool _hovered = false;
  bool _pressed = false;
  bool _focused = false;

  bool get _active => widget.enabled && widget.onTap != null;

  void _activate() {
    if (!_active) return;
    widget.onTap!();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    Widget child = widget.builder(
      context,
      PressState(hovered: _hovered && _active, pressed: _pressed, focused: _focused),
    );
    child = CustomPaint(
      foregroundPainter: _focused ? _FocusRingPainter(scheme.primary, widget.focusRadius) : null,
      child: child,
    );
    child = FocusableActionDetector(
      enabled: _active,
      focusNode: widget.focusNode,
      autofocus: widget.autofocus,
      mouseCursor: _active ? SystemMouseCursors.click : SystemMouseCursors.basic,
      onShowHoverHighlight: (v) => setState(() => _hovered = v),
      onShowFocusHighlight: (v) => setState(() => _focused = v),
      shortcuts: const {
        SingleActivator(LogicalKeyboardKey.enter): ActivateIntent(),
        SingleActivator(LogicalKeyboardKey.space): ActivateIntent(),
      },
      actions: {ActivateIntent: CallbackAction<ActivateIntent>(onInvoke: (_) => _activate())},
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: _active ? (_) => setState(() => _pressed = true) : null,
        onTapUp: _active ? (_) => setState(() => _pressed = false) : null,
        onTapCancel: _active ? () => setState(() => _pressed = false) : null,
        onTap: _active ? _activate : null,
        onSecondaryTap: widget.onSecondaryTap,
        child: child,
      ),
    );
    child = Semantics(
      button: !widget.isLink,
      link: widget.isLink,
      enabled: _active,
      selected: widget.selected,
      label: widget.semanticLabel,
      excludeSemantics: widget.semanticLabel != null,
      onTap: _active ? _activate : null,
      child: child,
    );
    if (widget.tooltip != null) child = Tooltip(message: widget.tooltip!, excludeFromSemantics: true, child: child);
    return child;
  }
}

class _FocusRingPainter extends CustomPainter {
  _FocusRingPainter(this.color, this.radius);
  final Color color;
  final BorderRadius radius;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = (Offset.zero & size).inflate(3);
    canvas.drawRRect(
      radius.toRRect(rect),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3
        ..color = color,
    );
  }

  @override
  bool shouldRepaint(_FocusRingPainter old) => old.color != color || old.radius != radius;
}
