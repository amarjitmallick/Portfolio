/// Typed content models. All copy lives in `lib/content/` and is taken
/// verbatim from docs/NEW_SITE_CONTENT_v4.md (or, where noted, from the
/// design prototype: see docs/BUILD_NOTES.md).
library;

/// A string split across the design's two-line heading pattern
/// (`LINE 1 / LINE 2`, second line in the accent tone).
class TwoLine {
  const TwoLine(this.first, this.second);
  final String first;
  final String second;

  @override
  String toString() => '$first $second';
}

class SocialLink {
  const SocialLink({required this.label, required this.url});
  final String label;
  final String url;
}

class Stat {
  const Stat({required this.value, required this.label, required this.shape, required this.tone});
  final String value;
  final String label;

  /// Shape name from the design (resolved with `M3Shape.byName`).
  final String shape;
  final StatTone tone;
}

enum StatTone { tertiaryContainer, secondaryContainer, primary, primaryContainer, surfaceHighest }

/// Device glyph for a project specimen.
enum Device { tablet, phone, ipad }

/// Every catalog entry. Public projects and redacted case files are
/// separate types: a [RedactedCaseFile] has no name, URL or image fields at
/// all, so the UI cannot render one by accident.
sealed class Project {
  const Project({
    required this.slug,
    required this.platform,
    required this.meta,
    required this.commitTitle,
    required this.constraint,
    required this.approach,
    required this.outcome,
    required this.stack,
    this.builtAtRole,
  });

  /// URL segment: `/work/<slug>`.
  final String slug;
  final String platform;
  final String meta;

  /// Title line in commit style: `feat: …`.
  final String commitTitle;

  /// The condition the app had to meet. Empty when its wording is still
  /// behind a VERIFY flag; the UI then shows the outcome alone.
  final String constraint;
  final List<String> approach;
  final String outcome;
  final List<String> stack;

  /// Index into [career] for the "built at" link, if any.
  final int? builtAtRole;

  bool get isRedacted => this is RedactedCaseFile;

  /// The visible title: the real name, or "Case file NN" for redacted files.
  String get displayTitle;

  /// Accessible description of the specimen image.
  String get imageLabel;
}

class PublicProject extends Project {
  const PublicProject({
    required this.name,
    required this.url,
    required this.image,
    required this.iconBackground,
    required super.slug,
    required super.platform,
    required super.meta,
    required super.commitTitle,
    required super.constraint,
    required super.approach,
    required super.outcome,
    required super.stack,
    super.builtAtRole,
  });

  final String name;
  final String url;

  /// Asset path of the public app icon.
  final String image;

  /// ARGB fill behind the icon (the icon artwork's own background colour).
  final int iconBackground;

  @override
  String get displayTitle => name;

  @override
  String get imageLabel => '$name app icon';
}

class RedactedCaseFile extends Project {
  const RedactedCaseFile({
    required this.caseNumber,
    required this.device,
    required this.deviceLabel,
    required super.slug,
    required super.platform,
    required super.meta,
    required super.commitTitle,
    required super.constraint,
    required super.approach,
    required super.outcome,
    required super.stack,
    super.builtAtRole,
  });

  /// "01", "02", ...
  final String caseNumber;
  final Device device;

  /// e.g. "Abstract Android tablet". Never describes the real product.
  final String deviceLabel;

  @override
  String get displayTitle => 'Case file $caseNumber';

  @override
  String get imageLabel => deviceLabel;
}

class Achievement {
  const Achievement(this.text, {this.lead});
  final String? lead;
  final String text;
}

class Metric {
  const Metric(this.value, this.shape, this.tone);
  final String value;
  final String shape;
  final StatTone tone;
}

class Role {
  const Role({
    required this.position,
    required this.company,
    required this.short,
    required this.years,
    required this.duration,
    required this.achievements,
    this.metrics = const [],
    this.isCurrent = false,
  });

  final String position;
  final String company;

  /// Tab label.
  final String short;

  /// Tab caption, e.g. "2024 – 25".
  final String years;
  final String duration;
  final List<Achievement> achievements;
  final List<Metric> metrics;
  final bool isCurrent;
}

/// One `##` section of the About README, shown as a tab.
class ReadmeSection {
  const ReadmeSection({required this.title, required this.lines, this.numbered = false});
  final String title;
  final List<String> lines;
  final bool numbered;
}

class InfoRow {
  const InfoRow(this.label, this.value);
  final String label;
  final String value;
}

/// One pubspec key. [key] is shown as written; [label] is the
/// plain-language reading shown on hover or tap.
class SkillGroup {
  const SkillGroup(this.key, this.label, this.skills, {this.dev = false});
  final String key;
  final String label;
  final List<String> skills;

  /// Listed under `dev_dependencies:`.
  final bool dev;
}

class Post {
  const Post({required this.title, required this.tags, required this.url, this.date});
  final String title;
  final List<String> tags;
  final String url;
  final String? date;
}

enum ContactField { name, email, message }

class FieldCopy {
  const FieldCopy({required this.field, required this.label, required this.placeholder});
  final ContactField field;
  final String label;
  final String placeholder;
}
