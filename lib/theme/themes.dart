import 'package:flutter/material.dart';

darkTheme(context) {
  return ThemeData(
    fontFamily: 'RobotoMono',
    primaryColor: Color(0xFF1D2C33),
    disabledColor: Colors.grey,
    cardColor: Color(0xff1f2124),
    canvasColor: Color(0xFF1D2C33),
    brightness: Brightness.dark,
    buttonTheme: Theme.of(context).buttonTheme.copyWith(
          colorScheme: ColorScheme.dark(),
          buttonColor: Color(0xFF00D1C7),
          splashColor: Colors.black,
        ),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF1D2C33),
      elevation: 0.0,
    ),
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.green,
      brightness: Brightness.dark,
      primaryColorDark: Color(0xFF1D2C33),
    ).copyWith(
      secondary: Color(0xFF00D1C7),
    ),
  );
}

lightTheme(context) {
  return ThemeData(
    fontFamily: 'RobotoMono',
    primaryColor: Colors.white,
    canvasColor: Colors.white,
    brightness: Brightness.light,
    buttonTheme: Theme.of(context).buttonTheme.copyWith(
          colorScheme: ColorScheme.light(),
          buttonColor: Color(0xFF646AFF),
          splashColor: Colors.white,
        ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0.0,
    ),
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.blue,
      brightness: Brightness.light,
    ).copyWith(
      secondary: Color(0xFF646AFF),
    ),
  );
}
