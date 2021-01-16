import 'package:flutter/material.dart';
import 'package:portfolio/home_view/home_page.dart';
import 'package:portfolio/theme/theme_switcher.dart';
import 'package:portfolio/theme/themes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ThemeSwitcherWidget(
      initialDarkModeOn: true,
      child: AmarjitMallick(),
    );
  }
}

class AmarjitMallick extends StatelessWidget {
  const AmarjitMallick({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amarjit Mallick',
      home: HomePage(),
      theme: ThemeSwitcher.of(context).isDarkModeOn
          ? darkTheme(context)
          : lightTheme(context),
      debugShowCheckedModeBanner: false,
    );
  }
}
