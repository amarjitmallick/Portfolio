import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/content/about.dart';
import 'package:portfolio/content/career.dart';
import 'package:portfolio/content/contact.dart';
import 'package:portfolio/content/home.dart';
import 'package:portfolio/content/identity.dart';
import 'package:portfolio/content/microcopy.dart';
import 'package:portfolio/content/models.dart';
import 'package:portfolio/content/notes.dart';
import 'package:portfolio/content/projects.dart';

/// Every user-visible string from the content layer.
List<String> allStrings() => [
      Identity.name, Identity.title, Identity.location, Identity.email, Identity.employer,
      for (final s in Identity.socials) ...[s.label, s.url],
      HomeCopy.headline.toString(), HomeCopy.intro, HomeCopy.ctaWork, HomeCopy.ctaContact,
      for (final (k, v) in HomeCopy.header) ...[k, v],
      for (final n in HomeCopy.releaseNotes) ...[?n.lead, n.text],
      for (final s in HomeCopy.stats) ...[s.value, s.label],
      WorkCopy.heading.toString(), WorkCopy.subtitle, WorkCopy.redactedHover, WorkCopy.notPublic,
      for (final p in WorkCopy.projects) ...[
        p.displayTitle, p.imageLabel, p.slug, p.platform, p.meta, p.commitTitle,
        if (p.constraint.isNotEmpty) p.constraint, ...p.approach, p.outcome, ...p.stack,
        if (p is PublicProject) ...[p.url, p.image],
      ],
      CareerCopy.heading.toString(), CareerCopy.subtitle,
      for (final r in CareerCopy.roles) ...[
        r.position, r.company, r.short, r.years, r.duration,
        for (final a in r.achievements) ...[?a.lead, a.text],
        for (final m in r.metrics) m.value,
      ],
      AboutCopy.heading.toString(), AboutCopy.fileName, AboutCopy.readmeTitle, AboutCopy.whatIDo,
      AboutCopy.currentlyLead, AboutCopy.currentlyRest,
      for (final t in AboutCopy.sections) ...[t.title, ...t.lines],
      for (final g in AboutCopy.skills) ...[g.key, g.label, ...g.skills],
      NotesCopy.heading.toString(), NotesCopy.subtitle,
      for (final p in NotesCopy.posts) ...[p.title, ...p.tags, p.url, ?p.date],
      ContactCopy.heading.toString(), ContactCopy.subtitle, ContactCopy.responseTime, ...ContactCopy.helpWith,
      for (final f in ContactCopy.fields) ...[f.label, f.placeholder],
      ContactCopy.errorNoMailApp, ContactCopy.successTitle, ContactCopy.successBody,
      for (final n in Microcopy.nav) n.label,
      Microcopy.notFound, Microcopy.footer, Microcopy.hotReloadToast, Microcopy.copied,
    ];

