import 'package:flutter/material.dart';
import 'package:food_shop/extentions/double.extension.dart';
import 'package:food_shop/models/comment.dart';
import 'package:food_shop/styles/colors.dart';
import 'package:food_shop/styles/spacing.dart';
import 'package:food_shop/widgets/texts/body_text.dart';
import 'package:food_shop/widgets/texts/collapsable_text.dart';

class Body extends StatelessWidget {
  final List<Comment> comments;
  final String decription;
  final double price, rating;

  const Body({
    required this.decription,
    Key? key,
    this.comments = const [],
    this.price = 0.0,
    this.rating = 0.0,
  }) : super(key: key);

  Widget get _starRating => RichText(
        text: TextSpan(
          text: rating.toStringAsFixed(1),
          children: [
            const TextSpan(text: ' ⭐'),
          ],
          style: TextStyle(
            color: kBlackColor,
            fontSize: Spacing.m.h * 1.05,
            fontWeight: FontWeight.w400,
          ),
        ),
      );

  Widget get _price => RichText(
        text: TextSpan(
          text: 'Price: ',
          style: TextStyle(
            fontSize: Spacing.sm.h,
            color: kDefaultTextColor,
          ),
          children: [
            TextSpan(
              text: '$price\$',
              style: TextStyle(
                fontSize: Spacing.m.h,
                color: kBlackColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 10.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [_price, _starRating],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 15.0),
              child: BodyText(
                'Decription: ',
                color: kDefaultTextColor,
                fontSize: Spacing.sm,
              ),
            ),
            Flexible(
              child: CollapsableText(
                decription,
                color: kBlackColor,
                fontSize: Spacing.m,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
