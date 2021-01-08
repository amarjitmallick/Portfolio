import 'package:flutter/material.dart';

class LandingPageDesktop extends StatefulWidget {
  @override
  _LandingPageDesktopState createState() => _LandingPageDesktopState();
}

class _LandingPageDesktopState extends State<LandingPageDesktop> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height - 80,
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.height - 80,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50),
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
                            fontSize: 20),
                      ),
                    ),
                  ),
                  Text(
                    'Talk is cheap.\nShow me the code',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'RobotoMono',
                        fontSize: 40),
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
                  SizedBox(height: 100),
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.height - 80,
            child: Center(
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage:
                    AssetImage('assets/images/profile picture.jpg'),
                radius: MediaQuery.of(context).size.height / 2.7,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
