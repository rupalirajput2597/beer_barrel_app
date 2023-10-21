import 'package:beer_barrel/core/core.dart';
import 'package:flutter/material.dart';

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _image(),
          _productDetail(),
        ],
      ),
    );
  }
}

Widget _image() {
  return Container(
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(12),
      ),
      image: DecorationImage(
        fit: BoxFit.fill,
        image: AssetImage(AssetHelper.imageBackground),
      ),
    ),
    child: Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          Image.asset(
            AssetHelper.beer1,
          ),
          const SizedBox(height: 5),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: BBColor.pageBackground,
            ),
            child: Text(
              'First Brewed: 09/2007',
              style: TextStyle(
                  color: BBColor.faintWhite,
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _productDetail() {
  return Container(
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
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 5.0),
          child: Text(
            "Pilsen Lager",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Text(
            "A light, crisp and bitter IPA brewed with English description adding to get the beer",
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: BBColor.secondaryGrey,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Row(
            children: [
              _infoRow('ABV', "4.5"),
              const SizedBox(width: 5),
              _infoRow('IBU', "60"),
            ],
          ),
        ),
        const SizedBox(height: 8)
      ],
    ),
  );
}

Widget _infoRow(String title, String value) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: BBColor.pageBackground),
      ),
      Text(
        value,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: BBColor.secondaryGrey,
        ),
      ),
    ],
  );
}
