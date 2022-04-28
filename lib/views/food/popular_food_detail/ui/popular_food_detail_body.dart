import 'package:flutter/material.dart';
import 'package:food_shop/models/food.dart';
import 'package:food_shop/styles/colors.dart';
import 'package:food_shop/styles/spacing.dart';
import 'package:food_shop/views/food/styles/dimensions.dart';
import 'package:food_shop/views/home/widgets/food_infomation.dart';
import 'package:food_shop/widgets/texts/body_text.dart';
import 'package:food_shop/widgets/texts/header_text.dart';
import 'package:star_rating/star_rating.dart';

class PopularFoodDetailBody extends StatelessWidget {
  final Food food;
  const PopularFoodDetailBody({
    required this.food,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: FoodDimensions.kPopularFoodCard,
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
            fontSize: Spacing.m,
            fontWeight: FontWeight.w500,
          ),
          Spacing.vertical.xs,
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