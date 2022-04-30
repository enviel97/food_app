import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:food_shop/extentions/double_extension.dart';
import 'package:food_shop/styles/colors.dart';

class LazzyImages extends StatelessWidget {
  final String url;
  final double? height, width, radius;

  const LazzyImages(
    this.url, {
    Key? key,
    this.height,
    this.width = double.infinity,
    this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? 0),
      child: CachedNetworkImage(
        imageUrl: url,
        height: height?.h,
        width: width?.h,
        fit: BoxFit.cover,
        errorWidget: (_, url, error) {
          debugPrint('Url: $url, Image Loadding error $error');
          return const Center(child: Text('Error image'));
        },
        placeholder: (_, url) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: kPlaceholderDarkColor,
              valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
            ),
          );
        },
      ),
    );
  }
}
