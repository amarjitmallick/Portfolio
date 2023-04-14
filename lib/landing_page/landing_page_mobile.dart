import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:portfolio/theme/theme_switcher.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:url_launcher/url_launcher.dart';

class LandingPageMobile extends StatefulWidget {
  final AutoScrollController controller;
  LandingPageMobile(this.controller);

  @override
  _LandingPageMobileState createState() => _LandingPageMobileState();
}

class _LandingPageMobileState extends State<LandingPageMobile> {
  @override
  Widget build(BuildContext context) {
    return AutoScrollTag(
      key: ValueKey(0),
      controller: widget.controller,
      index: 0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - 80,
        padding: EdgeInsets.symmetric(vertical: 70, horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              constraints: BoxConstraints(
                minHeight: 20,
                maxHeight: MediaQuery.of(context).size.height / 4,
                minWidth: 20,
                maxWidth: MediaQuery.of(context).size.height / 4,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                image: DecorationImage(
                  fit: BoxFit.scaleDown,
                  image: ThemeSwitcher.of(context).isDarkModeOn
                      ? AssetImage('assets/images/profile_dark.png')
                      : AssetImage('assets/images/profile_light.png'),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      launch('https://github.com/AmarjitM13');
                    },
                    child: Image.asset(
                      'assets/icons/github.png',
                      scale: 3,
                      color: ThemeSwitcher.of(context).isDarkModeOn
                          ? ThemeData.dark(useMaterial3: true).colorScheme.secondary
                          : Color(0xFF646AFF),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      launch('https://www.linkedin.com/in/amarjit-mallick/');
                    },
                    child: Image.asset(
                      'assets/icons/linkedin.png',
                      scale: 3,
                      color: ThemeSwitcher.of(context).isDarkModeOn
                          ? ThemeData.dark(useMaterial3: true).colorScheme.secondary
                          : Color(0xFF646AFF),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      launch('https://twitter.com/AmarjitM13');
                    },
                    child: Image.asset(
                      'assets/icons/twitter.png',
                      scale: 3,
                      color: ThemeSwitcher.of(context).isDarkModeOn
                          ? ThemeData.dark(useMaterial3: true).colorScheme.secondary
                          : Color(0xFF646AFF),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: RichText(
                text: TextSpan(
                  text: "Hi, I'm  ",
                  style: TextStyle(
                    color: ThemeSwitcher.of(context).isDarkModeOn ? Colors.white : Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'RobotoMono',
                  ),
                  children: [
                    TextSpan(
                      text: 'Amarjit',
                      style: TextStyle(
                        color: ThemeSwitcher.of(context).isDarkModeOn
                            ? ThemeData.dark(useMaterial3: true).colorScheme.secondary
                            : Color(0xFF646AFF),
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Text(
                'Mobile Application Developer',
                style: TextStyle(
                  color: ThemeSwitcher.of(context).isDarkModeOn
                      ? ThemeData.dark(useMaterial3: true).colorScheme.secondary
                      : Color(0xFF646AFF),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'RobotoMono',
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Text(
                'I design and code beautifully simple things using Flutter',
                style: TextStyle(
                  color: ThemeSwitcher.of(context).isDarkModeOn ? Colors.white : Colors.black,
                  fontFamily: 'RobotoMono',
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: TextButton(
                onPressed: () async {
                  ByteData file = await rootBundle.load('/images/Amarjit_Mallick_Resume.pdf');
                  Uint8List pdf = file.buffer.asUint8List();
                  await FileSaver.instance
                      .saveFile(name: 'Resume.pdf', bytes: pdf, mimeType: MimeType.pdf, filePath: 'downloads');
                },
                style: TextButton.styleFrom(
                  backgroundColor: ThemeSwitcher.of(context).isDarkModeOn
                      ? ThemeData.dark(useMaterial3: true).colorScheme.secondary
                      : Color(0xFF646AFF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 25),
                ),
                child: Text(
                  "Download Resume",
                  style: TextStyle(
                    color: ThemeSwitcher.of(context).isDarkModeOn ? Colors.black : Colors.white,
                    fontFamily: 'RobotoMono',
                    //fontSize: 25,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//TODO: make landing page responsive and try to import mobile view, desktop view separately.
