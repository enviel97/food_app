import 'package:flutter/material.dart';
import 'package:food_shop/extentions/double.extension.dart';
import 'package:food_shop/styles/colors.dart';
import 'package:food_shop/styles/spacing.dart';
import 'package:get/get.dart';

class KTextButton extends StatelessWidget {
  final double height, width, radius, fontSize;
  final EdgeInsets? padding;
  final String text;
  final Color textColor, backgroundColor;
  final void Function()? onPressed;
  final Alignment textAlign;
  final bool disabled, isOutline;

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
    this.isOutline = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        isOutline ? Get.theme.scaffoldBackgroundColor : this.backgroundColor;
    final textColor = isOutline ? this.backgroundColor : kWhiteColor;

    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      primary: this.textColor,
      backgroundColor: backgroundColor,
      minimumSize: Size(width.w, height.h),
      padding: padding,
      elevation: 5.0,
      alignment: textAlign,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius.h),
        side: BorderSide(color: this.backgroundColor),
      ),
    );

    return TextButton(
      style: flatButtonStyle,
      onPressed: disabled ? null : onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: textColor.withOpacity(disabled ? .85 : 1),
          fontSize: fontSize.h,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
