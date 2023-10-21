import 'package:flutter/material.dart';

class BBAppTheme {
  static ThemeData theme(BuildContext context) => ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        primaryColor: BBColor.pageBackground(context),
        primaryColorDark: BBColor.pageBackground(context),
        canvasColor: BBColor.pageBackground(context),
        scaffoldBackgroundColor: BBColor.pageBackground(context),
      );
}

class BBColor {
  static Color pageBackground(BuildContext context, {double opacity = 1.0}) {
    // return hexToColor("#0D0D0D").withOpacity(opacity);
    return hexToColor("#FFFFFF").withOpacity(opacity);
  }
}

/// Construct a color from a hex code string, of the format #RRGGBB.
Color hexToColor(String code) {
  try {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  } catch (e) {
    return Colors.transparent;
  }
}
