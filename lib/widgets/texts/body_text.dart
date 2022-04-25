part of './custom_text.dart';

class BodyText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize, lineSize;
  final FontWeight? fontWeight;
  final TextOverflow? textOverflow;
  final bool? softWrap;

  const BodyText(
    this.text, {
    Key? key,
    this.softWrap,
    this.color = kBlackColor,
    this.fontSize = Spacing.s,
    this.lineSize = 1.2,
    this.textOverflow = TextOverflow.ellipsis,
    this.fontWeight = FontWeight.normal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      style: style,
    );
  }
}
