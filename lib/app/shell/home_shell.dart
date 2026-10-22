import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show ScrollCacheExtent;
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../content/microcopy.dart';
import '../../core/motion/spring_scroll.dart';
import '../../core/responsive/breakpoints.dart';
import '../../core/theme/tokens.dart';
import '../../core/widgets/toast.dart';
import '../../features/about/about_section.dart';
import '../../features/career/career_section.dart';
import '../../features/contact/contact_section.dart';
import '../../features/contact/contact_sheet.dart';
import '../../features/home/home_section.dart';
import '../../features/notes/notes_section.dart';
import '../../features/work/work_section.dart';
import '../router.dart';
import 'app_bar_wide.dart';
import 'fab.dart';
import 'shell_actions.dart';

/// The one page. URLs map to sections; this widget stays alive across
/// navigation and only moves the scroll position.
class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> implements ShellActions {
  final ScrollController _scroll = ScrollController();
  final Map<String, GlobalKey> _keys = {for (final id in sectionIds) id: GlobalKey(debugLabel: id)};
  final ValueNotifier<String> _active = ValueNotifier('home');
  final ValueNotifier<bool> _fabOpen = ValueNotifier(false);

  GoRouter? _router;
  String _lastPath = '';
  bool _sheetOpen = false;

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_onScroll);
    notFoundSignal.addListener(_onNotFound);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _onLocation(initial: true);
      if (notFoundSignal.value > 0) _onNotFound();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final router = GoRouter.of(context);
    if (router != _router) {
      _router?.routerDelegate.removeListener(_onLocation);
      _router = router;
      router.routerDelegate.addListener(_onLocation);
    }
  }

  @override
  void dispose() {
    _router?.routerDelegate.removeListener(_onLocation);
    notFoundSignal.removeListener(_onNotFound);
    _scroll.dispose();
    _active.dispose();
    _fabOpen.dispose();
    super.dispose();
  }

  String get _path => _router!.routerDelegate.currentConfiguration.uri.path;

  void _onLocation({bool initial = false}) {
    if (!mounted) return;
    final path = _path;
    final wasDetail = _lastPath.startsWith('/work/');
    _lastPath = path;
    if (path.startsWith('/work/')) return; // detail page sits on top
    final id = path == '/' ? 'home' : path.substring(1);
    if (!sectionIds.contains(id)) return;
    _active.value = id;
    if (!(initial && id == 'home')) _scrollTo(id, instant: initial || wasDetail);
    if (id == 'contact') openContact();
  }

  void _onNotFound() {
    if (!mounted) return;
    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) toast(Microcopy.notFound);
    });
  }

  /// Scroll offset that puts [id] just under the app bar: the sum of the
  /// section heights above it (the pinned bar already offsets content).
  /// Null until those sections have been laid out.
  double? _offsetOf(String id) {
    var y = 0.0;
    for (final s in sectionIds) {
      if (s == id) return y;
      final box = _keys[s]!.currentContext?.findRenderObject() as RenderBox?;
      if (box == null || !box.hasSize) return null;
      y += box.size.height;
    }
    return y;
  }

  void _scrollTo(String id, {bool instant = false, int attempt = 0}) {
    final target = _offsetOf(id);
    if (!_scroll.hasClients || target == null) {
      if (attempt < 10) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) _scrollTo(id, instant: instant, attempt: attempt + 1);
        });
      }
      return;
    }
    if (instant) {
      _scroll.jumpTo(target.clamp(0, _scroll.position.maxScrollExtent));
    } else {
      springScrollTo(context, _scroll.position, target);
    }
  }

  bool _syncQueued = false;

  void _onScroll() {
    if (_syncQueued) return;
    _syncQueued = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _syncQueued = false;
      if (mounted) _syncActive();
    });
  }

  /// Highlights the section crossing the 45–50% band of the viewport and
  /// mirrors it into the URL without adding history entries.
  void _syncActive() {
    if (!_scroll.hasClients || _path.startsWith('/work/')) return;
    final vh = MediaQuery.sizeOf(context).height;
    String? hit;
    for (final id in sectionIds) {
      final box = _keys[id]!.currentContext?.findRenderObject() as RenderBox?;
      if (box == null || !box.attached || !box.hasSize) continue;
      final top = box.localToGlobal(Offset.zero).dy;
      if (top <= vh * .5 && top + box.size.height >= vh * .45) {
        hit = id;
        break;
      }
    }
    if (hit == null || hit == _active.value) return;
    _active.value = hit;
    if (kIsWeb) {
      SystemNavigator.routeInformationUpdated(uri: Uri.parse(pathForSection(hit)), replace: true);
    }
  }

  // ShellActions

  @override
  void goTo(String sectionId) {
    _fabOpen.value = false;
    final path = pathForSection(sectionId);
    if (_path == path) {
      _active.value = sectionId;
      _scrollTo(sectionId);
      if (sectionId == 'contact') openContact();
    } else {
      _router!.go(path);
    }
  }

  @override
  Future<void> openContact() async {
    _fabOpen.value = false;
    if (_sheetOpen) return;
    _sheetOpen = true;
    await ContactSheet.show(context);
    _sheetOpen = false;
  }

  @override
  void toast(String message) => showToast(context, message);

  @override
  void copy(String text) => copyText(context, text);

  @override
  Widget build(BuildContext context) {
    final wide = context.isWide;
    final width = context.screenWidth;
    final sections = <String, Widget>{
      'home': const HomeSection(),
      'work': const WorkSection(),
      'career': const CareerSection(),
      'about': const AboutSection(),
      'notes': const NotesSection(),
      'contact': const ContactSection(),
    };
    return ShellActionsScope(
      actions: this,
      child: CallbackShortcuts(
        bindings: {const SingleActivator(LogicalKeyboardKey.escape): () => _fabOpen.value = false},
        child: Scaffold(
          body: Stack(
            children: [
              SelectionArea(
                child: CustomScrollView(
                  controller: _scroll,
                  // Lay out every section up front so deep links can
                  // measure the sections above their target.
                  scrollCacheExtent: const ScrollCacheExtent.pixels(100000),
                  slivers: [
                    if (wide) SliverPersistentHeader(pinned: true, delegate: AppBarWide(active: _active)),
                    for (final id in sectionIds)
                      SliverToBoxAdapter(
                        child: Semantics(
                          container: true,
                          label: id == 'home' ? null : _sectionLabel(id),
                          child: KeyedSubtree(key: _keys[id], child: sections[id]!),
                        ),
                      ),
                    if (!wide) const SliverToBoxAdapter(child: SizedBox(height: NarrowNav.height + 16)),
                  ],
                ),
              ),
              if (wide)
                Positioned(
                  right: Space.fluid(width, 16, 2.4, 36),
                  bottom: Space.fluid(width, 16, 2.4, 36),
                  child: SplitFab(open: _fabOpen),
                )
              else
                Positioned.fill(
                  child: NarrowNav(active: _active, open: _fabOpen),
                ),
            ],
          ),
        ),
      ),
    );
  }

  String _sectionLabel(String id) =>
      id == 'contact' ? Microcopy.contact : Microcopy.nav.firstWhere((n) => n.id == id).label;
}
