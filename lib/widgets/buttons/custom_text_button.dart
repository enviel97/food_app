import 'package:flutter/material.dart';
import 'package:food_shop/extentions/double.extension.dart';
import 'package:food_shop/styles/colors.dart';
import 'package:food_shop/styles/spacing.dart';

class KTextButton extends StatelessWidget {
  final double height, width, radius, fontSize;
  final EdgeInsets? padding;
  final String text;
  final Color textColor, backgroundColor;
  final void Function()? onPressed;
  final Alignment textAlign;
  final bool disabled;

  const KTextButton(
    this.text, {
    Key? key,
    this.padding,
    this.backgroundColor = kPrimaryDarkColor,
    this.textColor = kBlackColor,
    this.onPressed,
    this.textAlign = Alignment.center,
    this.height = 36,
    this.width = 82,
    this.radius = 12,
    this.fontSize = Spacing.sm,
    this.disabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      primary: textColor,
      backgroundColor: backgroundColor,
      minimumSize: Size(width.w, height.h),
      padding: padding,
      elevation: 5.0,
      alignment: textAlign,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
    );

    return TextButton(
      style: flatButtonStyle,
      onPressed: disabled ? null : onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: kWhiteColor.withOpacity(disabled ? .85 : 1),
          fontSize: fontSize.h,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
