import 'package:flutter/material.dart';
import 'package:hovering/hovering.dart';
import 'package:portfolio/theme/theme_switcher.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class IntroductionDesktop extends StatefulWidget {
  final AutoScrollController controller;
  IntroductionDesktop(this.controller);

  @override
  _IntroductionDesktopState createState() => _IntroductionDesktopState();
}

class _IntroductionDesktopState extends State<IntroductionDesktop> {
  @override
  Widget build(BuildContext context) {
    return AutoScrollTag(
      key: ValueKey(1),
      controller: widget.controller,
      index: 1,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: ThemeSwitcher.of(context).isDarkModeOn
            ? Color(0xFF1D2C33) //Color(0xFF1D2C33)Colors.white
            : Colors.grey[100],
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width / 2,
                padding: EdgeInsets.all(100),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'a little about me ',
                        style: TextStyle(
                          color: ThemeSwitcher.of(context).isDarkModeOn ? Colors.white : Colors.black,
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'RobotoMono',
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: RichText(
                            text: TextSpan(
                              text: "I've been sailing the app development seas more than 2 years. "
                                  "I've been creating everything from regular apps and dashboards,"
                                  " all the way to complex mobile applications."
                                  "\n\nThe main characteristic of my work one could give for all these years has been simple:\n\n",
                              style: TextStyle(
                                color: ThemeSwitcher.of(context).isDarkModeOn ? Colors.white : Colors.black,
                                fontFamily: 'RobotoMono',
                                fontSize: 40,
                              ),
                              children: [
                                TextSpan(
                                  text: "Get things done. Fast!!!!!",
                                  style: TextStyle(
                                      color: ThemeSwitcher.of(context).isDarkModeOn
                                          ? Color(0xFF00D1C7)
                                          : Color(0xFF646AFF),
                                      fontFamily: 'RobotoMono',
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                    text:
                                        "\n\nI write clean and modern Dart code with a rigid code-style, and I do it really fast. "),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Expanded(
            //   child: Center(
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Padding(
            //           padding: const EdgeInsets.symmetric(horizontal: 50),
            //           child: Text(
            //             'My Skills',
            //             style: TextStyle(
            //               color: ThemeSwitcher.of(context).isDarkModeOn ? Colors.white : Colors.black,
            //               fontSize: 40,
            //               fontWeight: FontWeight.bold,
            //               fontFamily: 'RobotoMono',
            //             ),
            //           ),
            //         ),
            //         Expanded(
            //           child: GridView.count(
            //             shrinkWrap: true,
            //             crossAxisCount: 3,
            //             crossAxisSpacing: 15.0,
            //             mainAxisSpacing: 15.0,
            //             primary: false,
            //             padding: EdgeInsets.all(50),
            //             children: [
            //               ElevatedButton(
            //                 onPressed: () {},
            //                 style: ElevatedButton.styleFrom(
            //                   backgroundColor: Color(0xFF1D2C33).withOpacity(0.5),
            //                 ),
            //                 child: Column(
            //                   mainAxisAlignment: MainAxisAlignment.center,
            //                   children: [
            //                     Image.asset('assets/icons/flutter.png'),
            //                     Text(
            //                       'Flutter',
            //                       style: TextStyle(
            //                         color: ThemeSwitcher.of(context).isDarkModeOn
            //                             ? ThemeData.dark(useMaterial3: true).colorScheme.secondary
            //                             : Color(0xFF646AFF),
            //                         fontFamily: 'RobotoMono',
            //                         fontSize: 10,
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //               ElevatedButton(
            //                 onPressed: () {},
            //                 style: ElevatedButton.styleFrom(
            //                   backgroundColor: Color(0xFF1D2C33).withOpacity(0.5),
            //                 ),
            //                 child: Column(
            //                   mainAxisAlignment: MainAxisAlignment.center,
            //                   children: [
            //                     Image.asset('assets/icons/flutter.png'),
            //                     Text(
            //                       'Flutter',
            //                       style: TextStyle(
            //                         color: ThemeSwitcher.of(context).isDarkModeOn
            //                             ? ThemeData.dark(useMaterial3: true).colorScheme.secondary
            //                             : Color(0xFF646AFF),
            //                         fontFamily: 'RobotoMono',
            //                         fontSize: 10,
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //               ElevatedButton(
            //                 onPressed: () {},
            //                 style: ElevatedButton.styleFrom(
            //                   backgroundColor: Color(0xFF1D2C33).withOpacity(0.5),
            //                 ),
            //                 child: Column(
            //                   mainAxisAlignment: MainAxisAlignment.center,
            //                   children: [
            //                     Image.asset('assets/icons/flutter.png'),
            //                     Text(
            //                       'Flutter',
            //                       style: TextStyle(
            //                         color: ThemeSwitcher.of(context).isDarkModeOn
            //                             ? ThemeData.dark(useMaterial3: true).colorScheme.secondary
            //                             : Color(0xFF646AFF),
            //                         fontFamily: 'RobotoMono',
            //                         fontSize: 10,
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //               ElevatedButton(
            //                 onPressed: () {},
            //                 style: ElevatedButton.styleFrom(
            //                   backgroundColor: Color(0xFF1D2C33).withOpacity(0.5),
            //                 ),
            //                 child: Column(
            //                   mainAxisAlignment: MainAxisAlignment.center,
            //                   children: [
            //                     Image.asset('assets/icons/flutter.png'),
            //                     Text(
            //                       'Flutter',
            //                       style: TextStyle(
            //                         color: ThemeSwitcher.of(context).isDarkModeOn
            //                             ? ThemeData.dark(useMaterial3: true).colorScheme.secondary
            //                             : Color(0xFF646AFF),
            //                         fontFamily: 'RobotoMono',
            //                         fontSize: 10,
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //               ElevatedButton(
            //                 onPressed: () {},
            //                 style: ElevatedButton.styleFrom(
            //                   backgroundColor: Color(0xFF1D2C33).withOpacity(0.5),
            //                 ),
            //                 child: Column(
            //                   mainAxisAlignment: MainAxisAlignment.center,
            //                   children: [
            //                     Image.asset('assets/icons/flutter.png'),
            //                     Text(
            //                       'Flutter',
            //                       style: TextStyle(
            //                         color: ThemeSwitcher.of(context).isDarkModeOn
            //                             ? ThemeData.dark(useMaterial3: true).colorScheme.secondary
            //                             : Color(0xFF646AFF),
            //                         fontFamily: 'RobotoMono',
            //                         fontSize: 10,
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
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
