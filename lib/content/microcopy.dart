import 'identity.dart';

/// §10 Microcopy, plus the interface strings that only exist in the design
/// prototype (marked "design"; all listed in docs/BUILD_NOTES.md).
abstract final class Microcopy {
  // Navigation (design: five items; "Blog" for the Notes section).
  static const List<({String id, String label})> nav = [
    (id: 'home', label: 'Home'),
    (id: 'work', label: 'Work'),
    (id: 'career', label: 'Career'),
    (id: 'about', label: 'About'),
    (id: 'notes', label: 'Blog'),
  ];
  static const String contact = 'Contact';

  static const String loading = 'Running flutter pub get…';
  static const String notFound = "Null check operator used on a null value. (Just kidding, this page doesn't exist.)";
  static const String footer = 'Built with Flutter.';
  static const String hotReload = 'Hot reload';
  static const String hotReloadToast = 'Reloaded in 0.4s. Seed color changed.';
  static const String copyEmail = 'Copy email';
  static const String copied = 'Copied. Go on, write it.';
  static const String backToMain = 'Back to ';
  static const String reducedMotion = 'Animations are off. Everything still works.';

  // Design-originated interface strings.
  static const String switchToLight = 'Switch to light';
  static const String switchToDark = 'Switch to dark';
  static const String lightDark = 'Light / dark';
  static const String writeMessage = 'Write a message';
  static const String moreActions = 'More actions';
  static const String fabMobileTitle = 'Hot reload, theme, contact';
  static const String footerIdentity = '${Identity.name} · ${Identity.title}';
}
