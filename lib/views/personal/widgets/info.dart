import 'package:flutter/material.dart';
import 'package:food_shop/extentions/double.extension.dart';
import 'package:food_shop/styles/colors.dart';
import 'package:food_shop/styles/spacing.dart';
import 'package:food_shop/widgets/texts/body_text.dart';

class Info extends StatelessWidget {
  final String label;
  final String value;
  const Info({
    required this.label,
    required this.value,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 15.0,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 15.0,
      ),
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0.h),
        ),
        boxShadow: [
          BoxShadow(
            color: kSecondaryLightColor.withOpacity(.3),
            blurRadius: 10,
            offset: const Offset(-5, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BodyText(
            label,
            fontSize: Spacing.m,
            color: kPlaceholderSuperDarkColor,
            fontWeight: FontWeight.w300,
            textAlign: TextAlign.left,
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              reverse: true,
              child: BodyText(
                value,
                fontSize: Spacing.m,
                fontWeight: FontWeight.bold,
                color: kPrimaryDarkColor,
                textAlign: TextAlign.right,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
