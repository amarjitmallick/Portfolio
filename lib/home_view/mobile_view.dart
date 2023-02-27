import 'package:flutter/material.dart';
import 'package:hovering/hovering.dart';
import 'package:portfolio/contact/contact_mobile.dart';
import 'package:portfolio/introduction/about_mobile.dart';
import 'package:portfolio/landing_page/landing_page_mobile.dart';
import 'package:portfolio/latest_works/latest_works_mobile.dart';
import 'package:portfolio/navigation_bar/nav_bar_items.dart';
import 'package:portfolio/navigation_bar/navigation_bar_mobile.dart';
import 'package:portfolio/skills/skills_mobile.dart';
import 'package:portfolio/utilities/constants.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:url_launcher/url_launcher.dart';

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
      endDrawer: CustomDrawer(),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            NavigationBarMobile(),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            children: [
              LandingPageMobile(),
              AboutMobile(),
              SkillsMobile(controller),
              LatestWorksMobile(),
              ContactMobile(),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NavBarButton('Services'),
                NavBarButton('Works'),
                NavBarButton('Notes'),
                NavBarButton('Contacts'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text('Dark Mode'),
                    ),
                    SizedBox(width: 40),
                    Switch(
                      value: false,
                      onChanged: null,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: Center(
                        child: GestureDetector(
                          onTap: () => launch("https://twitter.com/AmarjitM13"),
                          child: HoverCrossFadeWidget(
                            firstCurve: Curves.linear,
                            secondCurve: Curves.linearToEaseOut,
                            sizeCurve: Curves.linear,
                            alignmentry: Alignment.center,
                            reverseDuration: Duration(milliseconds: 125),
                            duration: Duration(milliseconds: 150),
                            firstChild: CircleAvatar(
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image(
                                    height: 48,
                                    width: 48,
                                    image: AssetImage('assets/icons/twitter.png'),
                                  ),
                                ),
                              ),
                              backgroundColor: Colors.transparent,
                              radius: 20,
                            ),
                            secondChild: CircleAvatar(
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Image(
                                    height: 48,
                                    width: 48,
                                    image: AssetImage('assets/icons/twitter.png'),
                                  ),
                                ),
                              ),
                              backgroundColor: Colors.transparent,
                              radius: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Center(
                        child: GestureDetector(
                          onTap: () => launch("https://github.com/AmarjitM13"),
                          child: HoverCrossFadeWidget(
                            firstCurve: Curves.linear,
                            secondCurve: Curves.linearToEaseOut,
                            sizeCurve: Curves.linear,
                            alignmentry: Alignment.center,
                            reverseDuration: Duration(milliseconds: 125),
                            duration: Duration(milliseconds: 150),
                            firstChild: CircleAvatar(
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image(
                                    height: 48,
                                    width: 48,
                                    image: AssetImage('assets/icons/github.png'),
                                  ),
                                ),
                              ),
                              backgroundColor: Colors.transparent,
                              radius: 20,
                            ),
                            secondChild: CircleAvatar(
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Image(
                                    height: 48,
                                    width: 48,
                                    image: AssetImage('assets/icons/github.png'),
                                  ),
                                ),
                              ),
                              backgroundColor: Colors.transparent,
                              radius: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Center(
                        child: GestureDetector(
                          onTap: () => launch("https://www.google.com/intl/en-GB/gmail/about/#"),
                          child: HoverCrossFadeWidget(
                            firstCurve: Curves.linear,
                            secondCurve: Curves.linearToEaseOut,
                            sizeCurve: Curves.linear,
                            alignmentry: Alignment.center,
                            reverseDuration: Duration(milliseconds: 125),
                            duration: Duration(milliseconds: 150),
                            firstChild: CircleAvatar(
                              child: Center(
                                child: Icon(
                                  Icons.mail_outline_rounded,
                                  color: Colors.white.withOpacity(0.9),
                                  size: 25,
                                ),
                              ),
                              backgroundColor: Colors.transparent,
                              radius: 20,
                            ),
                            secondChild: CircleAvatar(
                              child: Center(
                                child: Icon(
                                  Icons.mail_outline_rounded,
                                  color: Colors.white.withOpacity(0.9),
                                  size: 29,
                                ),
                              ),
                              backgroundColor: Colors.transparent,
                              radius: 20,
                            ),
                          ),
                        ),
                      ),
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
