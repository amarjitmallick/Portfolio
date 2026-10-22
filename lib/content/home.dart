import 'flags.dart';
import 'models.dart';

/// §2 Hero and §3 Proof strip.
abstract final class HomeCopy {
  static const TwoLine headline = TwoLine('AMARJIT MALLICK.', 'FLUTTER ENGINEER.');

  /// The plain line, for readers who skip the code blocks.
  static const String intro = '5+ years building and shipping Flutter apps for Android, iOS and the web.';

  /// The header block, styled like a `pubspec.yaml`.
  static const List<(String, String)> header = [
    ('name', 'amarjit_mallick'),
    ('description', 'Designed, built, shipped, maintained.'),
    ('experience', '5+ years'),
    ('platforms', 'android · ios · web'),
  ];

  /// Release notes, styled like a changelog.
  static final List<Achievement> releaseNotes = [
    const Achievement(
      'end-to-end ownership of production apps, from architecture to release to maintenance.',
      lead: 'Added:',
    ),
    const Achievement(
      'legacy codebases, migrated to Clean Architecture without a delivery freeze.',
      lead: 'Improved:',
    ),
    const Achievement(
      '40% fewer crash reports on one app, plus secure token storage, root detection and offline recovery on others.',
      lead: 'Reliability:',
    ),
    if (Verify.showReleaseCount)
      const Achievement(
        '20+ production and TestFlight releases across fintech, agritech, e-commerce and enterprise apps.',
        lead: 'Shipped:',
      ),
  ];

  static const String ctaWork = 'View my work';
  static const String ctaContact = 'Get in touch';

  static const List<Stat> stats = [
    Stat(value: '5+', label: 'years in Flutter', shape: 'cookie4', tone: StatTone.tertiaryContainer),
    Stat(
      value: '3',
      label: 'production apps as sole or lead developer',
      shape: 'clover4',
      tone: StatTone.secondaryContainer,
    ),
    Stat(value: '13', label: 'feature modules in one solo-built app', shape: 'sunny', tone: StatTone.primary),
  ];
}
