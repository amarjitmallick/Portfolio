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
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            opacity: 0.3,
            fit: BoxFit.fill,
            image: AssetImage('assets/images/bg.png'),
          ),
        ),
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
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2 - 100,
              height: MediaQuery.of(context).size.height / 2,
              padding: EdgeInsets.only(top: 50, bottom: 30),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: "Hi, I'm  ",
                          style: TextStyle(
                            color: ThemeSwitcher.of(context).isDarkModeOn ? Colors.white : Colors.black,
                            fontSize: 60,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'RobotoMono',
                          ),
                          children: [
                            TextSpan(
                              text: 'Amarjit',
                              style: TextStyle(
                                color: ThemeSwitcher.of(context).isDarkModeOn
                                    ? ThemeData.dark(useMaterial3: true).colorScheme.secondary
                                    : Color(0xFF646AFF),
                              ),
                            ),
                          ],
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Mobile Application Developer',
                        style: TextStyle(
                          color: ThemeSwitcher.of(context).isDarkModeOn
                              ? ThemeData.dark(useMaterial3: true).colorScheme.secondary
                              : Color(0xFF646AFF),
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'RobotoMono',
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'I design and code beautifully simple things using Flutter',
                        style: TextStyle(
                          color: ThemeSwitcher.of(context).isDarkModeOn ? Colors.white : Colors.black,
                          fontFamily: 'RobotoMono',
                          fontSize: 25,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Spacer(),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          backgroundColor: ThemeSwitcher.of(context).isDarkModeOn
                              ? ThemeData.dark(useMaterial3: true).colorScheme.secondary
                              : Color(0xFF646AFF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 25),
                        ),
                        child: Text(
                          "Download Resume",
                          style: TextStyle(
                            color: ThemeSwitcher.of(context).isDarkModeOn ? Colors.black : Colors.white,
                            fontFamily: 'RobotoMono',
                            fontSize: 25,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2 - 100,
              height: MediaQuery.of(context).size.height - 80,
              child: Center(
                child: CircleAvatar(
                  minRadius: 10,
                  maxRadius: MediaQuery.of(context).size.height / 3,
                  backgroundImage: ThemeSwitcher.of(context).isDarkModeOn
                      ? AssetImage('assets/images/profile_dark.png')
                      : AssetImage('assets/images/profile_light.png'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
