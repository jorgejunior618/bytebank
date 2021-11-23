import 'package:flutter/material.dart';

ThemeData materialTheme = ThemeData(
  primaryColor: Colors.green[900],
  accentColor: Colors.blue[700],
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.blue[700]),
    ),
  ),
);
