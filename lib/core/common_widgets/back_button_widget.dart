import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core.dart';

//Beer Barrel BackButton
class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 8,
      ),
      color: BBColor.pageBackground,
      child: Row(
        children: [
          RoundedButton.back(
            onTap: () {
              context.pop();
            },
          ),
        ],
      ),
    );
  }
}
