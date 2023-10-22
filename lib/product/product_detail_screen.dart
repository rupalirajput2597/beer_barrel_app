import 'package:flutter/material.dart';

import '../core/core.dart';
import 'product.dart';

class ProductDetailScreen extends StatelessWidget {
  final Beer selectedBeer;
  const ProductDetailScreen(this.selectedBeer, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BBColor.white,
      body: _content(context),
    );
  }

  Widget _content(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomBackButton(),
          _scrollableView(context),
        ],
      ),
    );
  }

  Widget _scrollableView(BuildContext context) {
    return Flexible(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _header(context),
            ProductDescriptionWithIngridents(
              beer: selectedBeer,
            ),
          ],
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return HeaderOfProfileAndProductScreen(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _productTitle(context, selectedBeer.name ?? "name",
                selectedBeer.tagline ?? "tagline"),
            _previewImage(context)
          ],
        ),
      ),
    );
  }

  Widget _productTitle(BuildContext context, String name, String tagline) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: BBColor.primaryGrey,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Text(
          tagline,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: BBColor.secondaryGrey,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        )
      ],
    );
  }

  Widget _previewImage(BuildContext context) {
    return Center(
      child: Container(
        height: 188,
        margin: const EdgeInsets.symmetric(vertical: 16),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: BBColor.grey,
        ),
        child: NetworkImageWidget(
          imageUrl: selectedBeer.imageUrl ?? "",
        ),
      ),
    );
  }
}
