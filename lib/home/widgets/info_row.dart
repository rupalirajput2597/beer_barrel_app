import 'package:flutter/material.dart';

import '../../core/core.dart';

class InfoRow extends StatelessWidget {
  final String? title;
  final String? value;

  const InfoRow({required this.title, required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$title",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: BBColor.pageBackground,
          ),
        ),
        Text(
          "$value",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: BBColor.secondaryGrey,
          ),
        ),
      ],
    );
  }
}
