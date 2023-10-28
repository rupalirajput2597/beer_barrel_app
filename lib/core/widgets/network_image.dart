import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../core.dart';

//cached Network image widget
class NetworkImageWidget extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? width;
  final Widget? placeHolder;

  const NetworkImageWidget({
    required this.imageUrl,
    this.height,
    this.width,
    this.placeHolder,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: height,
        width: width,
        child: isStringValid(imageUrl)
            ? CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.contain,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      value: downloadProgress.progress,
                      color: BBColor.white,
                    )
                  ],
                ),
                errorWidget: (context, url, error) => _emptyPlaceHolder(),
              )
            : _emptyPlaceHolder());
  }

  Widget _emptyPlaceHolder() {
    return placeHolder ?? const Icon(Icons.error);
  }
}
