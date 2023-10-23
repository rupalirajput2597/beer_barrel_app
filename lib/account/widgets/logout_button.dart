import 'package:flutter/material.dart';

import '../../core/core.dart';

class LogoutButton extends StatelessWidget {
  final Function() onPress;
  const LogoutButton({required this.onPress, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: BBColor.white,
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 18,
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(
            BBColor.red,
          ),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                10,
              ),
            ),
          ),
        ),
        onPressed: onPress,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 12.0,
          ),
          child: Text(
            'Logout',
            style: TextStyle(
              color: BBColor.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
