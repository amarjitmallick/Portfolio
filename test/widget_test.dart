import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/app/app.dart';
import 'package:portfolio/app/router.dart';
import 'package:portfolio/app/shell/app_bar_wide.dart';
import 'package:portfolio/app/shell/fab.dart';
import 'package:portfolio/content/contact.dart';
import 'package:portfolio/content/microcopy.dart';
import 'package:portfolio/content/projects.dart';
import 'package:portfolio/core/theme/app_theme.dart';
import 'package:portfolio/core/theme/theme_controller.dart';
import 'package:portfolio/features/contact/contact_sheet.dart';

Future<void> settle(WidgetTester tester, [int ms = 2500]) async {
  for (var t = 0; t < ms; t += 100) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}

Future<GoRouter> boot(WidgetTester tester, {String at = '/', Size size = const Size(1440, 900)}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  final router = buildRouter(initialLocation: at);
  await tester.pumpWidget(PortfolioApp(theme: ThemeController(), router: router));
  await settle(tester);
  return router;
}

/// Unmounts the app so periodic animation timers are cancelled.
Future<void> teardown(WidgetTester tester) async {
  await tester.pumpWidget(const SizedBox());
  await tester.pump(const Duration(seconds: 1));
}

String path(GoRouter r) => r.routerDelegate.currentConfiguration.uri.path;

