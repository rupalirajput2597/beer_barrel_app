import 'package:flutter/material.dart';

import '../../core/core.dart';
import '../home.dart';

class ProductBottomDetails extends StatelessWidget {
  final Beer? beer;
  const ProductBottomDetails({required this.beer, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: BBColor.white,
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title(),
          _description(),
          const Spacer(),
          _bottomRow(),
          const SizedBox(height: 8)
        ],
      ),
    ));
  }

  Widget _title() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 3),
      child: Text(
        "${beer?.name}",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: BBColor.pageBackground,
        ),
      ),
    );
  }

  Widget _description() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Text(
        "${beer?.description}",
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: BBColor.secondaryGrey,
        ),
      ),
    );
  }

  //product Info row
  Widget _bottomRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          InfoRow(title: 'ABV', value: beer?.abv.toString()),
          const SizedBox(
            width: 10,
          ),
          InfoRow(title: 'IBU', value: beer?.ibu.toString()),
        ],
      ),
    );
  }
}
