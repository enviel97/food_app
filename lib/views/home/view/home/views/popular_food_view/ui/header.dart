import 'package:flutter/material.dart';
import 'package:food_shop/styles/colors.dart';
import 'package:food_shop/styles/spacing.dart';
import 'package:food_shop/widgets/buttons/custom_back_button.dart';
import 'package:food_shop/widgets/buttons/custom_icon_button.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const KBackButton(),
          KIconButton(
            size: Spacing.xxl,
            icon: Icons.shopping_cart_outlined,
            iconColor: kPlaceholderSuperDarkColor,
            backgroundColor: kWhiteColor.withOpacity(0.6),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
