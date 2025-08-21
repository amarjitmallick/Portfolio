import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../responsive/responsive.dart';
import '../../widgets/nav_bar.dart';
import '../about/about_screen.dart';
import '../career/career_screen.dart';
import '../contact/contact_screen.dart';
import '../projects/projects_screen.dart';
import '../publications/publications_screen.dart';

class DesktopAndTabHome extends StatefulWidget {
  const DesktopAndTabHome({super.key});

  @override
  State<DesktopAndTabHome> createState() => _DesktopAndTabHomeState();
}

class _DesktopAndTabHomeState extends State<DesktopAndTabHome> {
  final ScrollController _scrollController = ScrollController();

  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _publicationsKey = GlobalKey();
  final GlobalKey _careerKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  void scrollToSection(GlobalKey key) {
    final RenderBox renderBox = key.currentContext?.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero, ancestor: null).dy;
    _scrollController.animateTo(
      position + _scrollController.offset,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final sectionHeight = context.isDesktop ? size.height : null;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: NavBar(
        onItemSelected: (String section) {
          switch (section) {
            case "About":
              scrollToSection(_aboutKey);
              break;
            case "Projects":
              scrollToSection(_projectsKey);
              break;
            case "Publications":
              scrollToSection(_publicationsKey);
              break;
            case "Career":
              scrollToSection(_careerKey);
              break;
            case "Contact":
              scrollToSection(_contactKey);
              break;
          }
        },
      ),
      endDrawer: context.isTablet
          ? _TabletMenuDrawer(
              onTap: (section) {
                Navigator.of(context).maybePop();
                switch (section) {
                  case "About":
                    scrollToSection(_aboutKey);
                    break;
                  case "Projects":
                    scrollToSection(_projectsKey);
                    break;
                  case "Publications":
                    scrollToSection(_publicationsKey);
                    break;
                  case "Career":
                    scrollToSection(_careerKey);
                    break;
                  case "Contact":
                    scrollToSection(_contactKey);
                    break;
                }
              },
            )
          : null,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: ResponsivePage(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // offset content because extendBodyBehindAppBar is true
              SizedBox(height: kToolbarHeight + MediaQuery.of(context).padding.top),
              _buildSection(_homeKey, _heroSection(context), sectionHeight),
              _buildSection(_aboutKey, const AboutScreen(), sectionHeight),
              _buildSection(_projectsKey, const ProjectsScreen(), sectionHeight),
              _buildSection(_publicationsKey, const PublicationsScreen(), sectionHeight),
              _buildSection(_careerKey, const CareerScreen(), sectionHeight),
              _buildSection(_contactKey, const ContactScreen(), sectionHeight),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(GlobalKey key, Widget child, double? height) {
    final vPad = const ResponsiveValue<double>(
      desktop: 40,
      tablet: 28,
      mobile: 20,
    ).resolve(context);

    return Container(
      key: key,
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: height ?? 400,
      ),
      padding: EdgeInsets.symmetric(vertical: vPad),
      child: child,
    );
  }

  Widget _heroSection(BuildContext context) {
    final h = MediaQuery.sizeOf(context).height;
    final isDesktop = context.isDesktop;
    final isTablet = context.isTablet;

    final outerMarginV = isTablet ? 40.0 : 70.0;
    final innerPadV = isDesktop ? 80.0 : 56.0;
    final innerPadH = isDesktop ? 40.0 : 24.0;

    final double minH = isDesktop ? h * 0.60 : (isTablet ? 420 : 380);
    final double maxH = isDesktop ? h * 0.60 : (isTablet ? 700 : 420);

    return Container(
      margin: EdgeInsets.symmetric(vertical: outerMarginV),
      padding: EdgeInsets.symmetric(vertical: innerPadV, horizontal: innerPadH),
      constraints: BoxConstraints(minHeight: minH, maxHeight: maxH),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: isTablet ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Center(
              child: FittedBox(
                fit: BoxFit.contain,
                child: Lottie.asset('assets/animations/developer.json'),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "Hi, I’m Amarjit, a Flutter Developer",
            style: Theme.of(context).textTheme.displayLarge,
            textAlign: isTablet ? TextAlign.center : TextAlign.start,
          ),
          const SizedBox(height: 12),
          Text(
            "I specialize in creating high-quality mobile applications using Flutter. With a passion for clean code and user-centric design, I bring ideas to life.",
            style: Theme.of(context).textTheme.headlineLarge,
            textAlign: isTablet ? TextAlign.center : TextAlign.start,
          ),
          const SizedBox(height: 20),
          Align(
            alignment: isTablet ? Alignment.center : Alignment.centerLeft,
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: const Color(0xFFDBE8F2)),
              onPressed: () => scrollToSection(_projectsKey),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                child: Text(
                  "View My Work",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TabletMenuDrawer extends StatelessWidget {
  const _TabletMenuDrawer({required this.onTap});
  final ValueChanged<String> onTap;

  @override
  Widget build(BuildContext context) {
    final items = const ['About', 'Projects', 'Publications', 'Career', 'Contact'];
    return Drawer(
      child: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemBuilder: (_, i) => ListTile(
            title: Text(items[i]),
            onTap: () => onTap(items[i]),
          ),
          separatorBuilder: (_, _) => const Divider(height: 1),
          itemCount: items.length,
        ),
      ),
    );
  }
}
