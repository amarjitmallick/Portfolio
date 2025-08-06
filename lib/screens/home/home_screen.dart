import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../widgets/nav_bar.dart';
import '../about/about_screen.dart';
import '../career/career_screen.dart';
import '../contact/contact_screen.dart';
import '../projects/projects_screen.dart';
import '../publications/publications_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      body: SingleChildScrollView(
        controller: _scrollController,
        child: LayoutBuilder(
          builder: (context, constraints) {
            double horizontalPadding = constraints.maxWidth > 1000 ? 250 : 20;
            double? sectionHeight = constraints.maxWidth > 1000 ? MediaQuery.of(context).size.height : null;

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Column(
                children: [
                  _buildSection(_homeKey, _heroSection(context), sectionHeight),
                  _buildSection(_aboutKey, const AboutScreen(), sectionHeight),
                  _buildSection(_projectsKey, const ProjectsScreen(), sectionHeight),
                  _buildSection(_publicationsKey, const PublicationsScreen(), sectionHeight),
                  _buildSection(_careerKey, const CareerScreen(), sectionHeight),
                  _buildSection(_contactKey, const ContactScreen(), sectionHeight),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSection(GlobalKey key, Widget child, double? height) {
    return Container(
      key: key,
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: height ?? 400,
      ),
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: child,
    );
  }

  Widget _heroSection(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 70),
      padding: const EdgeInsets.all(5),
      height: MediaQuery.of(context).size.height * 0.50,
      decoration: BoxDecoration(
        color: Colors.tealAccent,
        border: Border.all(),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Center(
              child: Lottie.asset('assets/animations/developer.json'),
            ),
            Text(
              "Hi, I’m Amarjit, a Flutter Developer",
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(height: 12),
            Text(
              "I specialize in creating high-quality mobile applications using Flutter. With a passion for clean code and user-centric design, I bring ideas to life.",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 20),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Color(0xFFDBE8F2),
              ),
              onPressed: () {
                scrollToSection(_projectsKey);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                child: Text(
                  "View My Work",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
