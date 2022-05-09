import 'package:flutter/material.dart';
import 'package:food_shop/extentions/double.extension.dart';
import 'package:food_shop/styles/colors.dart';
import 'package:food_shop/styles/spacing.dart';
import 'package:food_shop/views/app.dart';
import 'package:food_shop/views/home/styles/dimensions.dart';
import 'package:food_shop/widgets/buttons/custom_back_button.dart';
import 'package:food_shop/widgets/buttons/custom_icon_button.dart';
import 'package:get/get.dart';

class Header extends StatelessWidget with PreferredSizeWidget {
  const Header({Key? key}) : super(key: key);

  Widget _buildIconButton(
      {required IconData icon, required Function() onPressed}) {
    return KIconButton(
      icon: icon,
      size: Spacing.xxl,
      backgroundColor: kSecondaryColor,
      iconColor: kPlaceholderSuperDarkColor,
      onPressed: onPressed,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const KBackButton(backgroundColor: kPrimaryColor),
            Row(
              children: [
                _buildIconButton(
                  icon: Icons.home,
                  onPressed: () {
                    RouteHelper.goTo(RouteId.home);
                  },
                ),
                Spacing.horizantal.xs,
                _buildIconButton(
                  icon: Icons.payment_rounded,
                  onPressed: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(HomeDimensions.kHeader100);
}
