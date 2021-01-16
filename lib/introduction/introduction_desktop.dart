import 'package:flutter/material.dart';
import 'package:hovering/hovering.dart';
import 'package:portfolio/theme/theme_switcher.dart';
import 'package:portfolio/utilities/constants.dart';

class IntroductionDesktop extends StatefulWidget {
  @override
  _IntroductionDesktopState createState() => _IntroductionDesktopState();
}

class _IntroductionDesktopState extends State<IntroductionDesktop> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: ThemeSwitcher.of(context).isDarkModeOn
          ? Color(0xFF25262A)
          : Colors.grey[100],
      child: Row(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width / 2,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(height: 50),
                  HoverAnimatedContainer(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: ThemeSwitcher.of(context).isDarkModeOn
                          ? Color(0xFF2D2E32)
                          : Colors.white,
                    ),
                    height: 200,
                    width: MediaQuery.of(context).size.width / 3,
                    hoverDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: ThemeSwitcher.of(context).isDarkModeOn
                          ? Color(0xFF2D2E32)
                          : Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: ThemeSwitcher.of(context).isDarkModeOn
                              ? Colors.black.withOpacity(0.35)
                              : Colors.grey[300].withOpacity(0.8),
                          blurRadius: 5.0, // soften the shadow
                          spreadRadius: 3.0, //extend the shadow
                        ),
                      ],
                    ),
                    duration: Duration(milliseconds: 100),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Design',
                                style: TextStyle(
                                    color:
                                        ThemeSwitcher.of(context).isDarkModeOn
                                            ? Colors.green
                                            : Colors.blue,
                                    fontFamily: 'RobotoMono',
                                    fontSize: 25),
                              ),
                              Icon(
                                Icons.settings_ethernet,
                                color: ThemeSwitcher.of(context).isDarkModeOn
                                    ? Colors.green
                                    : Colors.blue,
                              )
                            ],
                          ),
                          Text(
                            'data',
                            style: TextStyle(
                                color: ThemeSwitcher.of(context).isDarkModeOn
                                    ? Colors.white.withOpacity(0.5)
                                    : Colors.black.withOpacity(0.5),
                                fontFamily: 'RobotoMono',
                                fontSize: 10),
                          ),
                          Text(
                            'data',
                            style: TextStyle(
                                color: ThemeSwitcher.of(context).isDarkModeOn
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 11),
                          ),
                        ],
                      ),
                    ),
                  ),
                  HoverAnimatedContainer(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: ThemeSwitcher.of(context).isDarkModeOn
                          ? Color(0xFF2D2E32)
                          : Colors.white,
                    ),
                    height: 200,
                    width: MediaQuery.of(context).size.width / 3,
                    hoverDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: ThemeSwitcher.of(context).isDarkModeOn
                          ? Color(0xFF2D2E32)
                          : Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: ThemeSwitcher.of(context).isDarkModeOn
                              ? Colors.black.withOpacity(0.35)
                              : Colors.grey[300].withOpacity(0.8),
                          blurRadius: 5.0, // soften the shadow
                          spreadRadius: 3.0, //extend the shadow
                        ),
                      ],
                    ),
                    duration: Duration(milliseconds: 100),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Design',
                                style: TextStyle(
                                    color:
                                        ThemeSwitcher.of(context).isDarkModeOn
                                            ? Colors.green
                                            : Colors.blue,
                                    fontFamily: 'RobotoMono',
                                    fontSize: 25),
                              ),
                              Icon(
                                Icons.settings_ethernet,
                                color: ThemeSwitcher.of(context).isDarkModeOn
                                    ? Colors.green
                                    : Colors.blue,
                              )
                            ],
                          ),
                          Text(
                            'data',
                            style: TextStyle(
                                color: ThemeSwitcher.of(context).isDarkModeOn
                                    ? Colors.white.withOpacity(0.5)
                                    : Colors.black.withOpacity(0.5),
                                fontFamily: 'RobotoMono',
                                fontSize: 10),
                          ),
                          Text(
                            'data',
                            style: TextStyle(
                                color: ThemeSwitcher.of(context).isDarkModeOn
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 11),
                          ),
                        ],
                      ),
                    ),
                  ),
                  HoverAnimatedContainer(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: ThemeSwitcher.of(context).isDarkModeOn
                          ? Color(0xFF2D2E32)
                          : Colors.white,
                    ),
                    height: 200,
                    width: MediaQuery.of(context).size.width / 3,
                    hoverDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: ThemeSwitcher.of(context).isDarkModeOn
                          ? Color(0xFF2D2E32)
                          : Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: ThemeSwitcher.of(context).isDarkModeOn
                              ? Colors.black.withOpacity(0.35)
                              : Colors.grey[300].withOpacity(0.8),
                          blurRadius: 5.0, // soften the shadow
                          spreadRadius: 3.0, //extend the shadow
                        ),
                      ],
                    ),
                    duration: Duration(milliseconds: 100),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Design',
                                style: TextStyle(
                                    color:
                                        ThemeSwitcher.of(context).isDarkModeOn
                                            ? Colors.green
                                            : Colors.blue,
                                    fontFamily: 'RobotoMono',
                                    fontSize: 25),
                              ),
                              Icon(
                                Icons.settings_ethernet,
                                color: ThemeSwitcher.of(context).isDarkModeOn
                                    ? Colors.green
                                    : Colors.blue,
                              )
                            ],
                          ),
                          Text(
                            'data',
                            style: TextStyle(
                                color: ThemeSwitcher.of(context).isDarkModeOn
                                    ? Colors.white.withOpacity(0.5)
                                    : Colors.black.withOpacity(0.5),
                                fontFamily: 'RobotoMono',
                                fontSize: 10),
                          ),
                          Text(
                            'data',
                            style: TextStyle(
                                color: ThemeSwitcher.of(context).isDarkModeOn
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 11),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                ],
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width / 2,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50),
                  Text(
                    'Introduce',
                    style: TextStyle(
                        color: ThemeSwitcher.of(context).isDarkModeOn
                            ? Colors.white.withOpacity(0.5)
                            : Colors.black.withOpacity(0.5),
                        fontFamily: 'RobotoMono',
                        fontSize: 10),
                  ),
                  Text(
                    "Hello! I'm Amarjit\nMallick",
                    style: TextStyle(
                        color: ThemeSwitcher.of(context).isDarkModeOn
                            ? Colors.green
                            : Colors.blue,
                        fontFamily: 'RobotoMono',
                        fontSize: 40),
                  ),
                  Text(
                    'Every great design begin with an\neven better story',
                    style: TextStyle(
                        color: ThemeSwitcher.of(context).isDarkModeOn
                            ? Colors.white
                            : Colors.black,
                        fontFamily: 'RobotoMono',
                        fontSize: 25,
                        fontStyle: FontStyle.italic),
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
                  SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
