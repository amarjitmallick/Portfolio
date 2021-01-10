import 'package:flutter/material.dart';
import 'package:portfolio/utilities/constants.dart';

class LatestWorksDesktop extends StatefulWidget {
  @override
  _LatestWorksDesktopState createState() => _LatestWorksDesktopState();
}

class _LatestWorksDesktopState extends State<LatestWorksDesktop> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 2,
      color: Color(0xFF25262A),
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.height * 2,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 3.6,
                    width: MediaQuery.of(context).size.height / 1.8,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Latest Works',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'RobotoMono',
                                fontSize: 40),
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
                    height: MediaQuery.of(context).size.height / 1.5,
                    width: MediaQuery.of(context).size.height / 1.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF16191E),
                          Color(0xFF272729),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height / 6,
                          width: MediaQuery.of(context).size.height / 1.5,
                          child: Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.height / 3,
                                child: Center(
                                  child: Text(
                                    'Portfolio',
                                    style: TextStyle(fontSize: 25),
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.height / 3,
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        color: kPrimaryColor,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 8),
                                          child: Text(
                                            'Dart',
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Container(
                                        color: kPrimaryColor,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 8),
                                          child: Text(
                                            'Flutter',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 40),
                          child: Image(
                            image: AssetImage('assets/images/portfolio.png'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 3.6,
                    width: MediaQuery.of(context).size.height / 1.8,
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
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.height * 2,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 1.5,
                    width: MediaQuery.of(context).size.height / 1.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xFF2D3037),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height / 6,
                          width: MediaQuery.of(context).size.height / 1.5,
                          child: Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.height / 3,
                                child: Center(
                                  child: Text(
                                    'Cardify',
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.green),
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.height / 3,
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        color: kPrimaryColor,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 8),
                                          child: Text(
                                            'Dart',
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Container(
                                        color: kPrimaryColor,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 8),
                                          child: Text(
                                            'Flutter',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 1.5,
                    width: MediaQuery.of(context).size.height / 1.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xFF181B2C),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height / 6,
                          width: MediaQuery.of(context).size.height / 1.5,
                          child: Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.height / 3,
                                child: Center(
                                  child: Text(
                                    'Formatics',
                                    style: TextStyle(
                                      fontSize: 25,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.height / 3,
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        color: kPrimaryColor,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 8),
                                          child: Text(
                                            'Dart',
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Container(
                                        color: kPrimaryColor,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 8),
                                          child: Text(
                                            'Flutter',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
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
        ],
      ),
    );
  }
}
