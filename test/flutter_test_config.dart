import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

/// Loads the real fonts so text metrics (and overflow checks) match the app
/// instead of the default Ahem test font.
Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  Future<void> load(String family, String path) async {
    final loader = FontLoader(family)..addFont(Future.value(ByteData.sublistView(File(path).readAsBytesSync())));
    await loader.load();
  }

  await load('Urbanist', 'assets/fonts/Urbanist-Variable.ttf');
  await load('Manrope', 'assets/fonts/Manrope-Variable.ttf');
  await testMain();
}
