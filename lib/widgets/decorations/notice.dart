import 'package:flutter/material.dart';
import 'package:food_shop/styles/colors.dart';
import 'package:food_shop/styles/spacing.dart';
import 'package:food_shop/widgets/texts/custom_text.dart';

class Notice extends StatelessWidget {
  final String explain;
  final IconData icon;
  final Color iconColor;

  const Notice({
    required this.explain,
    required this.icon,
    Key? key,
    this.iconColor = kPrimaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: iconColor),
        Spacing.horizantal.xs,
        BodyText(
          explain,
          fontWeight: FontWeight.w300,
        ),
      ],
    );
  }
}
