import 'package:flutter/widgets.dart';

import 'springs.dart';

/// Scrolls [position] to [offset] on the page-scroll spring. A wheel or
/// touch interrupts it (Flutter replaces the activity on user input).
Future<void> springScrollTo(BuildContext context, ScrollPosition position, double offset) {
  final target = offset.clamp(position.minScrollExtent, position.maxScrollExtent);
  if (context.reduceMotion) {
    position.jumpTo(target);
    return Future.value();
  }
  return position.animateTo(target, duration: M3Spring.pageScroll.duration, curve: M3Spring.pageScroll.curve);
}
