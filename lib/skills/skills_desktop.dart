import 'package:flutter/material.dart';
import 'package:hovering/hovering.dart';
import 'package:portfolio/theme/theme_switcher.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class SkillsDesktop extends StatefulWidget {
  final AutoScrollController controller;
  SkillsDesktop(this.controller);

  @override
  State<SkillsDesktop> createState() => _SkillsDesktopState();
}

class _SkillsDesktopState extends State<SkillsDesktop> {
  @override
  Widget build(BuildContext context) {
    return AutoScrollTag(
      key: ValueKey(2),
      controller: widget.controller,
      index: 2,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: Text(
                'my skills',
                style: TextStyle(
                  color: ThemeSwitcher.of(context).isDarkModeOn ? Colors.white : Colors.black,
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'RobotoMono',
                ),
              ),
            ),
            Expanded(
              child: GridView.count(
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 15.0,
                mainAxisSpacing: 15.0,
                childAspectRatio: 3.5,
                primary: false,
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 50),
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          ThemeSwitcher.of(context).isDarkModeOn ? Color(0xFF1D2C33).withOpacity(0.5) : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/icons/flutter.png'),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Flutter',
                          style: TextStyle(
                            color: ThemeSwitcher.of(context).isDarkModeOn
                                ? ThemeData.dark(useMaterial3: true).colorScheme.secondary
                                : Color(0xFF646AFF),
                            fontFamily: 'RobotoMono',
                            fontSize: 50,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          ThemeSwitcher.of(context).isDarkModeOn ? Color(0xFF1D2C33).withOpacity(0.5) : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/icons/dart.png'),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Dart',
                          style: TextStyle(
                            color: ThemeSwitcher.of(context).isDarkModeOn
                                ? ThemeData.dark(useMaterial3: true).colorScheme.secondary
                                : Color(0xFF646AFF),
                            fontFamily: 'RobotoMono',
                            fontSize: 50,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          ThemeSwitcher.of(context).isDarkModeOn ? Color(0xFF1D2C33).withOpacity(0.5) : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/icons/firebase.png'),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Firebase',
                          style: TextStyle(
                            color: ThemeSwitcher.of(context).isDarkModeOn
                                ? ThemeData.dark(useMaterial3: true).colorScheme.secondary
                                : Color(0xFF646AFF),
                            fontFamily: 'RobotoMono',
                            fontSize: 50,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          ThemeSwitcher.of(context).isDarkModeOn ? Color(0xFF1D2C33).withOpacity(0.5) : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/icons/git.png'),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Git',
                          style: TextStyle(
                            color: ThemeSwitcher.of(context).isDarkModeOn
                                ? ThemeData.dark(useMaterial3: true).colorScheme.secondary
                                : Color(0xFF646AFF),
                            fontFamily: 'RobotoMono',
                            fontSize: 50,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          ThemeSwitcher.of(context).isDarkModeOn ? Color(0xFF1D2C33).withOpacity(0.5) : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/icons/github_2.png'),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Github',
                          style: TextStyle(
                            color: ThemeSwitcher.of(context).isDarkModeOn
                                ? ThemeData.dark(useMaterial3: true).colorScheme.secondary
                                : Color(0xFF646AFF),
                            fontFamily: 'RobotoMono',
                            fontSize: 50,
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
    );
  }
}

class CardView extends StatefulWidget {
  const CardView({
    Key key,
  }) : super(key: key);

  @override
  _CardViewState createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  @override
  Widget build(BuildContext context) {
    return HoverAnimatedContainer(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: ThemeSwitcher.of(context).isDarkModeOn ? Color(0xFF2D2E32) : Colors.white,
      ),
      hoverDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: ThemeSwitcher.of(context).isDarkModeOn ? Color(0xFF2D2E32) : Colors.white,
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
          children: [
            Image.asset('assets/icons/flutter.png'),
            Text(
              'Flutter',
              style: TextStyle(
                color: ThemeSwitcher.of(context).isDarkModeOn
                    ? ThemeData.dark(useMaterial3: true).colorScheme.secondary
                    : Color(0xFF646AFF),
                fontFamily: 'RobotoMono',
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
