import 'package:flutter/material.dart';

import '../core.dart';

//Rounded shape image button
class RoundedButton extends StatelessWidget {
  final Color color;
  final String imagePath;
  final Function()? onTap;

  RoundedButton.back({super.key, this.onTap})
      : color = BBColor.white,
        imagePath = AssetHelper.backIcon;

  RoundedButton.profile({super.key, this.onTap})
      : color = BBColor.white,
        imagePath = AssetHelper.profileIcon;

  RoundedButton.cheers({super.key, this.onTap})
      : color = BBColor.pageBackground,
        imagePath = AssetHelper.cheersImage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(left: 8),
        padding: const EdgeInsets.all(6),
        height: 36,
        width: 36,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: color,
        ),
        child: Image.asset(
          imagePath,
        ),
      ),
    );
  }
}
