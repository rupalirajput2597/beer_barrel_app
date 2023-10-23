import 'package:flutter/material.dart';

import '../core.dart';

//Common header get used in Profile and Product screen
class HeaderOfProfileAndProductScreen extends StatelessWidget {
  final Widget child;
  const HeaderOfProfileAndProductScreen({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: BBColor.white,
      height: 280,
      child: Stack(
        alignment: Alignment.center,
        children: [
          _background(),
          child,
        ],
      ),
    );
  }

  Widget _background() {
    return Column(
      children: [
        Flexible(
          flex: 3,
          child: Container(
            decoration: BoxDecoration(
              color: BBColor.pageBackground,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
              ),
            ),
          ),
        ),
        const Spacer()
      ],
    );
  }
}
