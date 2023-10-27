import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../core.dart';

//cached Network image widget
class NetworkImageWidget extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? width;

  const NetworkImageWidget({
    required this.imageUrl,
    this.height,
    this.width,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.contain,
        progressIndicatorBuilder: (context, url, downloadProgress) => Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              value: downloadProgress.progress,
              color: BBColor.grey,
            )
          ],
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}
