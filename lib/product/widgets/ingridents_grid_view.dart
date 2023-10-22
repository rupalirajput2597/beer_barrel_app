import 'package:beer_barrel/product/widgets/ingrident_info_widget.dart';
import 'package:flutter/material.dart';

import '../../core/core.dart';

class BeerIngridentsGridView extends StatelessWidget {
  final Beer? beer;
  const BeerIngridentsGridView({required this.beer, super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, String?> ingridentContent = {
      "ABV": beer?.abv.toString(),
      "IBU": beer?.ibu.toString(),
      "Target FG": beer?.targetFg.toString(),
      "Target OG": beer?.targetOg.toString(),
      "EBC": beer?.ebc.toString(),
      "SRM": beer?.srm.toString(),
      "PH": beer?.ph.toString(),
      "ATTENUATION LEVEL": beer?.attenuationLevel.toString(),
    };

    return SizedBox(
      height: 250,
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        childAspectRatio: 3,
        children: ingridentContent.entries.map(
          (ingrident) {
            return IngridentsInfoWidget(
              ingrident: ingrident,
            );
          },
        ).toList(),
      ),
    );
  }
}
