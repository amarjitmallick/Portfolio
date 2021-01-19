import 'package:flutter/material.dart';

import 'package:portfolio/navigation_bar/nav_bar_items.dart';
import 'package:portfolio/theme/theme_switcher.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class NavigationBarDesktop extends StatefulWidget {
  final AutoScrollController controller;
  NavigationBarDesktop(this.controller);
  @override
  _NavigationBarDesktopState createState() => _NavigationBarDesktopState();
}

class _NavigationBarDesktopState extends State<NavigationBarDesktop> {
  @override
  Widget build(BuildContext context) {
    return Container(
      key: widget.key,
      height: 80,
      width: MediaQuery.of(context).size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          NameTag(),
          Container(
            width: MediaQuery.of(context).size.width / 2,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    child: NavBarButton('Introduction'),
                    onTap: () async {
                      await widget.controller.scrollToIndex(0,
                          preferPosition: AutoScrollPosition.begin);
                    },
                  ),
                  GestureDetector(
                    child: NavBarButton('About'),
                    onTap: () async {
                      await widget.controller.scrollToIndex(1,
                          preferPosition: AutoScrollPosition.begin);
                    },
                  ),
                  GestureDetector(
                    child: NavBarButton('Works'),
                    onTap: () async {
                      await widget.controller.scrollToIndex(2,
                          preferPosition: AutoScrollPosition.begin);
                    },
                  ),
                  GestureDetector(
                    child: NavBarButton('Contact'),
                    onTap: () async {
                      await widget.controller.scrollToIndex(3,
                          preferPosition: AutoScrollPosition.begin);
                    },
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () => launch("https://twitter.com/AmarjitM13"),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  width: MediaQuery.of(context).size.width / 16,
                  child: Center(
                    child: ThemeSwitcher.of(context).isDarkModeOn
                        ? Image(
                            image: AssetImage('assets/icons/twitter_white.png'),
                            height: 20,
                            width: 20,
                          )
                        : Image(
                            image: AssetImage('assets/icons/twitter_black.png'),
                            height: 20,
                            width: 20,
                          ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => launch("https://github.com/AmarjitM13"),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  width: MediaQuery.of(context).size.width / 16,
                  child: Center(
                    child: ThemeSwitcher.of(context).isDarkModeOn
                        ? Image(
                            image: AssetImage('assets/icons/github_white.png'),
                            height: 22,
                            width: 22,
                          )
                        : Image(
                            image: AssetImage('assets/icons/github_black.png'),
                            height: 22,
                            width: 22,
                          ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () =>
                    launch("https://www.linkedin.com/in/amarjit-mallick/"),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  width: MediaQuery.of(context).size.width / 16,
                  child: Center(
                    child: ThemeSwitcher.of(context).isDarkModeOn
                        ? Image(
                            image:
                                AssetImage('assets/icons/linkedin_white.png'),
                            height: 20,
                            width: 20,
                          )
                        : Image(
                            image:
                                AssetImage('assets/icons/linkedin_black.png'),
                            height: 20,
                            width: 20,
                          ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 16,
                child: Center(
                  child: GestureDetector(
                    onTap: () => ThemeSwitcher.of(context).switchDarkMode(),
                    child: ThemeSwitcher.of(context).isDarkModeOn
                        ? Icon(Icons.wb_sunny_rounded)
                        : Image(
                            image: AssetImage('assets/icons/dark.png'),
                            height: 24,
                            width: 24,
                          ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
