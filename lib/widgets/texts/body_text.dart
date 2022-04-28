import 'package:flutter/material.dart';
import 'package:food_shop/extentions/double_extension.dart';
import 'package:food_shop/styles/colors.dart';
import 'package:food_shop/styles/spacing.dart';

class BodyText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize, lineSize;
  final FontWeight? fontWeight;
  final TextOverflow? textOverflow;
  final bool? softWrap;
  final int? maxLines;

  const BodyText(
    this.text, {
    Key? key,
    this.softWrap,
    this.color = kDefaultTextColor,
    this.fontSize = Spacing.sm,
    this.lineSize = 1.5,
    this.textOverflow,
    this.fontWeight,
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fontSize = this.fontSize?.w;

    final style = DefaultTextStyle.of(context).style.copyWith(
          fontSize: fontSize,
          fontWeight: fontWeight,
          height: lineSize,
          color: color,
        );
    return Text(
      text,
      softWrap: softWrap,
      overflow: textOverflow,
      maxLines: maxLines,
      style: style,
    );
  }
}
