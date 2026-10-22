import 'package:flutter/foundation.dart';

/// Role shown in Career. Lives above the routes so a project's "built at"
/// link (on the detail page) can pick it before navigating.
final ValueNotifier<int> selectedRole = ValueNotifier(0);
