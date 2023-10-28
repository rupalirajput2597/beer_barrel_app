import 'package:flutter/material.dart';

import 'core.dart';

//Beer Barrel Custom theme
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

//Beer Barrel Colors
class BBColor {
  static Color get pageBackground => hexToColor("#1E2022");

  static Color get white => hexToColor("#FFFFFF");
  static Color get transparent => Colors.transparent;
  static Color get primaryGrey => hexToColor("#AFB2B5");
  static Color get secondaryGrey => hexToColor("#77838F");
  static Color get faintWhite => hexToColor("#F2F2F2");
  static Color get grey => hexToColor("#D8D8D8");
  static Color get faintGrey => hexToColor("#EEEEEE");
  static Color get grey1 => hexToColor("#979797");
  static Color get red => hexToColor("#FF0F00");
  static Color get linkedInBG => hexToColor("#0077B5");
  static Color get facebookBG => hexToColor("#3D6AD6");
  static Color get darkBlue => Colors.blue;
}
