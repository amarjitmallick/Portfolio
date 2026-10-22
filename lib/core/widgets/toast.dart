import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../content/microcopy.dart';

/// The design's inverse-surface toast (a floating SnackBar).
void showToast(BuildContext context, String message) {
  final messenger = ScaffoldMessenger.of(context);
  messenger.hideCurrentSnackBar();
  messenger.showSnackBar(SnackBar(content: Text(message), duration: const Duration(milliseconds: 2600)));
}

/// Copies [text]; confirms with a toast unless [silent].
Future<void> copyText(BuildContext context, String text, {bool silent = false}) async {
  await Clipboard.setData(ClipboardData(text: text));
  if (!silent && context.mounted) showToast(context, Microcopy.copied);
}
