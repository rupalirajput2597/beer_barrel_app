import 'package:flutter/material.dart';

import '../../core/core.dart';
import '../product.dart';

class ProductDescriptionWithIngridents extends StatelessWidget {
  final Beer? beer;
  const ProductDescriptionWithIngridents({required this.beer, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      color: BBColor.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _titleDetailWidget(
            title: "Description",
            desc: beer?.description,
          ),
          const SizedBox(
            height: 20,
          ),
          _titleDetailWidget(
            title: "First Brewed",
            desc: beer?.firstBrewed,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Getting to know your beer better",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: BBColor.pageBackground,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          BeerIngredientsGridView(
            beer: beer,
          ),
        ],
      ),
    );
  }

  Widget _titleDetailWidget({required String? title, required String? desc}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$title",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: BBColor.pageBackground),
        ),
        const SizedBox(height: 12),
        Text(
          desc ?? "",
          style: TextStyle(
              height: 1.7,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: BBColor.secondaryGrey),
        ),
      ],
    );
  }
}
