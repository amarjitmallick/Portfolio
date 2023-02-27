import 'package:flutter/material.dart';
import 'package:portfolio/theme/theme_switcher.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:url_launcher/url_launcher.dart';

class PortfolioMobile extends StatefulWidget {
  final AutoScrollController controller;
  PortfolioMobile(this.controller);

  @override
  _PortfolioMobileState createState() => _PortfolioMobileState();
}

class _PortfolioMobileState extends State<PortfolioMobile> {
  @override
  Widget build(BuildContext context) {
    return AutoScrollTag(
      key: ValueKey(3),
      controller: widget.controller,
      index: 3,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'my portfolio',
                style: TextStyle(
                  color: ThemeSwitcher.of(context).isDarkModeOn ? Colors.white : Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'RobotoMono',
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              "A small gallery of recent projects chosen by me.",
              style: TextStyle(
                color: ThemeSwitcher.of(context).isDarkModeOn ? Colors.white : Colors.black,
                fontFamily: 'RobotoMono',
                fontSize: 20,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              textAlign: TextAlign.center,
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        color: Colors.transparent.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.folder_open_rounded,
                                    color:
                                        ThemeSwitcher.of(context).isDarkModeOn ? Color(0xFF00D1C7) : Color(0xFF646AFF),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      launch('https://github.com/AmarjitM13/Portfolio');
                                    },
                                    child: Icon(
                                      Icons.link_rounded,
                                      color: ThemeSwitcher.of(context).isDarkModeOn
                                          ? Color(0xFF00D1C7)
                                          : Color(0xFF646AFF),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    'Portfolio',
                                    style: TextStyle(
                                      color: ThemeSwitcher.of(context).isDarkModeOn ? Colors.white : Colors.black,
                                      fontFamily: 'RobotoMono',
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  'A responsive portfolio website',
                                  style: TextStyle(
                                    color: ThemeSwitcher.of(context).isDarkModeOn ? Colors.white : Colors.black,
                                    fontFamily: 'RobotoMono',
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                                    margin: EdgeInsets.only(right: 15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: ThemeSwitcher.of(context).isDarkModeOn
                                          ? Color(0xFF00D1C7).withOpacity(0.2)
                                          : Color(0xFF646AFF).withOpacity(0.2),
                                    ),
                                    child: Text('Flutter'),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                                    margin: EdgeInsets.only(right: 15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: ThemeSwitcher.of(context).isDarkModeOn
                                          ? Color(0xFF00D1C7).withOpacity(0.2)
                                          : Color(0xFF646AFF).withOpacity(0.2),
                                    ),
                                    child: Text('Dart'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        color: Colors.transparent.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.folder_open_rounded,
                                    color:
                                        ThemeSwitcher.of(context).isDarkModeOn ? Color(0xFF00D1C7) : Color(0xFF646AFF),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      launch('https://play.google.com/store/apps/details?id=me.amarjitmallick.xpense');
                                    },
                                    child: Icon(
                                      Icons.link_rounded,
                                      color: ThemeSwitcher.of(context).isDarkModeOn
                                          ? Color(0xFF00D1C7)
                                          : Color(0xFF646AFF),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    'Xpense',
                                    style: TextStyle(
                                      color: ThemeSwitcher.of(context).isDarkModeOn ? Colors.white : Colors.black,
                                      fontFamily: 'RobotoMono',
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  'An expense management app',
                                  style: TextStyle(
                                    color: ThemeSwitcher.of(context).isDarkModeOn ? Colors.white : Colors.black,
                                    fontFamily: 'RobotoMono',
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                                    margin: EdgeInsets.only(right: 15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: ThemeSwitcher.of(context).isDarkModeOn
                                          ? Color(0xFF00D1C7).withOpacity(0.2)
                                          : Color(0xFF646AFF).withOpacity(0.2),
                                    ),
                                    child: Text('Flutter'),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                                    margin: EdgeInsets.only(right: 15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: ThemeSwitcher.of(context).isDarkModeOn
                                          ? Color(0xFF00D1C7).withOpacity(0.2)
                                          : Color(0xFF646AFF).withOpacity(0.2),
                                    ),
                                    child: Text('Dart'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
