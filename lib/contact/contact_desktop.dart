import 'package:flutter/material.dart';
import 'package:portfolio/navigation_bar/nav_bar_items.dart';
import 'package:portfolio/theme/theme_switcher.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactDesktop extends StatefulWidget {
  final AutoScrollController controller;
  ContactDesktop(this.controller);
  @override
  _ContactDesktopState createState() => _ContactDesktopState();
}

class _ContactDesktopState extends State<ContactDesktop> {
  @override
  Widget build(BuildContext context) {
    return AutoScrollTag(
      key: ValueKey(5),
      controller: widget.controller,
      index: 5,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 1.5,
        child: Row(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width / 2 + 100,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Let's make something amazing\ntogether.",
                      style: TextStyle(fontFamily: 'RobotoMono', fontSize: 40),
                    ),
                    Text(
                      "Start by saying hi",
                      style: TextStyle(
                          color: ThemeSwitcher.of(context).isDarkModeOn ? Colors.green : Colors.blue,
                          fontFamily: 'RobotoMono',
                          fontSize: 40),
                    ),
                    SizedBox(height: 20),
                    Text(
                      " © Amarjit Mallick",
                      style: TextStyle(fontFamily: 'RobotoMono', fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width / 2 - 100,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Information',
                        style: TextStyle(
                            color: ThemeSwitcher.of(context).isDarkModeOn
                                ? Colors.white.withOpacity(0.5)
                                : Colors.black.withOpacity(0.5),
                            fontFamily: 'RobotoMono',
                            fontSize: 10),
                      ),
                      Text(
                        'Email me:',
                        style: TextStyle(
                            color: ThemeSwitcher.of(context).isDarkModeOn
                                ? Colors.white.withOpacity(0.5)
                                : Colors.black.withOpacity(0.5),
                            fontFamily: 'RobotoMono',
                            fontSize: 20),
                      ),
                      Text(
                        "mallickamarjit@gmail.com",
                        style: TextStyle(
                            color: ThemeSwitcher.of(context).isDarkModeOn ? Colors.green : Colors.blue,
                            fontFamily: 'RobotoMono',
                            fontSize: 30),
                      ),
                      SizedBox(height: 20),
                      GestureDetector(
                        child: NavBarButton('Introduction'),
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
                        child: NavBarButton('Works'),
                        onTap: () async {
                          await widget.controller.scrollToIndex(2, preferPosition: AutoScrollPosition.begin);
                        },
                      ),
                      GestureDetector(
                        child: NavBarButton('Contact'),
                        onTap: () async {
                          await widget.controller.scrollToIndex(3, preferPosition: AutoScrollPosition.begin);
                        },
                      ),
                      SizedBox(height: 30),
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
                          SizedBox(width: 10),
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
                          SizedBox(width: 10),
                          GestureDetector(
                            onTap: () => launch("https://www.linkedin.com/in/amarjit-mallick/"),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              width: MediaQuery.of(context).size.width / 16,
                              child: Center(
                                child: ThemeSwitcher.of(context).isDarkModeOn
                                    ? Image(
                                        image: AssetImage('assets/icons/linkedin_white.png'),
                                        height: 20,
                                        width: 20,
                                      )
                                    : Image(
                                        image: AssetImage('assets/icons/linkedin_black.png'),
                                        height: 20,
                                        width: 20,
                                      ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          GestureDetector(
                            onTap: () => launch("https://www.instagram.com/amarjitmallick"),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              width: MediaQuery.of(context).size.width / 16,
                              child: Center(
                                child: ThemeSwitcher.of(context).isDarkModeOn
                                    ? Image(
                                        image: AssetImage('assets/icons/instagram_white.png'),
                                        height: 20,
                                        width: 20,
                                      )
                                    : Image(
                                        image: AssetImage('assets/icons/instagram_black.png'),
                                        height: 20,
                                        width: 20,
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
          ],
        ),
      ),
    );
  }
}
