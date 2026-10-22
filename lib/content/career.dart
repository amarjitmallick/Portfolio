import 'flags.dart';
import 'identity.dart';
import 'models.dart';

/// §7 Career, newest first.
abstract final class CareerCopy {
  static const TwoLine heading = TwoLine('FIVE TEAMS,', 'FIVE+ YEARS');
  static const String subtitle = "Where I've worked, and what I shipped there.";
  static const String achievementsLabel = 'WHAT SHIPPED';

  /// Bullets shown before "Show N more" (§7: Sundew shows three by default).
  static const int collapsedCount = 3;

  static final List<Role> roles = [
    Role(
      position: 'Associate Flutter Developer (A2)',
      company: Identity.employer,
      short: Verify.showEmployerName ? Identity.employer : 'Current',
      years: '2025 – Present',
      duration: 'Sept 2025 – Present',
      isCurrent: true,
      achievements: [
        Achievement(
          'three production apps as sole or lead developer${Verify.showReleaseCount ? ', with 20+ releases' : ''}',
          lead: 'Built:',
        ),
        const Achievement(
          'a legacy codebase restructured to Clean Architecture in 8 phases, with no pause in delivery',
          lead: 'Modernised:',
        ),
        const Achievement('root and jailbreak detection, secure token storage and obfuscated builds', lead: 'Secured:'),
        const Achievement(
          'offline-first behaviour (a fully offline document pipeline and cached sessions), so data stays on the device '
          'and apps restore without a network',
          lead: 'Designed:',
        ),
        const Achievement(
          'card and UPI payments over WebSockets with a polling fallback, plus split and partial payments',
          lead: 'Integrated:',
        ),
        const Achievement(
          'redesigns around a unified design system, with skeleton loaders, haptics and Lottie animations',
          lead: 'Led:',
        ),
        Achievement(
          'builds across up to 5 environments${Verify.showDefectCount ? ', and 100+ production defects resolved' : ''}',
          lead: 'Stabilised:',
        ),
      ],
    ),
    const Role(
      position: 'Associate Software Developer',
      company: 'Cloudcraftz Solutions',
      short: 'Cloudcraftz',
      years: '2024 – 25',
      duration: 'Apr 2024 – Mar 2025',
      achievements: [
        Achievement('a modular assessment builder on Flutter Web with PDF generation, used by 100+ users', lead: 'Built:'),
        Achievement('task handling by 40% with a workflow system on GetX and Firestore', lead: 'Sped up:'),
        Achievement('a multi-step form to 99.9% session continuity and 20% higher completion', lead: 'Improved:'),
      ],
      metrics: [
        Metric('40%', 'cookie6', StatTone.primary),
        Metric('99.9%', 'sunny', StatTone.tertiaryContainer),
        Metric('20%', 'clover4', StatTone.secondaryContainer),
      ],
    ),
    const Role(
      position: 'Flutter Developer',
      company: 'Fineant Consultant Services',
      short: 'Fineant',
      years: '2023 – 24',
      duration: 'Aug 2023 – Feb 2024',
      achievements: [
        Achievement(
          'a cross-platform app for hiring photographers and shopping for gifts, from scratch, for Android and iOS',
          lead: 'Built:',
        ),
        Achievement(
          'Provider state management and REST APIs, keeping the code modular and easy to maintain',
          lead: 'Structured:',
        ),
      ],
    ),
    const Role(
      position: 'Flutter Developer (Consultant)',
      company: 'Hosachiguru',
      short: 'Hosachiguru',
      years: '2022 – 23',
      duration: 'Oct 2022 – Jul 2023',
      achievements: [
        Achievement('development of FarmOps, a farm-management app for agronomists', lead: 'Led:'),
        Achievement(
          'real-time image uploads and advanced editing with BLoC and Hive, with offline-first support',
          lead: 'Added:',
        ),
        Achievement('crash reports by 40% by redesigning core flows and fixing critical bugs in MyFarm', lead: 'Reduced:'),
      ],
      metrics: [Metric('40%', 'cookie6', StatTone.primary)],
    ),
    const Role(
      position: 'Mobile Application Developer',
      company: 'Blackspektro',
      short: 'Blackspektro',
      years: '2021 – 22',
      duration: 'Apr 2021 – Jul 2022',
      achievements: [
        Achievement(
          'a financial-insights app with real-time data visualisation and interactive charts, on a BLoC architecture',
          lead: 'Built:',
        ),
        Achievement(
          'responsiveness by integrating RESTful APIs and fixing the performance issues behind UI lag',
          lead: 'Improved:',
        ),
      ],
    ),
  ];
}
