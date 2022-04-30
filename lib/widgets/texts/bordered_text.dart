import 'package:flutter/material.dart';
import 'package:bordered_text/bordered_text.dart' as lb;
import 'package:food_shop/styles/colors.dart';

class BorderedText extends StatelessWidget {
  final String text;
  final Color colorText, colorStrock;

  const BorderedText(
    this.text, {
    Key? key,
    this.colorText = kWhiteColor,
    this.colorStrock = kBlackColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return lb.BorderedText(
      strokeColor: colorStrock,
      child: Text(
        text,
        style: TextStyle(
          color: colorText,
          decoration: TextDecoration.none,
          decorationStyle: TextDecorationStyle.wavy,
          decorationColor: colorStrock,
        ),
      ),
    );
  }
}
