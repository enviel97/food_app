import 'package:flutter/material.dart';
import 'package:food_shop/styles/colors.dart';
import 'package:food_shop/widgets/buttons/custom_icon_button.dart';

class FavoriteButton extends StatefulWidget {
  final bool isFavorite;
  final String foodId;
  const FavoriteButton({
    required this.foodId,
    Key? key,
    this.isFavorite = false,
  }) : super(key: key);

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return KIconButton(
      size: 45.0,
      elevation: 10.0,
      icon:
          isFavorite ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
      iconColor: kPinkColor,
      backgroundColor: kWhiteColor,
      shadowColor: kPinkColor,
      splashColor: kPinkColor,
      onPressed: _onPressed,
    );
  }

  void _onPressed() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }
}
