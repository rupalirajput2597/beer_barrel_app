import 'package:flutter/material.dart';

class BBAppTheme {
  static ThemeData theme(BuildContext context) => ThemeData(
        fontFamily: "sf-pro-text",
        useMaterial3: true,
        scaffoldBackgroundColor: BBColor.pageBackground,
        primaryColor: BBColor.pageBackground,
        colorScheme: ColorScheme.dark(
          brightness: Brightness.dark,
          onTertiary: BBColor.pageBackground,
          error: BBColor.red,
        ),
      );
}

class BBColor {
  static Color get pageBackground => hexToColor("#1E2022");

  static Color get white => Colors.white;
  static Color get transparent => Colors.transparent;
  static Color get primaryGrey => hexToColor("#AFB2B5");
  static Color get secondaryGrey => hexToColor("#77838F");
  static Color get faintWhite => hexToColor("#F2F2F2");
  static Color get grey => hexToColor("#D8D8D8");
  static Color get red => Colors.red;
}

/// Construct a color from a hex code string, of the format #RRGGBB.
Color hexToColor(String code) {
  try {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  } catch (e) {
    return Colors.transparent;
  }
}
