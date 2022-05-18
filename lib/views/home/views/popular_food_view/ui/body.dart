import 'package:flutter/material.dart';
import 'package:food_shop/models/food.dart';
import 'package:food_shop/views/home/styles/dimensions.dart';
import 'package:food_shop/styles/colors.dart';
import 'package:food_shop/styles/spacing.dart';
import 'package:food_shop/views/home/widgets/food_infomation.dart';
import 'package:food_shop/widgets/texts/body_text.dart';
import 'package:food_shop/widgets/texts/collapsable_text.dart';
import 'package:food_shop/widgets/texts/header_text.dart';
import 'package:star_rating/star_rating.dart';

class Body extends StatelessWidget {
  final Food food;
  const Body({
    required this.food,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      height: HomeDimensions.kPopularFoodCard,
      decoration: const BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24.0),
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 5.0,
              color: kBlackColor,
              offset: Offset(0.0, -5.0),
            ),
            BoxShadow(
              color: kWhiteColor,
              offset: Offset(0.0, 10.0),
            )
          ]),
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 25.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderText(
            food.name,
            fontSize: Spacing.lg,
            color: kBlackColor,
          ),
          Spacing.vertical.xs,
          _ratingStar,
          Spacing.vertical.m,
          FoodInfomation(
            status: food.status,
            timePrepare: '${food.timePrepare}',
          ),
          Spacing.vertical.m,
          const BodyText(
            'Introduce',
            color: kBlackColor,
            fontSize: Spacing.m,
            fontWeight: FontWeight.w700,
          ),
          Spacing.vertical.m,
          Expanded(
            child: LayoutBuilder(builder: (context, constraints) {
              return CollapsableText(
                food.description,
                minimumHeight: constraints.maxHeight * 0.5,
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget get _ratingStar => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          StarRating(
            length: 5,
            rating: food.finalRate,
            color: kPrimaryDarkColor,
            starSize: Spacing.lg,
          ),
          BodyText(
            '${food.finalRate.toStringAsFixed(2)}'
            ' / '
            '${food.comments.length} comments',
            color: kPlaceholderSuperDarkColor.withOpacity(0.5),
          ),
        ],
      );
}
