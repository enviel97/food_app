import 'package:flutter/material.dart';
import 'package:bordered_text/bordered_text.dart' as lb;
import 'package:food_shop/extentions/double.extension.dart';
import 'package:food_shop/styles/colors.dart';

class BorderedText extends StatelessWidget {
  final String text;
  final double? fontSize, stockWidth;
  final Color colorText, colorStrock;

  const BorderedText(
    this.text, {
    Key? key,
    this.colorText = kWhiteColor,
    this.colorStrock = kBlackColor,
    this.fontSize,
    this.stockWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return lb.BorderedText(
      strokeColor: colorStrock,
      strokeWidth: stockWidth ?? 1.0,
      child: Text(
        text,
        style: TextStyle(
          color: colorText,
          fontSize: fontSize?.h,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.none,
          decorationStyle: TextDecorationStyle.wavy,
          decorationColor: colorStrock,
        ),
      ),
    );
  }
}
