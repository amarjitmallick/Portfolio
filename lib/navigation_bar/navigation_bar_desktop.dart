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
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Spacer(),
            Container(
              width: MediaQuery.of(context).size.width / 2,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      child: NavBarButton('Home'),
                      onTap: () async {
                        await widget.controller.scrollToIndex(0, preferPosition: AutoScrollPosition.begin);
                      },
                    ),
                    GestureDetector(
                      child: NavBarButton('About'),
                      onTap: () async {
                        await widget.controller.scrollToIndex(1, preferPosition: AutoScrollPosition.begin);
                      },
                    ),
                    GestureDetector(
                      child: NavBarButton('Skills'),
                      onTap: () async {
                        await widget.controller.scrollToIndex(2, preferPosition: AutoScrollPosition.begin);
                      },
                    ),
                    GestureDetector(
                      child: NavBarButton('Portfolio'),
                      onTap: () async {
                        await widget.controller.scrollToIndex(3, preferPosition: AutoScrollPosition.begin);
                      },
                    ),
                    GestureDetector(
                      child: NavBarButton('Career'),
                      onTap: () async {
                        await widget.controller.scrollToIndex(4, preferPosition: AutoScrollPosition.begin);
                      },
                    ),
                    GestureDetector(
                      child: NavBarButton('Contact'),
                      onTap: () async {
                        await widget.controller.scrollToIndex(5, preferPosition: AutoScrollPosition.begin);
                      },
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
