import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:food_shop/styles/colors.dart';
import 'package:food_shop/styles/spacing.dart';
import 'package:food_shop/widgets/buttons/custom_icon_button.dart';
import 'package:get/get.dart';

class CartButton extends StatelessWidget {
  final bool isShowBadge;
  final int quantity;
  final Color? backgroundColor, iconColor;
  final double? size;
  final void Function() onPressed;

  const CartButton({
    required this.isShowBadge,
    required this.quantity,
    required this.onPressed,
    Key? key,
    this.backgroundColor,
    this.iconColor,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        this.backgroundColor ?? kWhiteColor.withOpacity(0.6);
    final iconColor = this.iconColor ?? kPlaceholderSuperDarkColor;

    return Badge(
      toAnimate: false,
      padding: const EdgeInsets.all(8.0),
      position: BadgePosition.topEnd(top: -10, end: -5),
      showBadge: isShowBadge,
      badgeContent: Text(
        '$quantity',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: kWhiteColor,
        ),
      ),
      child: KIconButton(
        size: size ?? Spacing.xxl,
        icon: Icons.shopping_cart_outlined,
        iconColor: iconColor,
        backgroundColor: backgroundColor,
        shadowColor: backgroundColor,
        onPressed: () {
          if (isShowBadge) {
            onPressed();
            return;
          }

          if (!Get.isSnackbarOpen) {
            Get.snackbar(
              'Notice',
              "Don't have any item in cart",
              snackPosition: SnackPosition.BOTTOM,
            );
          }
        },
      ),
    );
  }
}
