import 'package:flutter/material.dart';
import 'package:portfolio/contact/contact_desktop.dart';
import 'package:portfolio/introduction/introduction_desktop.dart';
import 'package:portfolio/landing_page/landing_page_desktop.dart';
import 'package:portfolio/latest_works/latest_works_desktop.dart';
import 'package:portfolio/navigation_bar/navigation_bar_desktop.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class DesktopView extends StatefulWidget {
  @override
  _DesktopViewState createState() => _DesktopViewState();
}

class _DesktopViewState extends State<DesktopView> {
  final scrollDirection = Axis.vertical;
  AutoScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = AutoScrollController(
        viewportBoundaryGetter: () =>
            Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
        axis: scrollDirection);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: NavigationBarDesktop(controller),
      ),
      body: ListView(
        scrollDirection: scrollDirection,
        controller: controller,
        children: [
          LandingPageDesktop(controller),
          IntroductionDesktop(controller),
          LatestWorksDesktop(controller),
          ContactDesktop(controller),
        ],
      ),
    );
  }
}
