import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  void toggleTheme(bool isDarkMode) {
    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  ThemeData get lightTheme => ThemeData(
    fontFamily: "Manrope",
    brightness: Brightness.light,
    // primarySwatch: Colors.blue,
    // scaffoldBackgroundColor: Colors.white,
    // appBarTheme: const AppBarTheme(
    //   color: Colors.transparent,
    //   elevation: 0,
    //   iconTheme: IconThemeData(color: Colors.black),
    // ),
    // textTheme: const TextTheme(bodyLarge: TextStyle(color: Colors.black87)),
  );

  ThemeData get darkTheme => ThemeData(
    fontFamily: "Manrope",
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(
      color: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    textTheme: const TextTheme(bodyLarge: TextStyle(color: Colors.white)),
  );
}
