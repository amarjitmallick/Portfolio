import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'app/app.dart';
import 'core/theme/theme_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  // Build the semantics tree up front: screen readers work without the
  // "enable accessibility" button, and crawlers that run JS see real text.
  SemanticsBinding.instance.ensureSemantics();
  final theme = await ThemeController.load();
  runApp(PortfolioApp(theme: theme));
}