void main() {
  group('redaction', () {
    final redacted = WorkCopy.projects.whereType<RedactedCaseFile>().toList();

    test('exactly three redacted case files, with neutral slugs and titles', () {
      expect(redacted, hasLength(3));
      for (final r in redacted) {
        expect(r.isRedacted, isTrue);
        expect(r.slug, matches(RegExp(r'^case-file-\d\d$')));
        expect(r.displayTitle, 'Case file ${r.caseNumber}');
        expect(r.imageLabel, startsWith('Abstract '));
      }
    });

    test('no redacted entry carries a link or image', () {
      for (final r in redacted) {
        final text = [r.meta, r.commitTitle, r.constraint, ...r.approach, r.outcome].join(' ');
        expect(text, isNot(contains('http')));
        expect(text, isNot(contains('assets/')));
        expect(text, isNot(contains('play.google')));
      }
    });

    test('public projects link to the Play Store', () {
      for (final p in WorkCopy.projects.whereType<PublicProject>()) {
        expect(p.url, startsWith('https://play.google.com/store/apps/details?id='));
        expect(File(p.image).existsSync(), isTrue, reason: p.image);
      }
    });

    // The Section 0 ban-list is kept out of the repo. Put one term per line
    // in test/.banned_terms.txt (git-ignored) to run this check locally.
    test('no Section 0 banned term appears in content or source', () {
      final list = File('test/.banned_terms.txt');
      if (!list.existsSync()) {
        markTestSkipped('test/.banned_terms.txt not present');
        return;
      }
      final terms = list.readAsLinesSync().map((l) => l.trim().toLowerCase()).where((l) => l.isNotEmpty).toList();
      final corpus = [
        ...allStrings(),
        for (final f in Directory('lib').listSync(recursive: true).whereType<File>()) f.readAsStringSync(),
        File('web/index.html').readAsStringSync(),
      ].join('\n').toLowerCase();
      for (final t in terms) {
        expect(corpus.contains(t), isFalse, reason: 'banned term found: "$t"');
      }
    });
  });

  group('copy hygiene', () {
    test('no placeholders or VERIFY markers ship', () {
      for (final s in allStrings()) {
        expect(s, isNot(contains('VERIFY')), reason: s);
        expect(s, isNot(matches(RegExp(r'\[[^\]]*\]'))), reason: s);
        expect(s.trim(), isNotEmpty);
      }
    });

    test('copy still marked VERIFY in v4 does not render', () {
      final corpus = allStrings().join('\n');
      for (final s in ['20+', '100+ production defects', "Bachelor's", 'signal is unreliable']) {
        expect(corpus, isNot(contains(s)), reason: s);
      }
    });

    test('parked AI copy and the old "Signal optional" brand are gone', () {
      final corpus = [...allStrings(), File('web/index.html').readAsStringSync()].join('\n').toLowerCase();
      for (final s in ['claude', 'pair-program', 'signal optional', 'curveball']) {
        expect(corpus, isNot(contains(s)), reason: s);
      }
    });

    test('voice rules: banned adjectives are absent', () {
      const banned = ['passionate', 'innovative', 'seamless', 'robust', 'scalable'];
      for (final s in allStrings()) {
        for (final b in banned) {
          expect(s.toLowerCase(), isNot(contains(b)), reason: s);
        }
      }
    });

    test('one source of truth for socials and the contact form', () {
      expect(Identity.socials.map((s) => s.label), ['LinkedIn', 'GitHub', 'X']);
      expect(ContactCopy.fields.map((f) => f.field), ContactField.values);
    });

    test('slugs are unique and resolvable', () {
      final slugs = WorkCopy.projects.map((p) => p.slug).toList();
      expect(slugs.toSet(), hasLength(slugs.length));
      for (final s in slugs) {
        expect(WorkCopy.bySlug(s)?.slug, s);
      }
      expect(WorkCopy.bySlug('nope'), isNull);
    });
  });

  group('contact form', () {
    test('validation messages come from the content file', () {
      expect(ContactCopy.validate(ContactField.name, ' '), 'Please add your name');
      expect(ContactCopy.validate(ContactField.email, ''), 'Please add your email');
      expect(ContactCopy.validate(ContactField.email, 'nope@'), "That email doesn't look quite right");
      expect(ContactCopy.validate(ContactField.email, 'a.b@company.io'), isNull);
      expect(ContactCopy.validate(ContactField.message, ''), 'Tell me a little about the project');
    });

    test('mail body includes the visitor email', () {
      final body = ContactCopy.mailBody(name: 'Ada', email: 'ada@x.dev', message: 'Hi');
      expect(body, 'Hi\n\nAda\nada@x.dev\n');
      final uri = ContactCopy.mailto(name: 'Ada', email: 'ada@x.dev', message: 'Hi');
      expect(uri.scheme, 'mailto');
      expect(uri.path, Identity.email);
      expect(Uri.decodeComponent(uri.query), contains('ada@x.dev'));
      expect(Uri.decodeComponent(uri.query), contains('New message from your portfolio'));
    });
  });
}
