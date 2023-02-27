import 'package:flutter/material.dart';
import 'package:portfolio/theme/theme_switcher.dart';

class CareerMobile extends StatefulWidget {
  const CareerMobile({Key key}) : super(key: key);

  @override
  State<CareerMobile> createState() => _CareerMobileState();
}

class _CareerMobileState extends State<CareerMobile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.symmetric(horizontal: 50),
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
                fontSize: 25,
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
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'RobotoMono',
                ),
                children: [
                  TextSpan(
                    text: '\n2022-present',
                    style: TextStyle(
                      color: ThemeSwitcher.of(context).isDarkModeOn ? Colors.white : Colors.black,
                      fontSize: 20,
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
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'RobotoMono',
                ),
                children: [
                  TextSpan(
                    text: '\n@ Multipie. 2021-2021',
                    style: TextStyle(
                      color: ThemeSwitcher.of(context).isDarkModeOn ? Colors.white : Colors.black,
                      fontSize: 20,
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
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'RobotoMono',
                ),
                children: [
                  TextSpan(
                    text: '\n@ BlackSpektro. 2021-2022',
                    style: TextStyle(
                      color: ThemeSwitcher.of(context).isDarkModeOn ? Colors.white : Colors.black,
                      fontSize: 20,
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
    );
  }
}
