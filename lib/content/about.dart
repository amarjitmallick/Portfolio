import 'flags.dart';
import 'identity.dart';
import 'models.dart';

/// §4 About (a README) and §5 Skills (a pubspec).
abstract final class AboutCopy {
  static const TwoLine heading = TwoLine('ABOUT', 'ME');
  static const String fileName = 'README.md';

  static const String readmeTitle = '# amarjit_mallick';

  /// "## What I do", the large statement under the title.
  static const String whatIDo = 'I own Flutter apps from the first commit to the store release, and keep them healthy after.';

  static const List<InfoRow> info = [
    InfoRow('Name', Identity.name),
    InfoRow('Title', Identity.title),
    InfoRow('Location', Identity.location),
  ];

  /// "## Currently".
  static const String currentlyLabel = 'Currently';
  static const String currentlyLead = 'Sole or lead developer on three production apps.';
  static const String currentlyRest = 'Built the DevFest app for the GDG Siliguri community.';

  /// The remaining README sections, shown as tabs.
  static const List<ReadmeSection> sections = [
    ReadmeSection(
      title: 'How I work',
      numbered: true,
      lines: [
        'Define the constraints first: devices, networks, data sensitivity and release cadence.',
        'Choose the simplest architecture that survives them: feature-first Clean Architecture, one state-management '
            'approach per app.',
        'Ship in small releases and let crash reports and completion rates decide what to fix next.',
      ],
    ),
    ReadmeSection(
      title: 'Background',
      lines: [
        '${Verify.showDegreeWording ? "Bachelor's in Mathematics → " : ''}'
            "Master's in Computer Applications → five teams since 2021, from startups to enterprise.",
      ],
    ),
  ];

  /// §5, in the content file's order.
  static const List<SkillGroup> skills = [
    SkillGroup('build_the_app', 'Build the app', ['flutter', 'dart', 'freezed', 'json_serializable']),
    SkillGroup('structure_it_to_last', 'Structure it to last', [
      'clean_architecture',
      'bloc',
      'cubit',
      'getx',
      'provider',
      'mobx',
      'get_it',
      'injectable',
      'go_router',
      'fpdart',
    ]),
    SkillGroup('work_offline', 'Make it work without a network', [
      'objectbox',
      'hive',
      'secure_storage',
      'offline_first_sync',
    ]),
    SkillGroup('connect_it', 'Connect it to the world', ['dio', 'rest_apis', 'websockets', 'firebase', 'supabase', 'aws']),
    SkillGroup('run_on_device', 'Run intelligence on the device', [
      'google_ml_kit',
      'tesseract_ocr',
      'camera',
      'barcode_scanning',
      'pdf_generation',
    ]),
    SkillGroup('ship_and_protect_it', 'Ship and protect it', [
      'build_flavors',
      'github_actions',
      'testflight',
      'crashlytics',
      'code_obfuscation',
      'unit_testing',
      'root_jailbreak_detection',
    ], dev: true),
    SkillGroup('design', 'Design it', ['figma', 'design_systems', 'lottie'], dev: true),
  ];

  static const String skillsHint = 'In my pubspec.';
}
