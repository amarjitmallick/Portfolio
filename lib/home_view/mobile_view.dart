import 'package:flutter/material.dart';
import 'package:portfolio/career/career_mobile.dart';
import 'package:portfolio/contact/contact_mobile.dart';
import 'package:portfolio/introduction/about_mobile.dart';
import 'package:portfolio/landing_page/landing_page_mobile.dart';
import 'package:portfolio/navigation_bar/nav_bar_items.dart';
import 'package:portfolio/navigation_bar/navigation_bar_mobile.dart';
import 'package:portfolio/portfolio/portfolio_mobile.dart';
import 'package:portfolio/skills/skills_mobile.dart';
import 'package:portfolio/theme/theme_switcher.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class MobileView extends StatefulWidget {
  @override
  _MobileViewState createState() => _MobileViewState();
}

class _MobileViewState extends State<MobileView> {
  final scrollDirection = Axis.vertical;
  AutoScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = AutoScrollController(
      viewportBoundaryGetter: () => Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
      axis: scrollDirection,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      endDrawer: CustomDrawer(controller),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            NavigationBarMobile(),
          ];
        },
        body: ListView(
          scrollDirection: scrollDirection,
          controller: controller,
          children: [
            LandingPageMobile(controller),
            AboutMobile(controller),
            SkillsMobile(controller),
            PortfolioMobile(controller),
            CareerMobile(controller),
            ContactMobile(controller),
          ],
        ),
      ),
    );
  }
}

class CustomDrawer extends StatefulWidget {
  final AutoScrollController controller;
  CustomDrawer(this.controller);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Scaffold(
        body: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  child: NavBarButton('Home'),
                  onTap: () async {
                    Navigator.pop(context);
                    await widget.controller.scrollToIndex(0, preferPosition: AutoScrollPosition.begin);
                  },
                ),
                GestureDetector(
                  child: NavBarButton('About'),
                  onTap: () async {
                    Navigator.pop(context);
                    await widget.controller.scrollToIndex(1, preferPosition: AutoScrollPosition.begin);
                  },
                ),
                GestureDetector(
                  child: NavBarButton('Skills'),
                  onTap: () async {
                    Navigator.pop(context);
                    await widget.controller.scrollToIndex(2, preferPosition: AutoScrollPosition.begin);
                  },
                ),
                GestureDetector(
                  child: NavBarButton('Portfolio'),
                  onTap: () async {
                    Navigator.pop(context);
                    await widget.controller.scrollToIndex(3, preferPosition: AutoScrollPosition.begin);
                  },
                ),
                GestureDetector(
                  child: NavBarButton('Career'),
                  onTap: () async {
                    Navigator.pop(context);
                    await widget.controller.scrollToIndex(4, preferPosition: AutoScrollPosition.begin);
                  },
                ),
                GestureDetector(
                  child: NavBarButton('Contact'),
                  onTap: () async {
                    Navigator.pop(context);
                    await widget.controller.scrollToIndex(5, preferPosition: AutoScrollPosition.begin);
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: ThemeSwitcher.of(context).isDarkModeOn ? Text('Dark Mode') : Text('Light Mode'),
                    ),
                    SizedBox(width: 40),
                    Switch(
                      value: ThemeSwitcher.of(context).isDarkModeOn,
                      onChanged: (val) => ThemeSwitcher.of(context).switchDarkMode(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
