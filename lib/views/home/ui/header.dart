import 'package:flutter/material.dart';
import 'package:food_shop/styles/colors.dart';
import 'package:food_shop/widgets/buttons/neumorphism_button.dart';
import 'package:food_shop/widgets/texts/custom_text.dart';

class Header extends StatelessWidget with PreferredSizeWidget {
  final double size;

  const Header({
    Key? key,
    this.size = 100.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeaderText('Viet Nam', fontWeight: FontWeight.bold),
                const BodyText(
                  'Ho Chi Minh city',
                  color: kPlaceholderSuperDarkColor,
                ),
              ],
            ),
          ),
          const NeumorphismButton(
            size: 48.0,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Icon(
                Icons.search,
                color: kBlackColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(size);
}
