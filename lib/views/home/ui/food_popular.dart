import 'package:flutter/material.dart';
import 'package:food_shop/models/food.dart';
import 'package:food_shop/views/app.dart';
import 'package:food_shop/views/home/controllers/recommended_food.controller.dart';
import 'package:food_shop/views/home/styles/dimensions.dart';
import 'package:food_shop/styles/colors.dart';
import 'package:food_shop/styles/spacing.dart';
import 'package:food_shop/widgets/images/lazy_images.dart';
import 'package:food_shop/widgets/lists/custom_listview.dart';
import 'package:food_shop/widgets/texts/body_text.dart';
import 'package:food_shop/widgets/texts/header_text.dart';
import 'package:get/get.dart';

import '../widgets/food_infomation.dart';

class FoodPopular extends StatelessWidget {
  const FoodPopular({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const BodyText(
                'Recommended',
                color: kBlackColor,
                fontSize: Spacing.m,
                fontWeight: FontWeight.bold,
              ),
              Spacing.horizantal.xs,
              const BodyText('Food parring', color: kPlaceholderDarkColor),
            ],
          ),
          Spacing.vertical.lg,
          Flexible(
            child: GetBuilder<RecommendedFoodConroller>(
              builder: (RecommendedFoodConroller controller) {
                if (!controller.isLoaded && !controller.isError) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (controller.isError) {
                  return const Center(child: HeaderText('Error get foods'));
                }
                return KListView<Food>(
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  datas: controller.recommendedFoodList,
                  padding: const EdgeInsets.all(8.0),
                  itemBuilder: _itemBuilder,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemBuilder(Food data, int index) {
    final size = HomeDimensions.kListFoodImages;
    const radius = 15.0;
    return GestureDetector(
      onTap: () => RouteHelper.goTo(RouteId.getRecommendedFood(data.id)),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LazzyImages(
              data.images[0],
              height: size,
              width: size,
              radius: radius,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 5.0,
                ),
                decoration: const BoxDecoration(
                  color: kWhiteColor,
                  borderRadius: BorderRadius.horizontal(
                    right: Radius.circular(radius),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BodyText(
                      data.name,
                      fontWeight: FontWeight.bold,
                    ),
                    BodyText(
                      data.description,
                      color: kPlaceholderDarkColor,
                      maxLines: 2,
                    ),
                    FoodInfomation(
                      status: data.status,
                      timePrepare: '${data.timePrepare}',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