void main() {
  group('navigation', () {
    testWidgets('deep link lands on the section and nav goes to another', (tester) async {
      final router = await boot(tester, at: '/career');
      expect(path(router), '/career');
      expect(find.text("Where I've worked, and what I shipped there."), findsOneWidget);

      await tester.tap(find.descendant(of: find.byType(WideAppBar), matching: find.text('Work')));
      await settle(tester);
      expect(path(router), '/work');
      await teardown(tester);
    });

    testWidgets('project detail is its own route and goes back to the catalog', (tester) async {
      final router = await boot(tester, at: '/work/xpense');
      expect(find.text('Open on Play Store'), findsOneWidget);
      await tester.tap(find.bySemanticsLabel('Back to catalog'));
      await settle(tester);
      expect(path(router), '/work');
      await teardown(tester);
    });

    testWidgets('unknown URL falls back to home with the 404 toast', (tester) async {
      final router = await boot(tester, at: '/nope');
      expect(path(router), '/');
      expect(find.text(Microcopy.notFound), findsOneWidget);
      await teardown(tester);
    });
  });

  group('accessibility', () {
    testWidgets('keyboard only: Tab to a nav item and Enter navigates', (tester) async {
      final router = await boot(tester);
      // Tab until the "Career" nav item has focus, then activate it.
      for (var i = 0; i < 12; i++) {
        await tester.sendKeyEvent(LogicalKeyboardKey.tab);
        await tester.pump();
        final focused = FocusManager.instance.primaryFocus?.context;
        if (focused == null || focused.widget is! Focus) continue;
        final texts = find.descendant(of: find.byWidget(focused.widget), matching: find.byType(Text)).evaluate();
        if (texts.length == 1 && (texts.first.widget as Text).data == 'Career') break;
      }
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await settle(tester);
      expect(path(router), '/career');
      await teardown(tester);
    });

    testWidgets('reduced motion: content shows at once and the footer says so', (tester) async {
      tester.platformDispatcher.accessibilityFeaturesTestValue = const FakeAccessibilityFeatures(disableAnimations: true);
      addTearDown(tester.platformDispatcher.clearAccessibilityFeaturesTestValue);
      await boot(tester, at: '/contact');
      expect(find.text(Microcopy.reducedMotion), findsOneWidget);
      final faded = tester
          .widgetList<Opacity>(find.byType(Opacity))
          .where((o) => o.alwaysIncludeSemantics && o.opacity < 1);
      expect(faded, isEmpty);
      await teardown(tester);
    });
  });

  group('responsive', () {
    testWidgets('wide: top app bar and split FAB', (tester) async {
      await boot(tester, size: const Size(1440, 900));
      expect(find.byType(WideAppBar), findsOneWidget);
      expect(find.byType(SplitFab), findsOneWidget);
      expect(find.byType(NarrowNav), findsNothing);
      await teardown(tester);
    });

    testWidgets('phone: floating bottom nav, no app bar', (tester) async {
      await boot(tester, size: const Size(390, 844));
      expect(find.byType(NarrowNav), findsOneWidget);
      expect(find.byType(WideAppBar), findsNothing);
      expect(find.byType(SplitFab), findsNothing);
      await teardown(tester);
    });

    testWidgets('tablet width switches to the wide layout', (tester) async {
      await boot(tester, size: const Size(820, 1180));
      expect(find.byType(WideAppBar), findsOneWidget);
      await teardown(tester);
    });
  });

  group('redaction', () {
    testWidgets('case files show the not-public badge and no store link', (tester) async {
      await boot(tester, at: '/work');
      expect(find.text('Case file 01'), findsWidgets);
      expect(find.text(WorkCopy.notPublic), findsWidgets);
      expect(find.text('Play Store'), findsNothing);
      await teardown(tester);
    });

    testWidgets('case file detail has no Play Store or copy link actions', (tester) async {
      await boot(tester, at: '/work/case-file-02');
      expect(find.text('Case file 02'), findsWidgets);
      expect(find.text('Open on Play Store'), findsNothing);
      expect(find.text('Copy link'), findsNothing);
      expect(find.text(WorkCopy.notPublic), findsOneWidget);
      await teardown(tester);
    });
  });

  group('contact form', () {
    Future<void> openSheet(WidgetTester tester, MessageSender send) async {
      tester.view.physicalSize = const Size(1000, 900);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.build(const Color(0xFFE6A100), Brightness.dark),
          home: Builder(
            builder: (context) => Scaffold(
              body: Center(
                child: TextButton(onPressed: () => ContactSheet.show(context, send: send), child: const Text('open')),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('open'));
      await settle(tester, 1200);
    }

    Future<void> next(WidgetTester tester) async {
      await tester.tap(find.text('Next').last);
      await settle(tester, 1000);
    }

    testWidgets('validates each step, sends with the visitor email, shows success', (tester) async {
      Uri? sent;
      await openSheet(tester, (uri) async {
        sent = uri;
        return true;
      });

      await next(tester);
      expect(find.textContaining(ContactCopy.errorNoName), findsWidgets);

      await tester.enterText(find.byType(TextField), 'Ada');
      await next(tester);
      expect(find.textContaining('you@company.com'), findsOneWidget);

      await tester.enterText(find.byType(TextField), 'ada@');
      await next(tester);
      expect(find.textContaining(ContactCopy.errorBadEmail), findsWidgets);

      await tester.enterText(find.byType(TextField), 'ada@example.dev');
      await next(tester);
      await tester.enterText(find.byType(TextField), 'An offline-first field app.');
      await tester.tap(find.text(ContactCopy.send));
      await settle(tester, 1500);

      expect(find.text(ContactCopy.successTitle), findsOneWidget);
      final body = Uri.decodeComponent(sent!.query);
      expect(body, contains('ada@example.dev'));
      expect(body, contains('Ada'));
      expect(body, contains('An offline-first field app.'));
      await teardown(tester);
    });

    testWidgets('keeps the fields and explains when no mail app opens', (tester) async {
      await openSheet(tester, (_) async => false);
      await tester.enterText(find.byType(TextField), 'Ada');
      await next(tester);
      await tester.enterText(find.byType(TextField), 'ada@example.dev');
      await next(tester);
      await tester.enterText(find.byType(TextField), 'Hello');
      await tester.tap(find.text(ContactCopy.send));
      await settle(tester, 1500);

      expect(find.text(ContactCopy.errorNoMailApp), findsOneWidget);
      expect(find.text(ContactCopy.successTitle), findsNothing);
      expect(find.text('Hello'), findsOneWidget);
      await teardown(tester);
    });
  });
}
