import 'package:flutter/material.dart';

import '../../core/core.dart';

class ProductHeader extends StatelessWidget {
  final Beer? beer;
  const ProductHeader({required this.beer, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12),
        ),
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(
            AssetHelper.imageBackground,
          ),
        ),
      ),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: [
            NetworkImageWidget(
              imageUrl: beer?.imageUrl ?? "",
              height: 100,
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  3,
                ),
                color: BBColor.pageBackground,
              ),
              child: Text(
                'First Brewed: ${beer?.firstBrewed}',
                style: TextStyle(
                  color: BBColor.faintWhite,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
