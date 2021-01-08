import 'package:flutter/material.dart';
import 'package:portfolio/home_view/desktop_view.dart';
import 'package:portfolio/home_view/mobile_view.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: MobileView(),
      desktop: DesktopView(),
    );
  }
}
