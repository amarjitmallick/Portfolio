import 'package:flutter/material.dart';

class LandingPageMobile extends StatefulWidget {
  @override
  _LandingPageMobileState createState() => _LandingPageMobileState();
}

class _LandingPageMobileState extends State<LandingPageMobile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.height / 2,
            child: Center(
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage:
                    AssetImage('assets/images/profile picture.jpg'),
                radius: MediaQuery.of(context).size.height / 2.7,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1.5,
            height: MediaQuery.of(context).size.height / 2,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        ' Front-End App Developer ',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'RobotoMono',
                            fontSize: 12),
                      ),
                    ),
                  ),
                  Text(
                    'Talk is cheap.\nShow me the code',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'RobotoMono',
                        fontSize: 20),
                  ),
                  Text(
                    'I design and code beautifully simple things\nand I love what I do.',
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontFamily: 'RobotoMono',
                        fontSize: 10),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "LET'S CHAT!",
                    style: TextStyle(
                        color: Colors.green,
                        fontFamily: 'RobotoMono',
                        fontSize: 25),
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//TODO: make landing page responsive and try to import mobile view, desktop view separately.
