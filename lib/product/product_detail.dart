import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/core.dart';

class ProductDetailScreen extends StatelessWidget {
  final Beer selectedItem;
  const ProductDetailScreen(this.selectedItem, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _content(context),
    );
  }

  Widget _productTitle(BuildContext context, String name, String tagline) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          maxLines: 1,
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
          maxLines: 1,
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

  Widget _productDetails(context, Beer? selectedItem) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: BBColor.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _titleDetailWidget(
              title: "Description", desc: selectedItem?.description),
          const SizedBox(
            height: 20,
          ),
          _titleDetailWidget(
              title: "First Brewed", desc: selectedItem?.firstBrewed),
          const SizedBox(
            height: 20,
          ),
          Text("Getting to know your beer better",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: BBColor.pageBackground)),
          const SizedBox(
            height: 16,
          ),
          _moreInfo(selectedItem),
        ],
      ),
    );
  }

  _customeBack(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: GestureDetector(
        onTap: () {
          context.pop();
        },
        child: Container(
          margin: const EdgeInsets.only(left: 16),
          height: 36,
          width: 36,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: const DecorationImage(
                image: AssetImage(AssetHelper.backIcon),
              ),
              color: BBColor.white),
        ),
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
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: BBColor.secondaryGrey),
        ),
      ],
    );
  }

  Widget _header(BuildContext context) {
    return Container(
      color: BBColor.white,
      height: MediaQuery.of(context).size.height * 0.35,
      child: Stack(
        children: [
          _headerBg(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _productTitle(context, selectedItem.name ?? "name",
                    selectedItem.tagline ?? "tagline"),
                _previewImage(context)
              ],
            ),
          ),
        ],
      ),
    );
  }

  _moreInfo(Beer? currentItem) {
    Map<String, String?> ingridentContent = {
      "ABV": currentItem?.abv.toString(),
      "IBU": currentItem?.ibu.toString(),
      "Target FG": currentItem?.targetFg.toString(),
      "Target OG": currentItem?.targetOg.toString(),
      "EBC": currentItem?.ebc.toString(),
      "SRM": currentItem?.srm.toString(),
      "PH": currentItem?.ph.toString(),
      "ATTENUATION LEVEL": currentItem?.attenuationLevel.toString(),
    };

    return SizedBox(
      height: 250,
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        childAspectRatio: 3,
        children: ingridentContent.entries.map((entry) {
          return ingridentsInfo(
            entry,
          );
        }).toList(),
      ),
    );
  }

  Widget ingridentsInfo(MapEntry<String, String?> entry) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          margin: const EdgeInsets.only(right: 8),
          height: 36,
          width: 36,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: BBColor.pageBackground),
          child: Image.asset(AssetHelper.cheersImage),
        ),
        Flexible(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                entry.key,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: BBColor.pageBackground,
                ),
              ),
              Text(
                entry.value.toString(),
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: BBColor.secondaryGrey),
              ),
            ],
          ),
        )
      ],
    );
  }

  _scrollableView(BuildContext context) {
    return Flexible(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _header(context),
            _productDetails(context, selectedItem),
          ],
        ),
      ),
    );
  }

  Widget _previewImage(BuildContext context) {
    return Center(
      child: Container(
        //height: MediaQuery.of(context).size.height * 0.24, //200
        height: 200,
        margin: const EdgeInsets.symmetric(vertical: 16),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: BBColor.grey,
        ),
        child: CachedNetworkImage(
          imageUrl: selectedItem.imageUrl ?? "",
          fit: BoxFit.contain,
          progressIndicatorBuilder: (context, url, downloadProgress) => Center(
            child: CircularProgressIndicator(
              value: downloadProgress.progress,
            ),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }

  Widget _headerBg() {
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

  Widget _content(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _customeBack(context),
          _scrollableView(context),
        ],
      ),
    );
  }
}
