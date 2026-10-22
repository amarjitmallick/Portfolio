import 'package:flutter/material.dart';

/// What sections can ask the page shell to do.
abstract class ShellActions {
  /// Navigate (and spring-scroll) to a section id.
  void goTo(String sectionId);

  /// Open the 3-step contact sheet.
  void openContact();

  /// Show the inverse-surface toast.
  void toast(String message);

  /// Copy [text] and confirm with the design's toast.
  void copy(String text);

  static ShellActions of(BuildContext context) => context.getInheritedWidgetOfExactType<ShellActionsScope>()!.actions;
}

class ShellActionsScope extends InheritedWidget {
  const ShellActionsScope({super.key, required this.actions, required super.child});

  final ShellActions actions;

  @override
  bool updateShouldNotify(ShellActionsScope old) => old.actions != actions;
}
