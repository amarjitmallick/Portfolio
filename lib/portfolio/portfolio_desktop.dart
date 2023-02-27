import 'package:flutter/material.dart';
import 'package:portfolio/theme/theme_switcher.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:url_launcher/url_launcher.dart';

class PortfolioDesktop extends StatefulWidget {
  final AutoScrollController controller;
  PortfolioDesktop(this.controller);

  @override
  _PortfolioDesktopState createState() => _PortfolioDesktopState();
}

class _PortfolioDesktopState extends State<PortfolioDesktop> {
  @override
  Widget build(BuildContext context) {
    return AutoScrollTag(
      key: ValueKey(3),
      controller: widget.controller,
      index: 3,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            opacity: 0.3,
            fit: BoxFit.fill,
            image: AssetImage('assets/images/bg_rev.png'),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: Text(
                'my portfolio',
                style: TextStyle(
                  color: ThemeSwitcher.of(context).isDarkModeOn ? Colors.white : Colors.black,
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'RobotoMono',
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 30),
              child: Text(
                "A small gallery of recent projects chosen by me.",
                style: TextStyle(
                  color: ThemeSwitcher.of(context).isDarkModeOn ? Colors.white : Colors.black,
                  fontFamily: 'RobotoMono',
                  fontSize: 40,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 50),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width / 3,
                        height: MediaQuery.of(context).size.height / 2.5,
                        decoration: BoxDecoration(
                          color: Colors.transparent.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      Icons.folder_open_rounded,
                                      color: ThemeSwitcher.of(context).isDarkModeOn
                                          ? Color(0xFF00D1C7)
                                          : Color(0xFF646AFF),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        launch('https://github.com/AmarjitM13/Portfolio');
                                      },
                                      child: Icon(
                                        Icons.link_rounded,
                                        color: ThemeSwitcher.of(context).isDarkModeOn
                                            ? Color(0xFF00D1C7)
                                            : Color(0xFF646AFF),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      'Portfolio',
                                      style: TextStyle(
                                        color: ThemeSwitcher.of(context).isDarkModeOn ? Colors.white : Colors.black,
                                        fontFamily: 'RobotoMono',
                                        fontSize: 30,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    'A responsive portfolio website',
                                    style: TextStyle(
                                      color: ThemeSwitcher.of(context).isDarkModeOn ? Colors.white : Colors.black,
                                      fontFamily: 'RobotoMono',
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                                      margin: EdgeInsets.only(right: 15),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: ThemeSwitcher.of(context).isDarkModeOn
                                            ? Color(0xFF00D1C7).withOpacity(0.2)
                                            : Color(0xFF646AFF).withOpacity(0.2),
                                      ),
                                      child: Text('Flutter'),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                                      margin: EdgeInsets.only(right: 15),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: ThemeSwitcher.of(context).isDarkModeOn
                                            ? Color(0xFF00D1C7).withOpacity(0.2)
                                            : Color(0xFF646AFF).withOpacity(0.2),
                                      ),
                                      child: Text('Dart'),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width / 3,
                        height: MediaQuery.of(context).size.height / 2.5,
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          color: Colors.transparent.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      Icons.folder_open_rounded,
                                      color: ThemeSwitcher.of(context).isDarkModeOn
                                          ? Color(0xFF00D1C7)
                                          : Color(0xFF646AFF),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        launch(
                                            'https://play.google.com/store/apps/details?id=me.amarjitmallick.xpense');
                                      },
                                      child: Icon(
                                        Icons.link_rounded,
                                        color: ThemeSwitcher.of(context).isDarkModeOn
                                            ? Color(0xFF00D1C7)
                                            : Color(0xFF646AFF),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      'Xpense',
                                      style: TextStyle(
                                        color: ThemeSwitcher.of(context).isDarkModeOn ? Colors.white : Colors.black,
                                        fontFamily: 'RobotoMono',
                                        fontSize: 30,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    'An expense management app',
                                    style: TextStyle(
                                      color: ThemeSwitcher.of(context).isDarkModeOn ? Colors.white : Colors.black,
                                      fontFamily: 'RobotoMono',
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                                      margin: EdgeInsets.only(right: 15),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: ThemeSwitcher.of(context).isDarkModeOn
                                            ? Color(0xFF00D1C7).withOpacity(0.2)
                                            : Color(0xFF646AFF).withOpacity(0.2),
                                      ),
                                      child: Text('Flutter'),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                                      margin: EdgeInsets.only(right: 15),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: ThemeSwitcher.of(context).isDarkModeOn
                                            ? Color(0xFF00D1C7).withOpacity(0.2)
                                            : Color(0xFF646AFF).withOpacity(0.2),
                                      ),
                                      child: Text('Dart'),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
            // Container(
            //   width: MediaQuery.of(context).size.width / 2,
            //   height: MediaQuery.of(context).size.height * 2,
            //   child: Center(
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //       children: [
            //         Container(
            //           height: MediaQuery.of(context).size.height / 3.6,
            //           width: MediaQuery.of(context).size.height / 1.8,
            //           child: Center(
            //             child: Column(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               children: [
            //                 Text(
            //                   'Latest Works',
            //                   style: TextStyle(fontFamily: 'RobotoMono', fontSize: 40),
            //                 ),
            //                 SizedBox(height: 20),
            //                 Text(
            //                   'Perfect solutions for digital experience',
            //                   style: TextStyle(
            //                       color: ThemeSwitcher.of(context).isDarkModeOn
            //                           ? Colors.white.withOpacity(0.5)
            //                           : Colors.black.withOpacity(0.5),
            //                       fontFamily: 'RobotoMono',
            //                       fontSize: 10),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //         Container(
            //           height: MediaQuery.of(context).size.height / 1.5,
            //           width: MediaQuery.of(context).size.height / 1.5,
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(8),
            //             gradient: LinearGradient(
            //               colors: [
            //                 ThemeSwitcher.of(context).isDarkModeOn ? Color(0xFF16191E) : Colors.grey[200],
            //                 ThemeSwitcher.of(context).isDarkModeOn ? Color(0xFF272729) : Color(0xFFf5f4f4),
            //               ],
            //               begin: Alignment.topLeft,
            //               end: Alignment.bottomRight,
            //             ),
            //           ),
            //           child: Column(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               Container(
            //                 height: MediaQuery.of(context).size.height / 6,
            //                 width: MediaQuery.of(context).size.height / 1.5,
            //                 child: Row(
            //                   children: [
            //                     Container(
            //                       width: MediaQuery.of(context).size.height / 3,
            //                       child: Center(
            //                         child: Text(
            //                           'Portfolio',
            //                           style: TextStyle(
            //                             fontSize: 25,
            //                             color: ThemeSwitcher.of(context).isDarkModeOn ? Colors.white : Colors.blue,
            //                           ),
            //                         ),
            //                       ),
            //                     ),
            //                     Container(
            //                       width: MediaQuery.of(context).size.height / 3,
            //                       child: Center(
            //                         child: Row(
            //                           mainAxisAlignment: MainAxisAlignment.center,
            //                           children: [
            //                             Container(
            //                               color: ThemeSwitcher.of(context).isDarkModeOn
            //                                   ? Color(0xFF272729)
            //                                   : Colors.grey[200],
            //                               child: Padding(
            //                                 padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
            //                                 child: Text(
            //                                   'Dart',
            //                                 ),
            //                               ),
            //                             ),
            //                             SizedBox(width: 10),
            //                             Container(
            //                               color: ThemeSwitcher.of(context).isDarkModeOn
            //                                   ? Color(0xFF272729)
            //                                   : Colors.grey[200],
            //                               child: Padding(
            //                                 padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
            //                                 child: Text(
            //                                   'Flutter',
            //                                 ),
            //                               ),
            //                             ),
            //                           ],
            //                         ),
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //               Padding(
            //                 padding: const EdgeInsets.only(right: 40),
            //                 child: ThemeSwitcher.of(context).isDarkModeOn
            //                     ? Image(
            //                         image: AssetImage('assets/images/portfolio.png'),
            //                       )
            //                     : Image(
            //                         image: AssetImage('assets/images/portfolio_light.png'),
            //                       ),
            //               ),
            //             ],
            //           ),
            //         ),
            //         Container(
            //           height: MediaQuery.of(context).size.height / 3.6,
            //           width: MediaQuery.of(context).size.height / 1.8,
            //           child: Center(
            //             child: Column(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               children: [
            //                 Text(
            //                   'ALL PROJECTS',
            //                   style: TextStyle(
            //                       color: ThemeSwitcher.of(context).isDarkModeOn ? Colors.green : Colors.blue,
            //                       fontFamily: 'RobotoMono',
            //                       fontSize: 25,
            //                       decoration: TextDecoration.underline),
            //                 ),
            //                 SizedBox(height: 30),
            //                 Text(
            //                   '*Some projects are not allowed to publish.\nIf you want to see more, contact ',
            //                   style: TextStyle(
            //                       color: ThemeSwitcher.of(context).isDarkModeOn
            //                           ? Colors.white.withOpacity(0.5)
            //                           : Colors.black.withOpacity(0.5),
            //                       fontFamily: 'RobotoMono',
            //                       fontSize: 10),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // Container(
            //   width: MediaQuery.of(context).size.width / 2,
            //   height: MediaQuery.of(context).size.height * 2,
            //   child: Center(
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //       children: [
            //         Container(
            //           height: MediaQuery.of(context).size.height / 1.5,
            //           width: MediaQuery.of(context).size.height / 1.5,
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(8),
            //             gradient: LinearGradient(colors: [
            //               ThemeSwitcher.of(context).isDarkModeOn ? Color(0xFF2D3037) : Color(0xFFf5f4f4),
            //               ThemeSwitcher.of(context).isDarkModeOn ? Color(0xFF25262A) : Colors.grey[200],
            //             ], begin: Alignment.topRight, end: Alignment.bottomLeft),
            //           ),
            //           child: Column(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               Container(
            //                 height: MediaQuery.of(context).size.height / 6,
            //                 width: MediaQuery.of(context).size.height / 1.5,
            //                 child: Row(
            //                   children: [
            //                     Container(
            //                       width: MediaQuery.of(context).size.height / 3,
            //                       child: Center(
            //                         child: Text(
            //                           'Cardify',
            //                           style: TextStyle(
            //                             fontSize: 25,
            //                             color: ThemeSwitcher.of(context).isDarkModeOn ? Colors.green : Colors.blue,
            //                           ),
            //                         ),
            //                       ),
            //                     ),
            //                     Container(
            //                       width: MediaQuery.of(context).size.height / 3,
            //                       child: Center(
            //                         child: Row(
            //                           mainAxisAlignment: MainAxisAlignment.center,
            //                           children: [
            //                             Container(
            //                               color: ThemeSwitcher.of(context).isDarkModeOn
            //                                   ? Colors.transparent
            //                                   : Colors.grey[200],
            //                               child: Padding(
            //                                 padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
            //                                 child: Text(
            //                                   'Dart',
            //                                 ),
            //                               ),
            //                             ),
            //                             SizedBox(width: 10),
            //                             Container(
            //                               color: ThemeSwitcher.of(context).isDarkModeOn
            //                                   ? Colors.transparent
            //                                   : Colors.grey[200],
            //                               child: Padding(
            //                                 padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
            //                                 child: Text(
            //                                   'Flutter',
            //                                 ),
            //                               ),
            //                             ),
            //                           ],
            //                         ),
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //         Container(
            //           height: MediaQuery.of(context).size.height / 1.5,
            //           width: MediaQuery.of(context).size.height / 1.5,
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(8),
            //             gradient: LinearGradient(colors: [
            //               ThemeSwitcher.of(context).isDarkModeOn ? Color(0xFF2D3037) : Color(0xFFf5f4f4),
            //               ThemeSwitcher.of(context).isDarkModeOn ? Color(0xFF25262A) : Colors.grey[200],
            //             ], begin: Alignment.bottomLeft, end: Alignment.topRight),
            //           ),
            //           child: Column(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               Container(
            //                 height: MediaQuery.of(context).size.height / 6,
            //                 width: MediaQuery.of(context).size.height / 1.5,
            //                 child: Row(
            //                   children: [
            //                     Container(
            //                       width: MediaQuery.of(context).size.height / 3,
            //                       child: Center(
            //                         child: Text(
            //                           'Formatics',
            //                           style: TextStyle(
            //                             fontSize: 25,
            //                             color: ThemeSwitcher.of(context).isDarkModeOn ? Colors.green : Colors.blue,
            //                           ),
            //                         ),
            //                       ),
            //                     ),
            //                     Container(
            //                       width: MediaQuery.of(context).size.height / 3,
            //                       child: Center(
            //                         child: Row(
            //                           mainAxisAlignment: MainAxisAlignment.center,
            //                           children: [
            //                             Container(
            //                               color: ThemeSwitcher.of(context).isDarkModeOn
            //                                   ? Colors.transparent
            //                                   : Colors.grey[200],
            //                               child: Padding(
            //                                 padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
            //                                 child: Text(
            //                                   'Dart',
            //                                 ),
            //                               ),
            //                             ),
            //                             SizedBox(width: 10),
            //                             Container(
            //                               color: ThemeSwitcher.of(context).isDarkModeOn
            //                                   ? Colors.transparent
            //                                   : Colors.grey[200],
            //                               child: Padding(
            //                                 padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
            //                                 child: Text(
            //                                   'Flutter',
            //                                 ),
            //                               ),
            //                             ),
            //                           ],
            //                         ),
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
