import 'package:flutter/material.dart';
import 'constants.dart';

const Color disableColor = Color(0xffCECECE);
Color? COLOR_PRIMARY = Colors.blue[900];
const COLOR_PRIMARY2 = Color(0xff2f55a4);
const COLOR_ACCENT = Constants.primaryColor;
const DARK_GREY = Color(0xff18191a);
const DARK_GREY2 = Color(0xff242526);
const DARK_GREY3 = Color(0xff3a3b3c);
const GREY = Colors.grey;
const LIGHT_GREY1 = Color(0xffe4e6eb);
const LIGHT_GREY2 = Color(0xffb0b3b8);

class ThemesApp {
  static final light = ThemeData(
      fontFamily: 'IBM Plex Sans Arabic',
      useMaterial3: true,
      iconTheme: IconThemeData(
        color: Colors.grey[300],
      ),
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 22.0,
            fontWeight: FontWeight.w800,
          ),
          iconTheme: IconThemeData(color: Colors.black)),
      brightness: Brightness.light,bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Colors.white,modalBackgroundColor:LIGHT_GREY1),
      backgroundColor: LIGHT_GREY2,

      cardColor: Colors.white,
      primaryColor: COLOR_PRIMARY,
      floatingActionButtonTheme:
          const FloatingActionButtonThemeData(backgroundColor: COLOR_ACCENT),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(COLOR_ACCENT))),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide.none),
      ));

  static final dark = ThemeData(
    bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Colors.black,modalBackgroundColor: DARK_GREY),
    iconTheme: IconThemeData(
      color: Colors.grey[300],
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: DARK_GREY2,
      titleTextStyle: TextStyle(
          color: Colors.white, fontSize: 22.0, fontWeight: FontWeight.w800),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    backgroundColor: DARK_GREY2,
    brightness: Brightness.dark,
    accentColor: Colors.white,
    fontFamily: 'IBM Plex Sans Arabic',
    useMaterial3: true,
    primaryColor: COLOR_PRIMARY2,
    cardColor: DARK_GREY3,
    switchTheme: SwitchThemeData(
      trackColor: MaterialStateProperty.all<Color>(Colors.grey),
      thumbColor: MaterialStateProperty.all<Color>(Colors.white),
    ),
    inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide.none),
        filled: true,
        fillColor: Colors.grey.withOpacity(0.1)),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
            overlayColor: MaterialStateProperty.all<Color>(Colors.black26))),
  );
}
