import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:food_shop/styles/colors.dart';
import 'package:food_shop/styles/spacing.dart';
import 'package:food_shop/widgets/buttons/custom_icon_button.dart';

class CartButton extends StatelessWidget {
  final bool isShowBadge;
  final int quantity;

  const CartButton({
    required this.isShowBadge,
    required this.quantity,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Badge(
      toAnimate: false,
      padding: const EdgeInsets.all(8.0),
      showBadge: isShowBadge,
      badgeContent: Text(
        '$quantity',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: kWhiteColor,
        ),
      ),
      child: KIconButton(
        size: Spacing.xxl,
        icon: Icons.shopping_cart_outlined,
        iconColor: kPlaceholderSuperDarkColor,
        backgroundColor: kWhiteColor.withOpacity(0.6),
        onPressed: () {},
      ),
    );
  }
}
