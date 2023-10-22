import 'package:beer_barrel/core/core.dart';
import 'package:flutter/material.dart';

import '../home.dart';

//Product-Card for HomeScreen
class ProductCard extends StatelessWidget {
  final Beer beer;
  const ProductCard(this.beer, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProductHeader(beer: beer),
        ProductBottomDetails(beer: beer),
      ],
    );
  }
}
