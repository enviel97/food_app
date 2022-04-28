import 'package:flutter/material.dart';
import 'package:food_shop/styles/colors.dart';
import 'package:food_shop/styles/spacing.dart';

class HeaderText extends StatelessWidget {
  final String text;
  final Color color;
  final double? fontSize;
  final FontWeight fontWeight;
  final TextOverflow? textOverflow;
  final bool? softWrap;

  const HeaderText(
    this.text, {
    Key? key,
    this.softWrap,
    this.textOverflow = TextOverflow.fade,
    this.fontWeight = FontWeight.bold,
    this.color = kPrimaryDarkColor,
    this.fontSize = Spacing.lg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = DefaultTextStyle.of(context)
        .style
        .copyWith(fontSize: fontSize, fontWeight: fontWeight, color: color);
    return Text(
      text,
      softWrap: softWrap,
      maxLines: 1,
      overflow: textOverflow,
      style: style,
    );
  }
}
