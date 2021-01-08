import 'package:flutter/material.dart';
import 'package:portfolio/utilities/constants.dart';

class IntroductionMobile extends StatefulWidget {
  @override
  _IntroductionMobileState createState() => _IntroductionMobileState();
}

class _IntroductionMobileState extends State<IntroductionMobile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 2,
      color: Color(0xFF25262A),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width / 2,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Introduce',
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontFamily: 'RobotoMono',
                        fontSize: 10),
                  ),
                  Text(
                    "Hello!\nI'm Amarjit\nMallick",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'RobotoMono',
                        fontSize: 30),
                  ),
                  Text(
                    'Every great design begin with an\neven better story',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'RobotoMono',
                        fontSize: 20,
                        fontStyle: FontStyle.italic),
                  ),
                  Text(
                    'I design and code beautifully simple things\nand I love what I do.',
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontFamily: 'RobotoMono',
                        fontSize: 10),
                  ),
                  SizedBox(height: 60),
                ],
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 3 - 40,
            width: MediaQuery.of(context).size.width - 40,
            decoration: BoxDecoration(
              color: kPrimaryColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.35),
                  blurRadius: 5.0, // soften the shadow
                  spreadRadius: 3.0, //extend the shadow
                ),
              ],
            ),
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
                            color: Colors.green,
                            fontFamily: 'RobotoMono',
                            fontSize: 25),
                      ),
                      Icon(
                        Icons.settings_ethernet,
                        color: Colors.green,
                      )
                    ],
                  ),
                  Text(
                    'data',
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontFamily: 'RobotoMono',
                        fontSize: 10),
                  ),
                  Text(
                    'data',
                    style: TextStyle(color: Colors.white, fontSize: 11),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 3 - 40,
            width: MediaQuery.of(context).size.width - 40,
            decoration: BoxDecoration(
              color: kPrimaryColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.35),
                  blurRadius: 5.0, // soften the shadow
                  spreadRadius: 3.0, //extend the shadow
                ),
              ],
            ),
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
                            color: Colors.green,
                            fontFamily: 'RobotoMono',
                            fontSize: 25),
                      ),
                      Icon(
                        Icons.settings_ethernet,
                        color: Colors.green,
                      )
                    ],
                  ),
                  Text(
                    'data',
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontFamily: 'RobotoMono',
                        fontSize: 10),
                  ),
                  Text(
                    'data',
                    style: TextStyle(color: Colors.white, fontSize: 11),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 3 - 40,
            width: MediaQuery.of(context).size.width - 40,
            decoration: BoxDecoration(
              color: kPrimaryColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.35),
                  blurRadius: 5.0, // soften the shadow
                  spreadRadius: 3.0, //extend the shadow
                ),
              ],
            ),
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
                            color: Colors.green,
                            fontFamily: 'RobotoMono',
                            fontSize: 25),
                      ),
                      Icon(
                        Icons.settings_ethernet,
                        color: Colors.green,
                      )
                    ],
                  ),
                  Text(
                    'data',
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontFamily: 'RobotoMono',
                        fontSize: 10),
                  ),
                  Text(
                    'data',
                    style: TextStyle(color: Colors.white, fontSize: 11),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
