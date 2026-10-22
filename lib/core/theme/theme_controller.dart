import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'tokens.dart';

/// Theme mode + seed. Dark is the design default; both choices persist.
class ThemeController extends ChangeNotifier {
  ThemeController({ThemeMode initialMode = ThemeMode.dark, int initialSeed = 0, SharedPreferences? storage})
    : _mode = initialMode,
      _seedIndex = initialSeed,
      _prefs = storage;

  static const _modeKey = 'theme.mode';
  static const _seedKey = 'theme.seed';

  /// Reads the saved choices. Falls back to defaults if storage is
  /// unavailable (private windows, blocked storage).
  static Future<ThemeController> load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final mode = prefs.getString(_modeKey) == 'light' ? ThemeMode.light : ThemeMode.dark;
      final seed = (prefs.getInt(_seedKey) ?? 0).clamp(0, seeds.length - 1);
      return ThemeController(initialMode: mode, initialSeed: seed, storage: prefs);
    } catch (_) {
      return ThemeController();
    }
  }

  final SharedPreferences? _prefs;
  ThemeMode _mode;
  int _seedIndex;

  ThemeMode get mode => _mode;
  bool get isDark => _mode == ThemeMode.dark;
  int get seedIndex => _seedIndex;
  Color get seed => seeds[_seedIndex].color;

  void toggleMode() {
    _mode = isDark ? ThemeMode.light : ThemeMode.dark;
    _prefs?.setString(_modeKey, isDark ? 'dark' : 'light');
    notifyListeners();
  }

  /// "Hot reload": advance to the next seed.
  void nextSeed() {
    _seedIndex = (_seedIndex + 1) % seeds.length;
    _prefs?.setInt(_seedKey, _seedIndex);
    notifyListeners();
  }
}

class ThemeScope extends InheritedNotifier<ThemeController> {
  const ThemeScope({super.key, required ThemeController controller, required super.child})
    : super(notifier: controller);

  static ThemeController of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ThemeScope>()!.notifier!;

  /// Access without subscribing to changes (for callbacks).
  static ThemeController read(BuildContext context) => context.getInheritedWidgetOfExactType<ThemeScope>()!.notifier!;
}
