import 'package:flutter/material.dart';

class AppTheme {
  // primary color
  static const Color primary = Color.fromRGBO(28, 42, 87, 1);
  static const Color secondary = Color.fromRGBO(251, 61, 1, 1);

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    // Primary color
    primaryColor: primary,

    // AppBar Theme
    appBarTheme: const AppBarTheme(
      color: primary,
      elevation: 0,
    ),

    // BottomNavigationBar Theme
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: secondary,
    ),

    // ListTile Theme
    listTileTheme: const ListTileThemeData(iconColor: secondary),
  );
}
