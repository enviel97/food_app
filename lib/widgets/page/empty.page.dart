import 'package:flutter/material.dart';
import 'package:food_shop/helpers/functions.dart';
import 'package:food_shop/styles/colors.dart';
import 'package:food_shop/styles/spacing.dart';
import 'package:food_shop/widgets/texts/header_text.dart';

class Empty extends StatelessWidget {
  const Empty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const HeaderText(
          'Your list is empty',
          color: kSecondaryColor,
          fontSize: Spacing.xl,
        ),
        Spacing.vertical.xxl,
        Image.asset(
          getAssetImagePath('empty'),
          fit: BoxFit.cover,
        ),
      ],
    );
  }
}
