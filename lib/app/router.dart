import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../content/projects.dart';
import '../features/work/detail/project_detail_page.dart';
import 'shell/home_shell.dart';

/// Section ids, in page order. `/<id>` scrolls the one-page layout there.
const List<String> sectionIds = ['home', 'work', 'career', 'about', 'notes', 'contact'];

String pathForSection(String id) => id == 'home' ? '/' : '/$id';

/// Fired when an unknown URL was requested; the shell shows the 404 toast.
final ValueNotifier<int> notFoundSignal = ValueNotifier(0);

// Section routes are siblings that all return the same page (same key, same
// widget), so the Navigator keeps one HomeShell alive across URL changes and
// only the scroll position moves. Project detail is a child of /work, so it
// stacks on top as a second page.
const _homeKey = ValueKey('home-shell');

Page<void> _home(BuildContext context, GoRouterState state) =>
    const NoTransitionPage(key: _homeKey, child: HomeShell());

GoRouter buildRouter({String initialLocation = '/'}) {
  return GoRouter(
    initialLocation: initialLocation,
    routes: [
      GoRoute(path: '/', pageBuilder: _home),
      for (final id in sectionIds.skip(1))
        GoRoute(
          path: '/$id',
          pageBuilder: _home,
          routes: [
            if (id == 'work')
              GoRoute(
                path: ':slug',
                redirect: (context, state) => WorkCopy.bySlug(state.pathParameters['slug']!) == null ? '/work' : null,
                pageBuilder: (context, state) => ProjectDetailPage.page(state.pathParameters['slug']!),
              ),
          ],
        ),
    ],
    onException: (context, state, router) {
      notFoundSignal.value++;
      router.go('/');
    },
  );
}

/// Title for the browser tab (§2).
const String siteTitle = 'Amarjit Mallick | Flutter engineer';
