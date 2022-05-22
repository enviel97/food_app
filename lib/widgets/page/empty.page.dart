import 'package:flutter/material.dart';
import 'package:food_shop/extentions/double.extension.dart';
import 'package:food_shop/helpers/functions.dart';
import 'package:food_shop/styles/colors.dart';
import 'package:food_shop/styles/spacing.dart';
import 'package:food_shop/widgets/texts/body_text.dart';

class Empty extends StatelessWidget {
  final String? title;
  const Empty({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: Padding(
            padding: EdgeInsets.all(15.0.h),
            child: BodyText(
              title ?? 'Your list is empty',
              color: kSecondaryColor,
              fontSize: Spacing.xl,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.bold,
            ),
          ),
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
