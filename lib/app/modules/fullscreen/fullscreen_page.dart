import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:octo_image/octo_image.dart';

class FullScreenPage extends StatelessWidget {
  const FullScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String imageUrl = Get.arguments[0];
    return InkWell(
      onTap: () => Get.back(),
      child: Center(
        child: Hero(
          tag: imageUrl,
          child: OctoImage(
            image: CachedNetworkImageProvider(
              imageUrl,
            ),
            errorBuilder: OctoError.icon(color: Colors.red),
            fit: BoxFit.cover,
            progressIndicatorBuilder: (context, progress) {
              double value = 0;
              if (progress != null && progress.expectedTotalBytes != null) {
                value = progress.cumulativeBytesLoaded /
                    progress.expectedTotalBytes!.toInt();
              }
              return Center(
                child: SizedBox(
                  width: 14,
                  height: 14,
                  child: CircularProgressIndicator(value: value),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
