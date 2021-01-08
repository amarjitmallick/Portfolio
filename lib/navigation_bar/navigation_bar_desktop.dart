import 'package:flutter/material.dart';
import 'package:hovering/hovering.dart';
import 'package:portfolio/navigation_bar/nav_bar_items.dart';
import 'package:url_launcher/url_launcher.dart';

class NavigationBarDesktop extends StatefulWidget {
  @override
  _NavigationBarDesktopState createState() => _NavigationBarDesktopState();
}

class _NavigationBarDesktopState extends State<NavigationBarDesktop> {
  @override
  Widget build(BuildContext context) {
    return Container(
      key: widget.key,
      height: 80,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          NameTag(),
          Container(
            width: MediaQuery.of(context).size.width / 2,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  NavBarButton('Services'),
                  NavBarButton('Works'),
                  NavBarButton('Notes'),
                  NavBarButton('Contacts'),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 16,
                child: Center(
                  child: GestureDetector(
                    onTap: () => launch("https://twitter.com/AmarjitM13"),
                    child: HoverCrossFadeWidget(
                      firstCurve: Curves.linear,
                      secondCurve: Curves.linearToEaseOut,
                      sizeCurve: Curves.linear,
                      alignmentry: Alignment.center,
                      reverseDuration: Duration(milliseconds: 125),
                      duration: Duration(milliseconds: 150),
                      firstChild: CircleAvatar(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image(
                              height: 48,
                              width: 48,
                              image: AssetImage('assets/icons/twitter.png'),
                            ),
                          ),
                        ),
                        backgroundColor: Colors.transparent,
                        radius: 20,
                      ),
                      secondChild: CircleAvatar(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Image(
                              height: 48,
                              width: 48,
                              image: AssetImage('assets/icons/twitter.png'),
                            ),
                          ),
                        ),
                        backgroundColor: Colors.transparent,
                        radius: 20,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 16,
                child: Center(
                  child: GestureDetector(
                    onTap: () => launch("https://github.com/AmarjitM13"),
                    child: HoverCrossFadeWidget(
                      firstCurve: Curves.linear,
                      secondCurve: Curves.linearToEaseOut,
                      sizeCurve: Curves.linear,
                      alignmentry: Alignment.center,
                      reverseDuration: Duration(milliseconds: 125),
                      duration: Duration(milliseconds: 150),
                      firstChild: CircleAvatar(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image(
                              height: 48,
                              width: 48,
                              image: AssetImage('assets/icons/github.png'),
                            ),
                          ),
                        ),
                        backgroundColor: Colors.transparent,
                        radius: 20,
                      ),
                      secondChild: CircleAvatar(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Image(
                              height: 48,
                              width: 48,
                              image: AssetImage('assets/icons/github.png'),
                            ),
                          ),
                        ),
                        backgroundColor: Colors.transparent,
                        radius: 20,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 16,
                child: Center(
                  child: GestureDetector(
                    onTap: () => launch(
                        "https://www.google.com/intl/en-GB/gmail/about/#"),
                    child: HoverCrossFadeWidget(
                      firstCurve: Curves.linear,
                      secondCurve: Curves.linearToEaseOut,
                      sizeCurve: Curves.linear,
                      alignmentry: Alignment.center,
                      reverseDuration: Duration(milliseconds: 125),
                      duration: Duration(milliseconds: 150),
                      firstChild: CircleAvatar(
                        child: Center(
                          child: Icon(
                            Icons.mail_outline_rounded,
                            color: Colors.white.withOpacity(0.9),
                            size: 25,
                          ),
                        ),
                        backgroundColor: Colors.transparent,
                        radius: 20,
                      ),
                      secondChild: CircleAvatar(
                        child: Center(
                          child: Icon(
                            Icons.mail_outline_rounded,
                            color: Colors.white.withOpacity(0.9),
                            size: 29,
                          ),
                        ),
                        backgroundColor: Colors.transparent,
                        radius: 20,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 16,
//                child: Center(
//                  child: Switch(
//                    value: false,
//                    onChanged: null,
//                  ),
//                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
