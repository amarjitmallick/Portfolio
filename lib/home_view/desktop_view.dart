import 'package:flutter/material.dart';
import 'package:portfolio/contact/contact_desktop.dart';
import 'package:portfolio/introduction/introduction_desktop.dart';
import 'package:portfolio/landing_page/landing_page_desktop.dart';
import 'package:portfolio/latest_works/latest_works_desktop.dart';
import 'package:portfolio/navigation_bar/navigation_bar_desktop.dart';
import 'package:portfolio/utilities/constants.dart';

class DesktopView extends StatefulWidget {
  @override
  _DesktopViewState createState() => _DesktopViewState();
}

class _DesktopViewState extends State<DesktopView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            NavigationBarDesktop(),
            LandingPageDesktop(),
            IntroductionDesktop(),
            LatestWorksDesktop(),
            ContactDesktop(),
          ],
        ),
      ),
    );
  }
}
