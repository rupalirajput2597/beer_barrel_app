import 'package:beer_barrel/product/widgets/ingredient_info_widget.dart';
import 'package:flutter/material.dart';

import '../../core/core.dart';

class BeerIngredientsGridView extends StatelessWidget {
  final Beer? beer;
  const BeerIngredientsGridView({required this.beer, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        childAspectRatio: 3,
        children: (beer?.getIngredientsMap())!.entries.map(
          (ingredient) {
            return IngredientsInfoWidget(
              ingredient: ingredient,
            );
          },
        ).toList(),
      ),
    );
  }
}
