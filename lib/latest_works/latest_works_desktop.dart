import 'package:flutter/material.dart';
import 'package:portfolio/theme/theme_switcher.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class LatestWorksDesktop extends StatefulWidget {
  final AutoScrollController controller;
  LatestWorksDesktop(this.controller);

  @override
  _LatestWorksDesktopState createState() => _LatestWorksDesktopState();
}

class _LatestWorksDesktopState extends State<LatestWorksDesktop> {
  @override
  Widget build(BuildContext context) {
    return AutoScrollTag(
      key: ValueKey(3),
      controller: widget.controller,
      index: 3,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 2,
        color: ThemeSwitcher.of(context).isDarkModeOn ? Color(0xFF25262A) : Colors.grey[100],
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height * 2,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 3.6,
                      width: MediaQuery.of(context).size.height / 1.8,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Latest Works',
                              style: TextStyle(fontFamily: 'RobotoMono', fontSize: 40),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Perfect solutions for digital experience',
                              style: TextStyle(
                                  color: ThemeSwitcher.of(context).isDarkModeOn
                                      ? Colors.white.withOpacity(0.5)
                                      : Colors.black.withOpacity(0.5),
                                  fontFamily: 'RobotoMono',
                                  fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 1.5,
                      width: MediaQuery.of(context).size.height / 1.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: LinearGradient(
                          colors: [
                            ThemeSwitcher.of(context).isDarkModeOn ? Color(0xFF16191E) : Colors.grey[200],
                            ThemeSwitcher.of(context).isDarkModeOn ? Color(0xFF272729) : Color(0xFFf5f4f4),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height / 6,
                            width: MediaQuery.of(context).size.height / 1.5,
                            child: Row(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.height / 3,
                                  child: Center(
                                    child: Text(
                                      'Portfolio',
                                      style: TextStyle(
                                        fontSize: 25,
                                        color: ThemeSwitcher.of(context).isDarkModeOn ? Colors.white : Colors.blue,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.height / 3,
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          color: ThemeSwitcher.of(context).isDarkModeOn
                                              ? Color(0xFF272729)
                                              : Colors.grey[200],
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                                            child: Text(
                                              'Dart',
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Container(
                                          color: ThemeSwitcher.of(context).isDarkModeOn
                                              ? Color(0xFF272729)
                                              : Colors.grey[200],
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                                            child: Text(
                                              'Flutter',
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
                          Padding(
                            padding: const EdgeInsets.only(right: 40),
                            child: ThemeSwitcher.of(context).isDarkModeOn
                                ? Image(
                                    image: AssetImage('assets/images/portfolio.png'),
                                  )
                                : Image(
                                    image: AssetImage('assets/images/portfolio_light.png'),
                                  ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 3.6,
                      width: MediaQuery.of(context).size.height / 1.8,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'ALL PROJECTS',
                              style: TextStyle(
                                  color: ThemeSwitcher.of(context).isDarkModeOn ? Colors.green : Colors.blue,
                                  fontFamily: 'RobotoMono',
                                  fontSize: 25,
                                  decoration: TextDecoration.underline),
                            ),
                            SizedBox(height: 30),
                            Text(
                              '*Some projects are not allowed to publish.\nIf you want to see more, contact ',
                              style: TextStyle(
                                  color: ThemeSwitcher.of(context).isDarkModeOn
                                      ? Colors.white.withOpacity(0.5)
                                      : Colors.black.withOpacity(0.5),
                                  fontFamily: 'RobotoMono',
                                  fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height * 2,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 1.5,
                      width: MediaQuery.of(context).size.height / 1.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: LinearGradient(colors: [
                          ThemeSwitcher.of(context).isDarkModeOn ? Color(0xFF2D3037) : Color(0xFFf5f4f4),
                          ThemeSwitcher.of(context).isDarkModeOn ? Color(0xFF25262A) : Colors.grey[200],
                        ], begin: Alignment.topRight, end: Alignment.bottomLeft),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height / 6,
                            width: MediaQuery.of(context).size.height / 1.5,
                            child: Row(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.height / 3,
                                  child: Center(
                                    child: Text(
                                      'Cardify',
                                      style: TextStyle(
                                        fontSize: 25,
                                        color: ThemeSwitcher.of(context).isDarkModeOn ? Colors.green : Colors.blue,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.height / 3,
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          color: ThemeSwitcher.of(context).isDarkModeOn
                                              ? Colors.transparent
                                              : Colors.grey[200],
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                                            child: Text(
                                              'Dart',
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Container(
                                          color: ThemeSwitcher.of(context).isDarkModeOn
                                              ? Colors.transparent
                                              : Colors.grey[200],
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                                            child: Text(
                                              'Flutter',
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
                        ],
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 1.5,
                      width: MediaQuery.of(context).size.height / 1.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: LinearGradient(colors: [
                          ThemeSwitcher.of(context).isDarkModeOn ? Color(0xFF2D3037) : Color(0xFFf5f4f4),
                          ThemeSwitcher.of(context).isDarkModeOn ? Color(0xFF25262A) : Colors.grey[200],
                        ], begin: Alignment.bottomLeft, end: Alignment.topRight),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height / 6,
                            width: MediaQuery.of(context).size.height / 1.5,
                            child: Row(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.height / 3,
                                  child: Center(
                                    child: Text(
                                      'Formatics',
                                      style: TextStyle(
                                        fontSize: 25,
                                        color: ThemeSwitcher.of(context).isDarkModeOn ? Colors.green : Colors.blue,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.height / 3,
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          color: ThemeSwitcher.of(context).isDarkModeOn
                                              ? Colors.transparent
                                              : Colors.grey[200],
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                                            child: Text(
                                              'Dart',
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Container(
                                          color: ThemeSwitcher.of(context).isDarkModeOn
                                              ? Colors.transparent
                                              : Colors.grey[200],
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                                            child: Text(
                                              'Flutter',
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
                        ],
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
