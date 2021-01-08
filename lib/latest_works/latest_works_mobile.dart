import 'package:flutter/material.dart';

class LatestWorksMobile extends StatefulWidget {
  @override
  _LatestWorksMobileState createState() => _LatestWorksMobileState();
}

class _LatestWorksMobileState extends State<LatestWorksMobile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 2 + 40,
      color: Color(0xFF25262A),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 3.6,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Latest Works',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'RobotoMono',
                        fontSize: 30),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Perfect solutions for digital experience',
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontFamily: 'RobotoMono',
                        fontSize: 10),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 300,
            width: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: LinearGradient(colors: [
                Color(0xFF16191E),
                Color(0xFF272729),
              ], begin: Alignment.topLeft, end: Alignment.bottomRight),
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: 300,
            width: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Color(0xFF2D3037),
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: 300,
            width: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Color(0xFF181B2C),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 3.6,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'ALL PROJECTS',
                    style: TextStyle(
                        color: Colors.green,
                        fontFamily: 'RobotoMono',
                        fontSize: 25,
                        decoration: TextDecoration.underline),
                  ),
                  SizedBox(height: 30),
                  Text(
                    '*Some projects are not allowed to publish.\nIf you want to see more, contact ',
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontFamily: 'RobotoMono',
                        fontSize: 10),
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
