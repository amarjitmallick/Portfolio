import 'models.dart';

/// §8 Notes. The posts are the owner's real, published Hashnode articles
/// (as listed in the design prototype), not the §8 post ideas.
abstract final class NotesCopy {
  static const TwoLine heading = TwoLine('FIELD', 'NOTES');
  static const String subtitle = 'Patterns and lessons, written down.';
  static const String emptyState = 'Nothing published here yet. The first note is being compiled.';
  static const String blogUrl = 'https://amarjitmallick.hashnode.dev/';

  static const List<Post> posts = [
    Post(
      title: "Supercharging UI Development with Flutter's Widget Previewer",
      tags: ['Flutter', 'Tooling'],
      url: 'https://amarjitmallick.hashnode.dev/supercharging-ui-development-with-flutters-widget-previewer',
    ),
    Post(
      title: 'Understanding Method Channels in Flutter',
      tags: ['Flutter', 'Platform channels'],
      url: 'https://amarjitmallick.hashnode.dev/understanding-method-channels-in-flutter',
    ),
    Post(
      title: 'The Flutter Widget Lifecycle Explained: From Birth to Goodbye!',
      tags: ['Flutter', 'Widgets'],
      url: 'https://amarjitmallick.hashnode.dev/the-flutter-widget-lifecycle-explained-from-birth-to-goodbye',
    ),
    Post(
      title: 'Streamline Your Flutter CI/CD: Integration Testing with Firebase Test Lab on GitHub Actions (Part 1)',
      tags: ['CI/CD', 'Firebase Test Lab', 'GitHub Actions'],
      date: 'Jun 1, 2024',
      url: 'https://amarjitmallick.hashnode.dev/integration-testing-with-firebase-test-lab-on-github-actions-part-1',
    ),
    Post(
      title: 'An Introduction to Object Oriented Programming in Dart',
      tags: ['Dart', 'OOP'],
      date: 'May 10, 2023 · 3 min read',
      url: 'https://amarjitmallick.hashnode.dev/a-basic-introduction-to-object-oriented-programming-in-dart',
    ),
  ];
}
