import 'package:flutter/material.dart';
import 'package:portfolio/navigation_bar/nav_bar_items.dart';
import 'package:portfolio/theme/theme_switcher.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactDesktop extends StatefulWidget {
  final AutoScrollController controller;
  ContactDesktop(this.controller);
  @override
  _ContactDesktopState createState() => _ContactDesktopState();
}

class _ContactDesktopState extends State<ContactDesktop> {
  @override
  Widget build(BuildContext context) {
    final Uri params = Uri(
      scheme: 'mailto',
      path: 'mallickamarjit@gmail.com',
      query: 'subject= &body= Hi, Amarjit', //add subject and body here
    );

    var url = params.toString();

    return AutoScrollTag(
      key: ValueKey(5),
      controller: widget.controller,
      index: 5,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - 80,
        padding: EdgeInsets.symmetric(horizontal: 100, vertical: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                'get in touch',
                style: TextStyle(
                  color: ThemeSwitcher.of(context).isDarkModeOn ? Colors.white : Colors.black,
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'RobotoMono',
                ),
              ),
            ),
            Expanded(
              child: Text(
                "My inbox is always open. Whether you have a question or project or just want to say hi, I'll try my best to get back to you!",
                style: TextStyle(
                  color: ThemeSwitcher.of(context).isDarkModeOn ? Colors.white : Colors.black,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'RobotoMono',
                ),
              ),
            ),
            Spacer(),
            Expanded(
              child: TextButton(
                onPressed: () async {
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                style: TextButton.styleFrom(
                  backgroundColor: ThemeSwitcher.of(context).isDarkModeOn
                      ? ThemeData.dark(useMaterial3: true).colorScheme.secondary
                      : Color(0xFF646AFF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 50),
                ),
                child: Text(
                  "Say Hello!",
                  style: TextStyle(
                    color: ThemeSwitcher.of(context).isDarkModeOn ? Colors.black : Colors.white,
                    fontFamily: 'RobotoMono',
                    fontSize: 25,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
