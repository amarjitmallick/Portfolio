import 'package:flutter/material.dart';
import 'package:hovering/hovering.dart';
import 'package:portfolio/theme/theme_switcher.dart';

class NameTag extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 4,
      child: Container(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Amarjit',
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'RobotoMono',
                  fontWeight: FontWeight.w500,
                  color: ThemeSwitcher.of(context).isDarkModeOn
                      ? Colors.green
                      : Colors.blue,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Mallick',
                style: TextStyle(
                  fontSize: 22,
                  fontFamily: 'RobotoMono',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NavBarButton extends StatefulWidget {
  final String _buttonName;
  NavBarButton(this._buttonName);
  @override
  _NavBarButtonState createState() => _NavBarButtonState();
}

class _NavBarButtonState extends State<NavBarButton> {
  @override
  Widget build(BuildContext context) {
    return HoverCrossFadeWidget(
      firstCurve: Curves.ease,
      secondCurve: Curves.ease,
      sizeCurve: Curves.ease,
      reverseDuration: Duration(milliseconds: 100),
      duration: Duration(milliseconds: 100),
      firstChild: Text(
        widget._buttonName,
      ),
      secondChild: Text(
        '< ${widget._buttonName} >',
        style: TextStyle(
            color: ThemeSwitcher.of(context).isDarkModeOn
                ? Colors.green
                : Colors.blue,
            fontFamily: 'RobotoMono'),
      ),
    );
  }
}

class CustomIconButton extends StatefulWidget {
  final Widget buttonchild;
  final String url;
  CustomIconButton({this.buttonchild, this.url});
  @override
  _CustomIconButtonState createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<CustomIconButton> {
  @override
  Widget build(BuildContext context) {
    return HoverCrossFadeWidget(
      firstCurve: Curves.easeIn,
      secondCurve: Curves.easeInBack,
      sizeCurve: Curves.easeInOut,
      alignmentry: Alignment.center,
      reverseDuration: Duration(milliseconds: 125),
      duration: Duration(milliseconds: 150),
      firstChild: widget.buttonchild,
      secondChild: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget.buttonchild,
        ],
      ),
    );
  }
}
