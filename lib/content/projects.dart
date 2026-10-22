import 'flags.dart';
import 'models.dart';

/// §6 Work, in the content file's order.
abstract final class WorkCopy {
  static const TwoLine heading = TwoLine('SELECTED', 'WORK');
  static const String subtitle = 'Six projects. Three are under NDA, so their names are blacked out.';
  static const String constraintLabel = 'CONSTRAINT →';
  static const String outcomeLabel = 'OUTCOME →';
  static const String approachLabel = 'APPROACH';
  static const String redactedHover = "Under NDA. The architecture isn't.";
  static const String notPublic = 'Not public · Details on request';

  static final List<Project> projects = [
    const RedactedCaseFile(
      caseNumber: '01',
      slug: 'case-file-01',
      device: Device.tablet,
      deviceLabel: 'Abstract Android tablet',
      platform: 'Android tablet',
      meta: 'Android tablet · Sole or lead developer',
      commitTitle: 'feat: on-device document pipeline',
      constraint:
          'Sensitive documents had to be read and stored without leaving the device, even when capture quality varied.',
      approach: [
        'Image-quality check, auto-capture and edge detection before anything is read',
        'ML Kit for OCR, with Tesseract as the fallback when confidence is low (English and Hindi)',
        'Rule-based classification and field extraction, with no trained model',
        'Masking rules in a remotely editable config',
      ],
      outcome:
          'A fully offline pipeline. Policy changes ship without an app release, and data stays masked even when OCR fails.',
      stack: ['Flutter', 'Dart', 'GetX', 'Dio', 'Google ML Kit', 'Tesseract', 'Firebase Crashlytics'],
      builtAtRole: 0,
    ),
    const PublicProject(
      name: 'FarmOps',
      slug: 'farmops',
      url: 'https://play.google.com/store/apps/details?id=com.hosachiguru.farmops',
      image: 'assets/images/farmops.webp',
      iconBackground: 0xFFFFF7EA,
      platform: 'Android',
      meta: 'Android · Built at Hosachiguru',
      commitTitle: 'feat: field app for agronomists',
      constraint: Verify.showFarmOpsSignalFraming ? 'Agronomists reported from the field, where signal is unreliable.' : '',
      approach: ['Offline-first with Hive, real-time image uploads and editing, BLoC for state, REST APIs'],
      outcome: 'In production on the Play Store. I led its development.',
      stack: ['Flutter', 'Dart', 'Firebase', 'Hive', 'BLoC', 'REST API'],
      builtAtRole: 3,
    ),
    const RedactedCaseFile(
      caseNumber: '02',
      slug: 'case-file-02',
      device: Device.phone,
      deviceLabel: 'Abstract Android phone',
      platform: 'Android field-operations app',
      meta: 'Android field-operations app · Sole or lead developer',
      commitTitle: 'feat: field app with hardware payments',
      constraint:
          "Payments and item tracking had to work on site, with a payment terminal whose updates don't always arrive.",
      approach: [
        'Card and UPI payments over WebSockets, with a polling fallback, split and partial payments, retry/cancel and '
            'credit-limit checks',
        'Barcode tracking with duplicate prevention',
        'Root and jailbreak detection, secure token storage with automatic refresh, server-side session validation',
        'Up to 5 build flavors with type-safe config; SSL bypasses and a hardcoded endpoint removed',
      ],
      outcome:
          'Payments settle even when socket updates are lost, and release builds are signed and obfuscated.'
          '${Verify.showDefectCount ? ' 100+ production defects resolved.' : ''}',
      stack: [
        'Flutter',
        'BLoC',
        'Clean Architecture',
        'get_it / Injectable',
        'GoRouter',
        'Dio',
        'WebSockets',
        'ObjectBox',
        'Firebase Crashlytics',
      ],
      builtAtRole: 0,
    ),
    const PublicProject(
      name: 'Xpense',
      slug: 'xpense',
      url: 'https://play.google.com/store/apps/details?id=me.amarjitmallick.xpense',
      image: 'assets/images/xpense.webp',
      iconBackground: 0xFFFFFFFF,
      platform: 'Android',
      meta: 'Android · Personal project',
      commitTitle: 'feat: offline-first expense tracker',
      constraint: 'It had to work with no network, even on low-end phones.',
      approach: ['Local storage with Hive, and a deliberately lightweight UI tuned for low battery and memory use'],
      outcome: 'Works fully offline and stays light on resources.',
      stack: ['Flutter', 'Dart', 'Hive'],
    ),
    const RedactedCaseFile(
      caseNumber: '03',
      slug: 'case-file-03',
      device: Device.ipad,
      deviceLabel: 'Abstract iPad',
      platform: 'iPad app',
      meta: 'iPad app · Sole developer',
      commitTitle: 'feat: offline-first iPad app (v1.0 → v2.0)',
      constraint:
          'It had to stay fully usable in meetings with unreliable connectivity, and generate documents on the device.',
      approach: [
        'A cached-session mode (ObjectBox plus on-disk storage) that switches between the live API and local data, and '
            'restores the session when launched offline',
        'On-device PDF generation from multi-step forms',
        'Failed-send recovery and auto-saved submissions, so nothing is lost',
        'Migration to a new set of backend APIs on a Dio layer with central error and timeout handling',
      ],
      outcome: 'Built alone from v1.0 to v2.0 through TestFlight, with 13 feature modules.',
      stack: ['Flutter', 'BLoC / Cubit', 'get_it / injectable', 'Freezed', 'Dio', 'ObjectBox', 'Firebase'],
      builtAtRole: 0,
    ),
    const PublicProject(
      name: 'GDG Siliguri App',
      slug: 'gdg-siliguri',
      url: 'https://play.google.com/store/apps/details?id=com.amarjitmallick.gdg_siliguri',
      image: 'assets/images/gdg_siliguri.webp',
      iconBackground: 0xFFFFFFFF,
      platform: 'Android',
      meta: 'Android · Community project',
      commitTitle: 'feat: live-updating event app',
      constraint: 'Event schedules change on the day.',
      approach: ['Firebase-backed dynamic content, so organisers update the schedule without a rebuild'],
      outcome: '100+ installs.',
      stack: ['Flutter', 'Firebase'],
    ),
  ];

  static Project? bySlug(String slug) {
    for (final p in projects) {
      if (p.slug == slug) return p;
    }
    return null;
  }
}
