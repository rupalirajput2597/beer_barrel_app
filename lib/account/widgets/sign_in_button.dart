import 'package:flutter/material.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({
    required this.logo,
    required this.title,
    required this.titleColor,
    required this.backgroundColor,
    required this.onPressed,
    super.key,
  });
  final VoidCallback? onPressed;
  final String logo;
  final String title;
  final Color titleColor;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(backgroundColor),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Stack(
            children: [
              Positioned(
                left: 50,
                child: Image(
                  image: AssetImage(logo),
                  height: 36,
                ),
              ),
              Container(
                height: 40,
                alignment: Alignment.center,
                padding: const EdgeInsets.only(left: 0),
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: titleColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
