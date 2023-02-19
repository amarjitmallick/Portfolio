import 'package:flutter/material.dart';
import 'package:hovering/hovering.dart';
import 'package:portfolio/theme/theme_switcher.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:url_launcher/url_launcher.dart';

class LandingPageDesktop extends StatefulWidget {
  final AutoScrollController controller;
  LandingPageDesktop(this.controller);
  @override
  _LandingPageDesktopState createState() => _LandingPageDesktopState();
}

class _LandingPageDesktopState extends State<LandingPageDesktop> {
  @override
  Widget build(BuildContext context) {
    return AutoScrollTag(
      key: ValueKey(0),
      controller: widget.controller,
      index: 0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - 80,
        child: Row(
          children: [
            Container(
              width: 200,
              height: MediaQuery.of(context).size.height / 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        launch('https://github.com/AmarjitM13');
                      },
                      child: Image.asset(
                        'assets/icons/github.png',
                        scale: 2,
                        color: ThemeSwitcher.of(context).isDarkModeOn
                            ? ThemeData.dark(useMaterial3: true).colorScheme.secondary
                            : Color(0xFF646AFF),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        launch('https://www.linkedin.com/in/amarjit-mallick/');
                      },
                      child: Image.asset(
                        'assets/icons/linkedin.png',
                        scale: 2,
                        color: ThemeSwitcher.of(context).isDarkModeOn
                            ? ThemeData.dark(useMaterial3: true).colorScheme.secondary
                            : Color(0xFF646AFF),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        launch('https://twitter.com/AmarjitM13');
                      },
                      child: Image.asset(
                        'assets/icons/twitter.png',
                        scale: 2,
                        color: ThemeSwitcher.of(context).isDarkModeOn
                            ? ThemeData.dark(useMaterial3: true).colorScheme.secondary
                            : Color(0xFF646AFF),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: 2,
                      color: ThemeSwitcher.of(context).isDarkModeOn
                          ? ThemeData.dark(useMaterial3: true).colorScheme.secondary
                          : Color(0xFF646AFF),
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2 - 100,
              height: MediaQuery.of(context).size.height - 80,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 50),
                    Container(
                      decoration: BoxDecoration(
                          color: ThemeSwitcher.of(context).isDarkModeOn ? Colors.green : Colors.blue,
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          ' Mobile Application Developer ',
                          style: TextStyle(
                              color: ThemeSwitcher.of(context).isDarkModeOn ? Colors.black : Colors.white,
                              fontFamily: 'RobotoMono',
                              fontSize: 20),
                        ),
                      ),
                    ),
                    Text(
                      'Talk is cheap.\nShow me the code',
                      style: TextStyle(
                          color: ThemeSwitcher.of(context).isDarkModeOn ? Colors.white : Colors.black,
                          fontFamily: 'RobotoMono',
                          fontSize: 40),
                    ),
                    Text(
                      'I design and code beautifully simple things\nand I love what I do.',
                      style: TextStyle(
                          color: ThemeSwitcher.of(context).isDarkModeOn
                              ? Colors.white.withOpacity(0.5)
                              : Colors.black.withOpacity(0.5),
                          fontFamily: 'RobotoMono',
                          fontSize: 10),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "LET'S CHAT!",
                      style: TextStyle(
                          color: ThemeSwitcher.of(context).isDarkModeOn ? Colors.green : Colors.blue,
                          fontFamily: 'RobotoMono',
                          fontSize: 25),
                    ),
                    SizedBox(height: 100),
                  ],
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2 - 100,
              height: MediaQuery.of(context).size.height - 80,
              child: Stack(
                children: [
                  Center(
                    child: Image.asset('assets/images/profile.png'),
                  ),
                  Positioned(
                    right: 180,
                    top: 60,
                    child: CircleAvatar(
                      radius: 12,
                      backgroundColor: ThemeSwitcher.of(context).isDarkModeOn ? Colors.green : Colors.blue,
                    ),
                  ),
                  Positioned(
                    right: 30,
                    bottom: 350,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: ThemeSwitcher.of(context).isDarkModeOn ? Color(0xFF25262A) : Colors.grey[200],
                    ),
                  ),
                  Positioned(
                    right: 65,
                    bottom: 35,
                    child: HoverAnimatedContainer(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ThemeSwitcher.of(context).isDarkModeOn ? Color(0xFF25262A) : Colors.grey[100],
                      ),
                      height: MediaQuery.of(context).size.height / 4,
                      width: MediaQuery.of(context).size.height / 4,
                      hoverDecoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ThemeSwitcher.of(context).isDarkModeOn ? Color(0xFF25262A) : Colors.grey[100],
                        boxShadow: [
                          BoxShadow(
                            color: ThemeSwitcher.of(context).isDarkModeOn ? Color(0xFF25262A) : Colors.grey[100],
                            blurRadius: 5.0, // soften the shadow
                            spreadRadius: 5.0, //extend the shadow
                          ),
                        ],
                      ),
                      duration: Duration(milliseconds: 120),
                      child: Center(
                        child: Image(
                          image: AssetImage('assets/icons/dart.png'),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    bottom: 220,
                    child: HoverAnimatedContainer(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ThemeSwitcher.of(context).isDarkModeOn ? Color(0xFF25262A) : Colors.grey[100],
                      ),
                      height: MediaQuery.of(context).size.height / 5,
                      width: MediaQuery.of(context).size.height / 5,
                      hoverDecoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ThemeSwitcher.of(context).isDarkModeOn ? Color(0xFF25262A) : Colors.grey[100],
                        boxShadow: [
                          BoxShadow(
                            color: ThemeSwitcher.of(context).isDarkModeOn
                                ? Color(0xFF25262A).withOpacity(0.8)
                                : Colors.grey[100].withOpacity(0.8),
                            blurRadius: 5.0, // soften the shadow
                            spreadRadius: 5.0, //extend the shadow
                          ),
                        ],
                      ),
                      duration: Duration(milliseconds: 100),
                      child: Center(
                        child: Image(
                          image: AssetImage('assets/icons/flutter.png'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
