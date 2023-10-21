import 'package:beer_barrel/core/core.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProductItemWidget extends StatelessWidget {
  final Beer beer;
  const ProductItemWidget(this.beer, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _image(beer),
        _productDetail(beer),
      ],
    );
  }
}

Widget _image(Beer beer) {
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
          SizedBox(
            height: 100,
            child: CachedNetworkImage(
              imageUrl: beer.imageUrl ?? "",
              fit: BoxFit.contain,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(
                child: CircularProgressIndicator(
                  value: downloadProgress.progress,
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          const SizedBox(height: 5),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 2,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: BBColor.pageBackground,
            ),
            child: Text(
              'First Brewed: ${beer.firstBrewed}',
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

Widget _productDetail(Beer beer) {
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
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 3),
          child: Text(
            "${beer.name}",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Text(
            "${beer.description}",
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
              _infoRow('ABV', beer.abv.toString()),
              const SizedBox(width: 5),
              _infoRow('IBU', beer.ibu.toString()),
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
