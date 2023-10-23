import 'package:flutter/material.dart';

import '../../core/core.dart';

class IngredientsInfoWidget extends StatelessWidget {
  final MapEntry<String, dynamic> ingredient;
  const IngredientsInfoWidget({required this.ingredient, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          margin: const EdgeInsets.only(right: 8),
          height: 36,
          width: 36,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: BBColor.pageBackground),
          child: Image.asset(
            AssetHelper.cheersImage,
          ),
        ),
        Flexible(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ingredient.key,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: BBColor.pageBackground,
                ),
              ),
              Text(
                ingredient.value.toString(),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: BBColor.secondaryGrey,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
