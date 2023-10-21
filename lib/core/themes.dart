import 'package:flutter/material.dart';

class BBAppTheme {
  static ThemeData theme(BuildContext context) => ThemeData(
        fontFamily: "sf-pro-text",
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        primaryColor: BBColor.pageBackground,
        primaryColorDark: BBColor.pageBackground,
        canvasColor: BBColor.pageBackground,
        scaffoldBackgroundColor: BBColor.pageBackground,
      );
}

class BBColor {
  static Color get pageBackground => hexToColor("#1E2022");

  static Color get white => Colors.white;
  static Color get transparent => Colors.transparent;
  static Color get primaryGrey => hexToColor("#AFB2B5");
  static Color get secondaryGrey => hexToColor("#77838F");
  static Color get faintWhite => hexToColor("#F2F2F2");
}

/// Construct a color from a hex code string, of the format #RRGGBB.
Color hexToColor(String code) {
  try {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  } catch (e) {
    return Colors.transparent;
  }
}
