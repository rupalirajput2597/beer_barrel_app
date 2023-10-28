// Construct a color from a hex code string, of the format #RRGGBB.
import 'package:flutter/material.dart';

Color hexToColor(String code) {
  try {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  } catch (e) {
    return Colors.transparent;
  }
}

bool isStringValid(String? s) {
  return s != null && s.trim().isNotEmpty && s != "";
}
