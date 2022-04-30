import 'package:flutter/material.dart';
import 'package:food_shop/styles/colors.dart';
import 'package:food_shop/styles/constant.dart';
import 'package:food_shop/styles/dimensions.dart';
import 'package:food_shop/styles/spacing.dart';
import 'package:food_shop/widgets/lists/custom_single_child_scrollview.dart';
import 'package:food_shop/widgets/texts/body_text.dart';

class CollapsableText extends StatefulWidget {
  final String text;
  final bool hidden;
  final double? minimumHeight;
  final Color? color;
  final double fontSize;
  final void Function(bool isHidden)? onShowText;

  const CollapsableText(
    this.text, {
    Key? key,
    // default status of text is hidden
    this.hidden = true,

    // default height: screens / 2
    this.minimumHeight,
    this.onShowText,
    this.color,
    this.fontSize = Spacing.m,
  }) : super(key: key);

  @override
  State<CollapsableText> createState() => _CollapsableTextState();
}

class _CollapsableTextState extends State<CollapsableText> {
  final ScrollController _controller = ScrollController();
  late String firstHalf, secondHalf;
  late bool hindden;
  late double textHeight;

  @override
  void initState() {
    super.initState();
    textHeight = widget.minimumHeight ?? (Dimensions.kHeight / 5.63);
    hindden = widget.text.length > textHeight && widget.hidden;
    textState(hindden);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void textState(bool hidden) {
    if (hindden) {
      final _height = textHeight.toInt();
      firstHalf = widget.text.substring(0, _height);
      secondHalf = widget.text.substring(_height + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return KSingleChildScrollView(
      controller: _controller,
      child: Container(
        child: secondHalf.isEmpty
            ? BodyText(
                firstHalf,
                color: widget.color,
                fontSize: widget.fontSize,
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BodyText(
                    hindden ? (firstHalf + ' ...') : (firstHalf + secondHalf),
                    color: widget.color,
                    fontSize: widget.fontSize,
                  ),
                  InkWell(
                    onTap: _showMore,
                    child: BodyText(
                      hindden
                          ? 'Show more $kArrowDownSymbol'
                          : 'Show less $kArrowUpSymbol',
                      color: kSecondaryDarkColor,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
      ),
    );
  }

  void _showMore() {
    _controller.jumpTo(0.0);
    setState(() => hindden = !hindden);
    if (widget.onShowText != null) {
      widget.onShowText!(hindden);
    }
  }
}
