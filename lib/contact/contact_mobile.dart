import 'package:flutter/material.dart';
import 'package:portfolio/theme/theme_switcher.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactMobile extends StatefulWidget {
  final AutoScrollController controller;
  ContactMobile(this.controller);
  @override
  _ContactMobileState createState() => _ContactMobileState();
}

class _ContactMobileState extends State<ContactMobile> {
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
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                'get in touch',
                style: TextStyle(
                  color: ThemeSwitcher.of(context).isDarkModeOn ? Colors.white : Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'RobotoMono',
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Text(
                "My inbox is always open. Whether you have a question or project or just want to say hi, I'll try my best to get back to you!",
                style: TextStyle(
                  color: ThemeSwitcher.of(context).isDarkModeOn ? Colors.white : Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'RobotoMono',
                ),
                maxLines: 5,
                textAlign: TextAlign.center,
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
