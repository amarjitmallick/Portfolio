import 'package:flutter/material.dart';
import 'package:portfolio/navigation_bar/nav_bar_items.dart';

class ContactDesktop extends StatefulWidget {
  @override
  _ContactDesktopState createState() => _ContactDesktopState();
}

class _ContactDesktopState extends State<ContactDesktop> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 1.5,
      color: Color(0xFF2D2E32),
      child: Row(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width / 2 + 100,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Let's make something amazing\ntogether.",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'RobotoMono',
                        fontSize: 40),
                  ),
                  Text(
                    "Start by saying hi",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'RobotoMono',
                        fontSize: 40),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Amarjit Mallick",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'RobotoMono',
                        fontSize: 25),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width / 2 - 100,
            child: Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Information',
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontFamily: 'RobotoMono',
                          fontSize: 10),
                    ),
                    Text(
                      'Email me:',
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontFamily: 'RobotoMono',
                          fontSize: 20),
                    ),
                    Text(
                      "mallickamarjit@gmail.com",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'RobotoMono',
                          fontSize: 30),
                    ),
                    SizedBox(height: 20),
                    NavBarButton('Services'),
                    NavBarButton('Works'),
                    NavBarButton('Notes'),
                    NavBarButton('Contacts'),
                    SizedBox(height: 30),
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/icons/twitter.png'),
                          backgroundColor: Colors.transparent,
                          radius: 15,
                        ),
                        SizedBox(width: 20),
                        CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/icons/github.png'),
                          backgroundColor: Colors.transparent,
                          radius: 15,
                        ),
                        SizedBox(width: 20),
                        CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/icons/linkedin.png'),
                          backgroundColor: Colors.transparent,
                          radius: 15,
                        ),
                        SizedBox(width: 20),
                        CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/icons/instagram.png'),
                          backgroundColor: Colors.transparent,
                          radius: 15,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
