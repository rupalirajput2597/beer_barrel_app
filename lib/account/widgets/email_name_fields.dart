import 'package:flutter/material.dart';

import '../../core/core.dart';

class EmailNameFieldWidget extends StatelessWidget {
  final String? title;
  final String? desc;
  const EmailNameFieldWidget(
      {required this.title, required this.desc, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$title",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w700, color: BBColor.grey1),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 10,
          ),
          width: double.maxFinite,
          decoration: BoxDecoration(
              color: BBColor.faintGrey,
              borderRadius: BorderRadius.circular(10)),
          child: Text(
            desc ?? "",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: BBColor.pageBackground,
            ),
          ),
        ),
      ],
    );
  }
}
