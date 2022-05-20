import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_shop/extentions/double.extension.dart';
import 'package:food_shop/models/user.dart';
import 'package:food_shop/styles/colors.dart';
import 'package:food_shop/styles/dimensions.dart';

class Avatar extends StatelessWidget {
  final Gender gender;
  final String url;
  final double? size;

  const Avatar({
    required this.url,
    Key? key,
    this.gender = Gender.private,
    this.size,
  }) : super(key: key);

  Widget defaultAvatar(double size) {
    return DecoratedBox(
      decoration: const BoxDecoration(color: kWhiteColor),
      child: Image.asset(
        'assets/images/${gender.name}.png',
        fit: BoxFit.cover,
        filterQuality: FilterQuality.high,
      ),
    );
  }

  Widget _build(double size) {
    if (url.isEmpty) return defaultAvatar(size);
    return CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.cover,
      width: size,
      height: size,
      filterQuality: FilterQuality.high,
      errorWidget: (context, _, __) => defaultAvatar(size),
      placeholder: (context, _) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = (this.size ?? (Dimensions.kWidth * 0.425)).h;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size),
        boxShadow: [
          BoxShadow(
            color: kSecondaryColor.withOpacity(0.4),
            blurRadius: 10.0,
          )
        ],
      ),
      width: size,
      height: size,
      alignment: Alignment.center,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size),
        child: _build(size),
      ),
    );
  }
}
