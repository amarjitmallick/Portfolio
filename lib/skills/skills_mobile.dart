import 'package:flutter/material.dart';
import 'package:portfolio/theme/theme_switcher.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class SkillsMobile extends StatefulWidget {
  final AutoScrollController controller;
  SkillsMobile(this.controller);

  @override
  State<SkillsMobile> createState() => _SkillsMobileState();
}

class _SkillsMobileState extends State<SkillsMobile> {
  @override
  Widget build(BuildContext context) {
    return AutoScrollTag(
      key: ValueKey(2),
      controller: widget.controller,
      index: 2,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(vertical: 70, horizontal: 50),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: Text(
                  'my skills',
                  style: TextStyle(
                    color: ThemeSwitcher.of(context).isDarkModeOn ? Colors.white : Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'RobotoMono',
                  ),
                ),
              ),
              Expanded(
                child: GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  primary: false,
                  padding: EdgeInsets.symmetric(vertical: 50),
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/icons/flutter.png',
                            fit: BoxFit.scaleDown,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Flutter',
                            style: TextStyle(
                              color: ThemeSwitcher.of(context).isDarkModeOn
                                  ? ThemeData.dark(useMaterial3: true).colorScheme.secondary
                                  : Color(0xFF646AFF),
                              fontFamily: 'RobotoMono',
                              fontSize: 18,
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/icons/dart.png',
                            fit: BoxFit.scaleDown,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Dart',
                            style: TextStyle(
                              color: ThemeSwitcher.of(context).isDarkModeOn
                                  ? ThemeData.dark(useMaterial3: true).colorScheme.secondary
                                  : Color(0xFF646AFF),
                              fontFamily: 'RobotoMono',
                              fontSize: 18,
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/icons/firebase.png'),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Firebase',
                            style: TextStyle(
                              color: ThemeSwitcher.of(context).isDarkModeOn
                                  ? ThemeData.dark(useMaterial3: true).colorScheme.secondary
                                  : Color(0xFF646AFF),
                              fontFamily: 'RobotoMono',
                              fontSize: 18,
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/icons/git.png'),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Git',
                            style: TextStyle(
                              color: ThemeSwitcher.of(context).isDarkModeOn
                                  ? ThemeData.dark(useMaterial3: true).colorScheme.secondary
                                  : Color(0xFF646AFF),
                              fontFamily: 'RobotoMono',
                              fontSize: 18,
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/icons/github_2.png'),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Github',
                            style: TextStyle(
                              color: ThemeSwitcher.of(context).isDarkModeOn
                                  ? ThemeData.dark(useMaterial3: true).colorScheme.secondary
                                  : Color(0xFF646AFF),
                              fontFamily: 'RobotoMono',
                              fontSize: 18,
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
    );
  }
}
