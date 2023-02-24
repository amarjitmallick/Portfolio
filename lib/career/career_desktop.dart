import 'package:flutter/material.dart';
import 'package:portfolio/theme/theme_switcher.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class CareerDesktop extends StatefulWidget {
  final AutoScrollController controller;
  CareerDesktop(this.controller);

  @override
  State<CareerDesktop> createState() => _CareerDesktopState();
}

class _CareerDesktopState extends State<CareerDesktop> {
  @override
  Widget build(BuildContext context) {
    return AutoScrollTag(
      key: ValueKey(4),
      controller: widget.controller,
      index: 4,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 50),
        color: ThemeSwitcher.of(context).isDarkModeOn ? Color(0xFF1D2C33) : Colors.grey[100],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'my working career',
                style: TextStyle(
                  color: ThemeSwitcher.of(context).isDarkModeOn ? Colors.white : Colors.black,
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'RobotoMono',
                ),
              ),
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: RichText(
                text: TextSpan(
                  text: 'Freelance Mobile Application Developer',
                  style: TextStyle(
                    color: ThemeSwitcher.of(context).isDarkModeOn
                        ? ThemeData.dark(useMaterial3: true).colorScheme.secondary
                        : Color(0xFF646AFF),
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'RobotoMono',
                  ),
                  children: [
                    TextSpan(
                      text: ' 2022-present',
                      style: TextStyle(
                        color: ThemeSwitcher.of(context).isDarkModeOn ? Colors.white : Colors.black,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'RobotoMono',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: RichText(
                text: TextSpan(
                  text: 'Mobile Application Developer',
                  style: TextStyle(
                    color: ThemeSwitcher.of(context).isDarkModeOn
                        ? ThemeData.dark(useMaterial3: true).colorScheme.secondary
                        : Color(0xFF646AFF),
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'RobotoMono',
                  ),
                  children: [
                    TextSpan(
                      text: '  @ Multipie. 2021-2021',
                      style: TextStyle(
                        color: ThemeSwitcher.of(context).isDarkModeOn ? Colors.white : Colors.black,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'RobotoMono',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: RichText(
                text: TextSpan(
                  text: 'Mobile Application Developer',
                  style: TextStyle(
                    color: ThemeSwitcher.of(context).isDarkModeOn
                        ? ThemeData.dark(useMaterial3: true).colorScheme.secondary
                        : Color(0xFF646AFF),
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'RobotoMono',
                  ),
                  children: [
                    TextSpan(
                      text: '  @ BlackSpektro. 2021-2022',
                      style: TextStyle(
                        color: ThemeSwitcher.of(context).isDarkModeOn ? Colors.white : Colors.black,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'RobotoMono',
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
