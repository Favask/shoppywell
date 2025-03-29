import 'package:shoppywell/src/comman/colors.dart';
import 'package:flutter/material.dart';

ThemeData themeLight(BuildContext context) {
  return ThemeData(
    brightness: Brightness.light,
    cardColor: ColorLight.card,
    disabledColor: ColorLight.disabledButton,
    highlightColor: ColorLight.fontTitle,
    hintColor: ColorLight.fontSubtitle,
    indicatorColor: ColorLight.primary,
    iconTheme: const IconThemeData(
      color: ColorLight.fontTitle,
    ),
    primaryColor: ColorLight.primary,
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: ColorLight.primary,
    ),
    checkboxTheme: const CheckboxThemeData(
      side: BorderSide(
        color: ColorLight.disabledButton,
      ),
    ),
    scaffoldBackgroundColor: ColorLight.background,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
    ),

  );
}

ThemeData themeDark(BuildContext context) {
  return ThemeData(
    brightness: Brightness.dark,
    cardColor: ColorDark.card,
    disabledColor: ColorDark.disabledButton,
    hintColor: ColorDark.fontSubtitle,
    indicatorColor: ColorLight.primary,
    iconTheme: const IconThemeData(
      color: ColorDark.fontTitle,
    ),
    primaryColor: ColorLight.primary,
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: ColorLight.primary,
    ),
    checkboxTheme: const CheckboxThemeData(
      side: BorderSide(
        color: ColorLight.disabledButton,
      ),
    ),
    scaffoldBackgroundColor: ColorDark.background,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
    ),
  );
}
